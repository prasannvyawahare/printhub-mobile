class GooggleSignInRequest {
  GooggleSignInRequest({
      this.type, 
      this.email,});

  GooggleSignInRequest.fromJson(dynamic json) {
    type = json['type'];
    email = json['email'];
  }
  String? type;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['email'] = email;
    return map;
  }

}