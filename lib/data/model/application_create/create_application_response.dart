class CreateApplicationResponse {
  CreateApplicationResponse({
      this.date, 
      this.status, 
      this.result,});

  CreateApplicationResponse.fromJson(dynamic json) {
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
      this.id, 
      this.userId, 
      this.token,});

  Result.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    token = json['token'];
  }
  int? id;
  int? userId;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['token'] = token;
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