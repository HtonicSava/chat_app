import 'package:json_annotation/json_annotation.dart';

part 'user_name.g.dart';

@JsonSerializable()
class UserName {
  const UserName({required this.firstName, required this.lastName});

  final String firstName;
  final String lastName;

  factory UserName.fromJson(Map<String, dynamic> json) =>
      _$UserNameFromJson(json);
  Map<String, dynamic> toJson() => _$UserNameToJson(this);
}
