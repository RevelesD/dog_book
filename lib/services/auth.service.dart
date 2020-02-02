import 'package:rxdart/rxdart.dart';
import 'package:dog_book/model/user.dart';
import 'package:dog_book/model/Breed.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const address = '192.168.1.72';

class Auth {
  BehaviorSubject _user = BehaviorSubject.seeded(null);
  BehaviorSubject _token = BehaviorSubject.seeded('');

  get userStream$ => _user.stream;
  User get userCurrent => _user.value;

  get tokenStream$ => _token.stream;
  String get tokenCurrent => _token.value;

  Future<bool> login(String email, String pass) async {
    String token = await fetchSignIn(email, pass);
    if (token == '') {
      return false;
    }
    Map<String, dynamic> decodedToken = parseJwt(token);
    User user = await fetchUser(decodedToken['user_id']);
    _user.add(user);
    return true;
  }

  logOut() {
    _user.add(null);
    _token.add('');
  }

  signUp(String email,
      String password,
      String name,
      Breed breed,
      String birthday,) async {
    String token = await fetchSignUp(email, password, name, breed, birthday);
    _token.add(token);
    Map<String, dynamic> decodedToken = parseJwt(token);
    User user = await fetchUser(decodedToken['user_id']);
    _user.add(user);
  }
}

Future<String> fetchSignIn(String email, String pass) async {
  var response = await http.post('http://$address:8080/api/v1/auth/signin',
      body: jsonEncode({'email': email, 'password': pass}));

  if (response.statusCode == 200) {
    var token = jsonDecode(response.body);
    return token;
  } else if (response.statusCode == 401) {
    return '';
  } else {
    throw Exception('Failed to reach server');
  }
}

Future<User> fetchUser(String id) async {
  var response = await http.get('http://$address:8080/api/v1/user/id/$id');
  if (response.statusCode == 200) {
    var userJson = jsonDecode(response.body);
    User user = User.fromJson(userJson);
    return user;
  } else {
    throw Exception('Failed to fetch user');
  }
}

Future<String> fetchSignUp(
  String email,
  String password,
  String name,
  Breed breed,
  String birthday,
) async {
  var response = await http.post(
    'http://$address:8080/api/v1/auth/signup',
    body: jsonEncode({
      'email': email,
      'password': password,
      'name': name,
      'breed': {
        'name': breed.name,
        'path': breed.path
      },
      'birthday': birthday
    })
  );
  if (response.statusCode == 200) {
    var token = jsonDecode(response.body);
    return token;
  } else {
    throw Exception('Failed to rech server');
  }

}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}