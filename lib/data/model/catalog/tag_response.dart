class TagResponse {
  TagResponse({
      this.date, 
      this.status, 
      this.result,});

  TagResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Tag.fromJson(v));
      });
    }
  }
  String? date;
  Status? status;
  List<Tag>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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

class Tag {
  Tag({
      this.id, 
      this.countryId, 
      this.categoryId, 
      this.language, 
      this.text, 
      this.categoryUrlname,});

  Tag.fromJson(dynamic json) {
    id = json['id'];
    countryId = json['country_id'];
    categoryId = json['category_id'];
    language = json['language'];
    text = json['text'];
    categoryUrlname = json['category_urlname'];
  }
  int? id;
  dynamic countryId;
  int? categoryId;
  String? language;
  String? text;
  String? categoryUrlname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country_id'] = countryId;
    map['category_id'] = categoryId;
    map['language'] = language;
    map['text'] = text;
    map['category_urlname'] = categoryUrlname;
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