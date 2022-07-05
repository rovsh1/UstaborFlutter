class CategoryPriceResponse {
  String? date;
  Status? status;
  Result? result;

  CategoryPriceResponse({this.date, this.status, this.result});

  CategoryPriceResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
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
  String? language;
  int? categoryId;
  int? countryId;
  String? titleChart;
  String? titleService;
  String? titleText;
  int? id;
  String? title;
  String? siteId;
  String? categoryUrlname;
  String? countryName;
  String? categoryName;
  String? text;
  List<Prices>? prices;

  Result({
    this.language,
    this.categoryId,
    this.countryId,
    this.titleChart,
    this.titleService,
    this.titleText,
    this.id,
    this.title,
    this.siteId,
    this.categoryUrlname,
    this.countryName,
    this.categoryName,
    this.text,
    this.prices,
  });

  Result.fromJson(dynamic json) {
    language = json['language'];
    categoryId = json['category_id'];
    countryId = json['country_id'];
    titleChart = json['title_chart'];
    titleService = json['title_service'];
    titleText = json['title_text'];
    id = json['id'];
    title = json['title'];
    siteId = json['site_id'];
    categoryUrlname = json['category_urlname'];
    countryName = json['country_name'];
    categoryName = json['category_name'];
    text = json['text'];
    if (json['prices'] != null) {
      prices = [];
      json['prices'].forEach((v) {
        prices?.add(Prices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['language'] = language;
    map['category_id'] = categoryId;
    map['country_id'] = countryId;
    map['title_chart'] = titleChart;
    map['title_service'] = titleService;
    map['title_text'] = titleText;
    map['id'] = id;
    map['title'] = title;
    map['site_id'] = siteId;
    map['category_urlname'] = categoryUrlname;
    map['country_name'] = countryName;
    map['category_name'] = categoryName;
    map['text'] = text;
    if (prices != null) {
      map['prices'] = prices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Prices {
  int? id;
  String? name;
  String? units;
  dynamic price;
  String? url;

  Prices({this.id, this.name, this.units, this.price, this.url});

  Prices.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    units = json['units'];
    price = json['price'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['units'] = units;
    map['price'] = price;
    map['url'] = url;
    return map;
  }
}

class Status {
  String? code;
  String? message;

  Status({this.code, this.message});

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
