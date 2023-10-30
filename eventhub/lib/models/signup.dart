import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String loginModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
  });

  String username;
  String password;
  String fullname;
  String email;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
      username: json["Username"],
      password: json["Password"],
      fullname: json["FullName"],
      email: json["Email"]);

  Map<String, dynamic> toJson() => {
        "Username": username,
        "Password": password,
        "FullName": fullname,
        "Email": email
      };
}
