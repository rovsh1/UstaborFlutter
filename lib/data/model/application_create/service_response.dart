class ServiceResponse {
  String? date;
  Status? status;
  List<Service>? result;

  ServiceResponse({
      this.date, 
      this.status, 
      this.result});

  ServiceResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Service.fromJson(v));
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

class Service {
  int? id;
  int? categoryId;
  String? name;
  dynamic units;
  String? question;
  String? hasPrices;
  String? siteId;
  String? categoryName;
  Prices? prices;

  Service({
      this.id, 
      this.categoryId, 
      this.name, 
      this.units, 
      this.question, 
      this.hasPrices, 
      this.siteId, 
      this.categoryName, 
      this.prices});

  Service.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    units = json['units'];
    question = json['question'];
    hasPrices = json['has_prices'];
    siteId = json['site_id'];
    categoryName = json['category_name'];
    prices = json['prices'] != null ? Prices.fromJson(json['prices']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['name'] = name;
    map['units'] = units;
    map['question'] = question;
    map['has_prices'] = hasPrices;
    map['site_id'] = siteId;
    map['category_name'] = categoryName;
    if (prices != null) {
      map['prices'] = prices?.toJson();
    }
    return map;
  }

}

class Prices {
  String? min;
  String? max;

  Prices({
      this.min, 
      this.max});

  Prices.fromJson(dynamic json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['min'] = min;
    map['max'] = max;
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