import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  final String mobile;
  final String email;

  UserRequest({required this.mobile, required this.email});

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);


}
