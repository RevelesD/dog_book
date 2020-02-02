import 'package:dog_book/model/Breed.dart';

class User {
  final String id;
  final String name;
  final String birthday;
  final String email;
  Breed breed;
  User({
    this.id,
    this.name,
    this.birthday,
    this.email,
    this.breed,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var newbreed = Breed(
      name: json['breed']['name'],
      path: json['breed']['path']
    );

    return User(
      email: json['email'],
      birthday: json['birthday'],
      id: json['_id'],
      name: json['name'],
      breed: newbreed
    );
  }
}
