import 'dart:convert';

import 'package:dog_book/model/Breed.dart';
import 'package:dog_book/services/models/ProfileDog.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'package:dog_book/services/models/RandomDogList.dart';

const address = '192.168.1.72';

class Dogs {
  BehaviorSubject _profileDog = BehaviorSubject.seeded('');
  BehaviorSubject _randomDogs = BehaviorSubject.seeded([]);
  BehaviorSubject _breedDogs = BehaviorSubject.seeded([]);
  BehaviorSubject _breedList = BehaviorSubject.seeded([]);

  get breedListStream$ => _breedList.stream;
  List<Breed> get breedListCurrent => _breedList.value;

  get profileStream$ => _profileDog.stream;
  String get profileCurrent => _profileDog.value;

  get randomStream$ => _randomDogs.stream;
  List<String> get randomCurrent => _profileDog.value;

  get breedStream$ => _breedDogs.stream;
  List<String> get breedCurrent => _breedDogs.value;

  loadBreedList() async {
    var breeds = await fetchBreedList();
    _breedList.add(breeds);
  }

  loadProfile(String breed) async {
    var dog = await fetchProfilePic(breed);
    _profileDog.add(dog.message);
  }

  getBreedDogs(String breed) async {
    var dogs = await fetchBreedDogs(breed);
    _breedDogs.add(dogs.message);
  }

  getRandomDogs() async {
    var dogs = await fetchRandomDogs();
    _randomDogs.add(dogs.message);
  }
}

Future<List<Breed>> fetchBreedList() async {
  var response = await http.get('http://$address:8080/api/v1/dog/getBreedList');
  if (response.statusCode == 200) {
    Iterable jsonList = json.decode(response.body);
    List<Breed> list = [];
    jsonList.map((b) {
      var mini = Breed.fromJson(b);
      list.add(mini);
    }).toList();
    return list;
  } else {
    throw Exception('Failed to load post');
  }
}

Future<ProfileDog> fetchProfilePic(String breed) async {
  final response =
      await http.get('https://dog.ceo/api/breed/$breed/images/random');
  if (response.statusCode == 200) {
    var jsonDon = jsonDecode(response.body);
    ProfileDog dog = ProfileDog.fromJson(jsonDon);
    print(dog);
    return dog;
  } else {
    throw Exception('Failed to load post');
  }
}

Future<RandomDogList> fetchRandomDogs() async {
  final response =
      await http.get('http://$address:8080/api/v1/dog/getDogsRandom');
  if (response.statusCode == 200) {
    var jsonDon = json.decode(response.body);
    RandomDogList dogs = RandomDogList.fromJson(jsonDon);
    return dogs;
  } else {
    throw Exception('Failed to load post');
  }
}

Future<RandomDogList> fetchBreedDogs(String breed) async {
  final response =
      await http.get('https://dog.ceo/api/breed/$breed/images/random/20');
  if (response.statusCode == 200) {
    var jsonDon = json.decode(response.body);
    RandomDogList dogs = RandomDogList.fromJson(jsonDon);
    return dogs;
  } else {
    throw Exception('Failed to load post');
  }
}
