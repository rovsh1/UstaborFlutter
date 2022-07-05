class CityResponse {
  String? date;
  Status? status;
  List<City>? result;

  CityResponse({
      this.date, 
      this.status, 
      this.result});

  CityResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(City.fromJson(v));
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

class City {
  String? name;
  String? urlname;
  int? countryId;
  int? id;
  String? countryName;

  City({
      this.name, 
      this.urlname, 
      this.countryId, 
      this.id, 
      this.countryName});

  City.fromJson(dynamic json) {
    name = json['name'];
    urlname = json['urlname'];
    countryId = json['country_id'];
    id = json['id'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['urlname'] = urlname;
    map['country_id'] = countryId;
    map['id'] = id;
    map['country_name'] = countryName;
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