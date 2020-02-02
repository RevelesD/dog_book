import 'package:flutter/cupertino.dart';

class TokenPayload {
  String userId;
  double exp;
  TokenPayload({@required this.userId, @required this.exp});

  factory TokenPayload.fromJson(Map<String, dynamic> json) {
    return TokenPayload(
      userId: json['user_id'],
      exp: json['exp'],
    );
  }
}