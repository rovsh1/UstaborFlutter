class MasterResponse {
  MasterResponse({
    this.date,
    this.status,
    this.result,
  });

  MasterResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    result = json['result'] != null ? Master.fromJson(json['result']) : null;
  }

  String? date;
  Status? status;
  Master? result;

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

class Master {
  Master({
    this.id,
    this.name,
    this.surname,
    this.patronymic,
    this.presentation,
    this.login,
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
    this.siteId,
    this.cityId,
    this.districtId,
    this.administratorId,
    this.about,
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
    this.reviews,
    this.feedbacks,
    this.projects,
    this.services,
    this.url,
    this.lastLogin,
  });

  Master.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
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
    siteId = json['site_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    administratorId = json['administrator_id'];
    about = json['about'];
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
    categories = json['categories'] != null ? json['categories'].cast<int>() : [];
    badges = [];
    if (json['badges'] != null) {
      json['badges'].forEach((v) {
        badges?.add(Badges.fromJson(v));
      });
    }
    balance = json['balance'];
    reviews = [];
    if (json['reviews'] != null) {
      json['reviews'].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
    feedbacks = [];
    if (json['feedbacks'] != null) {
      json['feedbacks'].forEach((v) {
        feedbacks?.add(FeedBacks.fromJson(v));
      });
    }
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
    url = json['url'];
    lastLogin = json['last_login'];
  }

  int? id;
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
  dynamic importId;
  String? managerId;
  String? promotion;
  String? badgesCount;
  String? badgeEmergency;
  int? siteId;
  int? cityId;
  dynamic districtId;
  int? administratorId;
  String? about;
  int? experience;
  dynamic rating;
  int? reviewsCount;
  dynamic rankValue;
  dynamic rankCalculated;
  bool? flagRequests;
  bool? flagSms;
  dynamic notes;
  String? countryId;
  String? cityName;
  dynamic districtName;
  String? countryName;
  dynamic password;
  List<int>? categories;
  List<Badges>? badges;
  dynamic balance;
  List<Reviews>? reviews;
  List<FeedBacks>? feedbacks;
  List<Projects>? projects;
  List<Services>? services;
  String? url;
  String? lastLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['site_id'] = siteId;
    map['city_id'] = cityId;
    map['district_id'] = districtId;
    map['administrator_id'] = administratorId;
    map['about'] = about;
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
    if (badges != null) {
      map['badges'] = badges?.map((v) => v.toJson()).toList();
    }
    map['balance'] = balance;
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    if (feedbacks != null) {
      map['feedbacks'] = feedbacks?.map((v) => v.toJson()).toList();
    }
    if (projects != null) {
      map['projects'] = projects?.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    map['url'] = url;
    map['last_login'] = lastLogin;
    return map;
  }
}

class Services {
  Services({
    this.price,
    this.main,
    this.id,
    this.categoryId,
    this.name,
    this.priceMin,
  });

  Services.fromJson(dynamic json) {
    price = json['price'];
    main = json['main'];
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    priceMin = json['price_min'];
  }

  String? price;
  String? main;
  String? id;
  String? categoryId;
  String? name;
  String? priceMin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
  Projects({
    this.id,
    this.masterId,
    this.categoryId,
    this.name,
    this.image,
    this.categoryName,
  });

  Projects.fromJson(dynamic json) {
    id = json['id'];
    masterId = json['master_id'];
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
    categoryName = json['category_name'];
  }

  int? id;
  int? masterId;
  int? categoryId;
  String? name;
  String? image;
  String? categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['master_id'] = masterId;
    map['category_id'] = categoryId;
    map['name'] = name;
    map['image'] = image;
    map['category_name'] = categoryName;
    return map;
  }
}

class Reviews {
  Reviews({
    this.id,
    this.masterId,
    this.rating,
    this.date,
    this.name,
    this.text,
    this.image,
    this.masterPresentation,
  });

  Reviews.fromJson(dynamic json) {
    id = json['id'];
    masterId = json['master_id'];
    rating = json['rating'];
    date = json['date'];
    name = json['name'];
    text = json['text'];
    image = json['image'];
    masterPresentation = json['master_presentation'];
  }

  int? id;
  int? masterId;
  int? rating;
  String? date;
  String? name;
  String? text;
  dynamic image;
  String? masterPresentation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['master_id'] = masterId;
    map['rating'] = rating;
    map['date'] = date;
    map['name'] = name;
    map['text'] = text;
    map['image'] = image;
    map['master_presentation'] = masterPresentation;
    return map;
  }
}

class Badges {
  Badges({
    this.id,
    this.key,
    this.name,
    this.text,
  });

  Badges.fromJson(dynamic json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    text = json['text'];
  }

  int? id;
  String? key;
  String? name;
  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['key'] = key;
    map['name'] = name;
    map['text'] = text;
    return map;
  }
}

class Status {
  Status({
    this.code,
    this.message,
  });

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

class FeedBacks {
  FeedBacks({
    this.id,
    this.siteId,
    this.userId,
    this.masterId,
    this.rating,
    this.masterPrice,
    this.comment,
    this.recommended,
    this.created,
    this.userAvatar,
    this.userPresentation,
    this.masterPresentation,});

  FeedBacks.fromJson(dynamic json) {
    id = json['id'];
    siteId = json['site_id'];
    userId = json['user_id'];
    masterId = json['master_id'];
    rating = json['rating'];
    masterPrice = json['master_price'];
    comment = json['comment'];
    recommended = json['recommended'];
    created = json['created'];
    userAvatar = json['user_avatar'];
    userPresentation = json['user_presentation'];
    masterPresentation = json['master_presentation'];
  }
  int? id;
  dynamic siteId;
  int? userId;
  int? masterId;
  int? rating;
  dynamic masterPrice;
  String? comment;
  bool? recommended;
  String? created;
  dynamic userAvatar;
  String? userPresentation;
  String? masterPresentation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['site_id'] = siteId;
    map['user_id'] = userId;
    map['master_id'] = masterId;
    map['rating'] = rating;
    map['master_price'] = masterPrice;
    map['comment'] = comment;
    map['recommended'] = recommended;
    map['created'] = created;
    map['user_avatar'] = userAvatar;
    map['user_presentation'] = userPresentation;
    map['master_presentation'] = masterPresentation;
    return map;
  }

}
