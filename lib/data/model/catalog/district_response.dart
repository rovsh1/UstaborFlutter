class DistrictResponse {
  String? date;
  Status? status;
  List<District>? result;

  DistrictResponse({
      this.date, 
      this.status, 
      this.result});

  DistrictResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(District.fromJson(v));
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

class District {
  String? name;
  String? urlname;
  int? cityId;
  int? id;
  String? cityName;

  District({
      this.name, 
      this.urlname, 
      this.cityId, 
      this.id, 
      this.cityName});

  District.fromJson(dynamic json) {
    name = json['name'];
    urlname = json['urlname'];
    cityId = json['city_id'];
    id = json['id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['urlname'] = urlname;
    map['city_id'] = cityId;
    map['id'] = id;
    map['city_name'] = cityName;
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