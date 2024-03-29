import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String email;
  String image;
  String uid;
  int plan;
  final bool astro;
  String phNo;
  String upiID;

  User(
    this.name,
    this.email,
    this.image,
    this.plan,
    this.uid,
    this.astro,
    this.phNo,
    this.upiID,
  );

  factory User.fromJson(json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "User(name :$name , email :$email , image : $image ,uid : $uid ,plan: $plan ,astro: $astro ,phno: $phNo , upi : $upiID)";
  }
}
