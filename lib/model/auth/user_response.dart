import 'package:json_annotation/json_annotation.dart';

//part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final bool success;
  final String message;
  final UserData data;

  UserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  // factory UserResponse.fromJson(Map<String, dynamic> json) =>
  //     _$UserResponseFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: "_id")
  final String id;
  final String mobile;
  final String fullName;
  final String email;
  final bool emailVerified;
  final String addressId;
  final List<dynamic> address;
  @JsonKey(name: "__v")
  final int version;

  UserData({
    required this.id,
    required this.mobile,
    required this.fullName,
    required this.email,
    required this.emailVerified,
    required this.addressId,
    required this.address,
    required this.version,
  });

  // factory UserData.fromJson(Map<String, dynamic> json) =>
  //     _$UserDataFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
