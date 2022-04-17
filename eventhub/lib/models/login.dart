import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        username: json["Username"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "Password": password,
      };
}
