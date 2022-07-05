class MyMastersResponse {
  MyMastersResponse({
      this.date, 
      this.status, 
      this.result,});

  MyMastersResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(MyMaster.fromJson(v));
      });
    }
  }
  String? date;
  Status? status;
  List<MyMaster>? result;

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

class MyMaster {
  MyMaster({
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
      this.balance,
      this.feedbackUrl,
  });

  MyMaster.fromJson(dynamic json) {
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
    categories = [];
    categories = json['categories'] != null ? json['categories'].cast<int>() : [];
    balance = json['balance'];
   if(json['feedback_url']!=null) feedbackUrl = json['feedback_url'];
  }
  int? id;
  String? name;
  String? surname;
  String? patronymic;
  String? presentation;
  String? login;
  String? email;
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
  int? siteId;
  int? cityId;
  int? districtId;
  dynamic administratorId;
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
  String? districtName;
  String? countryName;
  dynamic password;
  List<int>? categories;
  dynamic balance;
  dynamic feedbackUrl;

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
    map['balance'] = balance;
    map['feedback_url'] = feedbackUrl;
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