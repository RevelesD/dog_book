class ProfileDog {
  final String message;
  final String status;
  ProfileDog({this.message, this.status});

  factory ProfileDog.fromJson(Map json) {
    return ProfileDog(
        message: json['message'],
        status: json['status']
    );
  }
}