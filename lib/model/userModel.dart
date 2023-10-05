import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

//flutter pub run build_runner build
@JsonSerializable()
class User {
  String? email;
  String? username;
  String? password;
  String? country;

  User({
    this.email,
    this.username,
    this.password,
    this.country,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

