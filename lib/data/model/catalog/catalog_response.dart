class CatalogResponse {
  String? date;
  Status? status;
  List<Catalog>? result;

  CatalogResponse({this.date, this.status, this.result});

  CatalogResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    result = [];
    if (json['result'] != null) {
      json['result'].forEach((v) {
        result?.add(Catalog.fromJson(v));
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

class Catalog {
  int? id;
  int? advertiserId;
  String? preview;
  String? advertiserAvatar;
  String? advertiserPhone;
  String? advertiserAboutLabel;
  String? advertiserAbout;
  String? advertiserPresentation;
  String? companyUrl;
  String? name;
  String? surname;
  String? patronymic;
  String? presentation;
  String? login;
  dynamic email;
  String? phone;
  dynamic gender;
  int? role;
  int? status;
  String? created;
  String? updated;
  dynamic birthday;
  String? image;
  int? importId;
  String? managerId;
  String? promotion;
  String? badgesCount;
  String? badgeEmergency;
  dynamic index;
  dynamic categoryId;
  String? categoryUrlname;
  String? categoryName;
  int? siteId;
  int? cityId;
  dynamic districtId;
  dynamic administratorId;
  int? experience;
  dynamic rating;
  dynamic reviewsCount;
  dynamic rankValue;
  dynamic rankCalculated;
  bool? flagRequests;
  bool? flagSms;
  dynamic notes;
  dynamic countryId;
  String? cityName;
  dynamic districtName;
  String? countryName;
  dynamic password;
  List<int>? categories;
  List<int>? badges;
  dynamic balance;
  List<Projects>? projects;
  List<Services>? services;
  bool? isAd;

  Catalog(
      {this.id,
      this.name,
      this.surname,
      this.patronymic,
      this.presentation,
      this.login,
      this.advertiserId,
      this.preview,
      this.advertiserAvatar,
      this.advertiserPhone,
      this.advertiserAboutLabel,
      this.advertiserAbout,
      this.advertiserPresentation,
      this.companyUrl,
      this.email,
      this.phone,
      this.gender,
      this.role,
      this.status,
      this.created,
      this.updated,
      this.birthday,
      this.image,
      this.importId,
      this.managerId,
      this.promotion,
      this.badgesCount,
      this.badgeEmergency,
      this.index,
      this.categoryId,
      this.categoryUrlname,
      this.categoryName,
      this.siteId,
      this.cityId,
      this.districtId,
      this.administratorId,
      this.experience,
      this.rating,
      this.reviewsCount,
      this.rankValue,
      this.rankCalculated,
      this.flagRequests,
      this.flagSms,
      this.notes,
      this.countryId,
      this.cityName,
      this.districtName,
      this.countryName,
      this.password,
      this.categories,
      this.badges,
      this.balance,
      this.projects,
      this.services,
      this.isAd});

  Catalog.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'] ?? '';
    advertiserId = json["advertiser_id"];
    preview = json["preview"];
    advertiserAvatar = json["advertiser_avatar"];
    advertiserPhone = json["advertiser_phone"];
    advertiserAboutLabel = json["advertiser_about_label"];
    advertiserAbout = json["advertiser_about"];
    advertiserPresentation = json["advertiser_presentation"];
    companyUrl = json["company_url"];
    surname = json['surname'];
    patronymic = json['patronymic'];
    presentation = json['presentation'];
    login = json['login'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    role = json['role'];
    status = json['status'];
    created = json['created'];
    updated = json['updated'];
    birthday = json['birthday'];
    image = json['image'];
    importId = json['import_id'];
    managerId = json['manager_id'];
    promotion = json['promotion'];
    badgesCount = json['badges_count'];
    badgeEmergency = json['badge_emergency'];
    index = json['index'];
    categoryId = json['category_id'];
    categoryUrlname = json['category_urlname'];
    categoryName = json['category_name'];
    siteId = json['site_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    administratorId = json['administrator_id'];
    experience = json['experience'];
    rating = json['rating'];
    reviewsCount = json['reviews_count'];
    rankValue = json['rank_value'];
    rankCalculated = json['rank_calculated'];
    flagRequests = json['flag_requests'];
    flagSms = json['flag_sms'];
    notes = json['notes'];
    countryId = json['country_id'];
    cityName = json['city_name'];
    districtName = json['district_name'];
    countryName = json['country_name'];
    password = json['password'];
    categories = [];
    categories = json['categories'] != null ? json['categories'].cast<int>() : [];
    badges = json['badges'] != null ? json['badges'].cast<int>() : [];
    balance = json['balance'];
    projects = [];
    if (json['projects'] != null) {
      json['projects'].forEach((v) {
        projects?.add(Projects.fromJson(v));
      });
    }
    services = [];
    if (json['services'] != null) {
      json['services'].forEach((v) {
        services?.add(Services.fromJson(v));
      });
    }
    isAd = json['is_ad'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['surname'] = surname;
    map['patronymic'] = patronymic;
    map['presentation'] = presentation;
    map['login'] = login;
    map['email'] = email;
    map['phone'] = phone;
    map['gender'] = gender;
    map['role'] = role;
    map['status'] = status;
    map['created'] = created;
    map['updated'] = updated;
    map['birthday'] = birthday;
    map['image'] = image;
    map['import_id'] = importId;
    map['manager_id'] = managerId;
    map['promotion'] = promotion;
    map['badges_count'] = badgesCount;
    map['badge_emergency'] = badgeEmergency;
    map['index'] = index;
    map['category_id'] = categoryId;
    map['category_urlname'] = categoryUrlname;
    map['category_name'] = categoryName;
    map['site_id'] = siteId;
    map['city_id'] = cityId;
    map['district_id'] = districtId;
    map['administrator_id'] = administratorId;
    map['experience'] = experience;
    map['rating'] = rating;
    map['reviews_count'] = reviewsCount;
    map['rank_value'] = rankValue;
    map['rank_calculated'] = rankCalculated;
    map['flag_requests'] = flagRequests;
    map['flag_sms'] = flagSms;
    map['notes'] = notes;
    map['country_id'] = countryId;
    map['city_name'] = cityName;
    map['district_name'] = districtName;
    map['country_name'] = countryName;
    map['password'] = password;
    map['categories'] = categories;
    map['badges'] = badges;
    map['balance'] = balance;
    if (projects != null) {
      map['projects'] = projects?.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    map['is_ad'] = isAd;
    return map;
  }
}

class Services {
  String? price;
  String? main;
  String? id;
  String? categoryId;
  String? name;
  String? priceMin;

  Services({this.price, this.main, this.id, this.categoryId, this.name, this.priceMin});

  Services.fromJson(dynamic json) {
    price = json['price'];
    main = json['main'];
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    priceMin = json['price_min'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['price'] = price;
    map['main'] = main;
    map['id'] = id;
    map['category_id'] = categoryId;
    map['name'] = name;
    map['price_min'] = priceMin;
    return map;
  }
}

class Projects {
  int? id;
  int? masterId;
  int? categoryId;
  dynamic name;
  String? image;
  String? categoryName;

  Projects({this.id, this.masterId, this.categoryId, this.name, this.image, this.categoryName});

  Projects.fromJson(dynamic json) {
    id = json['id'];
    masterId = json['master_id'];
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['master_id'] = masterId;
    map['category_id'] = categoryId;
    map['name'] = name;
    map['image'] = image;
    map['category_name'] = categoryName;
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
