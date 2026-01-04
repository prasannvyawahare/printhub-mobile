class GoogleSignInResponce {
  GoogleSignInResponce({
      this.success, 
      this.message, 
      this.userId,});

  GoogleSignInResponce.fromJson(dynamic json) {
    success = json['Success'];
    message = json['message'];
    userId = json['user_id'];
  }
  String? success;
  String? message;
  int? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Success'] = success;
    map['message'] = message;
    map['user_id'] = userId;
    return map;
  }

}