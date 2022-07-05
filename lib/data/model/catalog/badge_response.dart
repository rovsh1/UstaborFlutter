class BadgeResponse {
  String? date;
  Status? status;
  List<Badge>? result;

  BadgeResponse({
      this.date, 
      this.status, 
      this.result});

  BadgeResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Badge.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['date'] = date;
    if (status != null) {
      map['status'] = status?.toJson();
    }
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Badge {
  int? id;
  String? key;
  String? name;
  String? text;

  Badge({
      this.id, 
      this.key, 
      this.name, 
      this.text});

  Badge.fromJson(dynamic json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['key'] = key;
    map['name'] = name;
    map['text'] = text;
    return map;
  }

}

class Status {
  String? code;
  String? message;

  Status({
      this.code, 
      this.message});

  Status.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}