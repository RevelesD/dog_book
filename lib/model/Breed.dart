class Breed {
  final String name;
  final String path;
  Breed({
    this.name,
    this.path,
  });
  factory Breed.fromJson(json) {
    var breed = Breed(
      name: json['name'],
      path: json['path'],
    );
    return breed;
  }
}
