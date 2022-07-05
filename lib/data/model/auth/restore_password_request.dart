class RestorePasswordRequest {
  RestorePasswordRequest({
      this.login,});

  RestorePasswordRequest.fromJson(dynamic json) {
    login = json['login'];
  }
  String? login;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['login'] = login;
    return map;
  }

}