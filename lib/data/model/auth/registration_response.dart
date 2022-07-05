class RegistrationResponse {
  RegistrationResponse({
      this.date, 
      this.status, 
      this.result,});

  RegistrationResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? date;
  Status? status;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    if (status != null) {
      map['status'] = status?.toJson();
    }
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

class Result {
  Result({
      this.token, 
      this.userId,});

  Result.fromJson(dynamic json) {
    token = json['token'];
    userId = json['user_id'];
  }
  String? token;
  int? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['user_id'] = userId;
    return map;
  }

}

class Status {
  Status({
      this.code, 
      this.message,});

  Status.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
  }
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}