// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: UserData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  id: json['_id'] as String,
  mobile: json['mobile'] as String,
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  emailVerified: json['emailVerified'] as bool,
  addressId: json['addressId'] as String,
  address: json['address'] as List<dynamic>,
  version: (json['__v'] as num).toInt(),
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  '_id': instance.id,
  'mobile': instance.mobile,
  'fullName': instance.fullName,
  'email': instance.email,
  'emailVerified': instance.emailVerified,
  'addressId': instance.addressId,
  'address': instance.address,
  '__v': instance.version,
};
