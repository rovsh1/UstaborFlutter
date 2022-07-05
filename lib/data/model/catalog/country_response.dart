class CountryResponse {
  String? date;
  Status? status;
  List<Country>? result;

  CountryResponse({
      this.date, 
      this.status, 
      this.result});

  CountryResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Country.fromJson(v));
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

class Country {
  int? id;
  String? name;
  String? language;
  String? flag;
  String? phoneCode;
  String? contactPhone;
  bool? isDefault;
  bool? countriesMenu;
  String? datetimeFormat;
  String? dateFormat;
  String? timeFormat;
  int? currencyId;
  bool? deletionMark;
  String? defaultLanguage;
  String? currency;
  List<int>? payments;
  List<String>? languages;
  List<Sites>? sites;
  String? icon;
  List<Categories>? categories;
  int? prices;

  Country({
      this.id, 
      this.name, 
      this.language, 
      this.flag, 
      this.phoneCode, 
      this.contactPhone, 
      this.isDefault,
      this.countriesMenu,
      this.datetimeFormat, 
      this.dateFormat, 
      this.timeFormat, 
      this.currencyId, 
      this.deletionMark, 
      this.defaultLanguage, 
      this.currency, 
      this.payments, 
      this.languages, 
      this.sites, 
      this.icon, 
      this.categories, 
      this.prices});

  Country.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    language = json['language'];
    flag = json['flag'];
    phoneCode = json['phone_code'];
    contactPhone = json['contact_phone'];
    isDefault = json['default'];
    countriesMenu = json['countries_menu'];
    datetimeFormat = json['datetime_format'];
    dateFormat = json['date_format'];
    timeFormat = json['time_format'];
    currencyId = json['currency_id'];
    deletionMark = json['deletion_mark'];
    defaultLanguage = json['default_language'];
    currency = json['currency'];
    payments = json['payments'] != null ? json['payments'].cast<int>() : [];
    languages = json['languages'] != null ? json['languages'].cast<String>() : [];
    if (json['sites'] != null) {
      sites = [];
      json['sites'].forEach((v) {
        sites?.add(Sites.fromJson(v));
      });
    }
    icon = json['icon'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    prices = json['prices'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['language'] = language;
    map['flag'] = flag;
    map['phone_code'] = phoneCode;
    map['contact_phone'] = contactPhone;
    map['default'] = isDefault;
    map['countries_menu'] = countriesMenu;
    map['datetime_format'] = datetimeFormat;
    map['date_format'] = dateFormat;
    map['time_format'] = timeFormat;
    map['currency_id'] = currencyId;
    map['deletion_mark'] = deletionMark;
    map['default_language'] = defaultLanguage;
    map['currency'] = currency;
    map['payments'] = payments;
    map['languages'] = languages;
    if (sites != null) {
      map['sites'] = sites?.map((v) => v.toJson()).toList();
    }
    map['icon'] = icon;
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    map['prices'] = prices;
    return map;
  }

}

class Categories {
  int? id;
  String? name;

  Categories({
      this.id, 
      this.name});

  Categories.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

class Sites {
  int? id;
  String? name;

  Sites({
      this.id, 
      this.name});

  Sites.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
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