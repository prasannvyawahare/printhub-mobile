class GoogleSignInResponce1 {
  GoogleSignInResponce1({
      this.success, 
      this.message, 
      this.userId, 
      this.randomGenNo,});

  GoogleSignInResponce1.fromJson(dynamic json) {
    success = json['Success'];
    message = json['message'];
    userId = json['user_id'];
    randomGenNo = json['random_gen_no'];
  }
  String? success;
  String? message;
  int? userId;
  String? randomGenNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Success'] = success;
    map['message'] = message;
    map['user_id'] = userId;
    map['random_gen_no'] = randomGenNo;
    return map;
  }

}