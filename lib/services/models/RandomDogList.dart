class RandomDogList {
  final List<String> message;
  final String status;
  RandomDogList({this.message, this.status});

  factory RandomDogList.fromJson(Map<String, dynamic> json) {
    return RandomDogList(
        message: List<String>.from(json['message']),
        status: json['status']
    );
  }
}