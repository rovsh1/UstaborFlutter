class MyApplicationDetailResponse {
  MyApplicationDetailResponse({
      this.date, 
      this.status, 
      this.result,});

  MyApplicationDetailResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    result = json['result'] != null ? MyApplicationDetail.fromJson(json['result']) : null;
  }
  String? date;
  Status? status;
  MyApplicationDetail? result;

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

class MyApplicationDetail {
  MyApplicationDetail({
      this.id, 
      this.customerId, 
      this.operatorId, 
      this.managerId, 
      this.countryId, 
      this.categoryId, 
      this.serviceId, 
      this.answerId, 
      this.source, 
      this.visibilityType, 
      this.guid, 
      this.username, 
      this.date, 
      this.time, 
      this.price, 
      this.text, 
      this.address, 
      this.addressNote, 
      this.contactPhone, 
      this.note, 
      this.cancelNote, 
      this.status, 
      this.dateOpened, 
      this.dateAppointed, 
      this.documents, 
      this.exportCrm, 
      this.created, 
      this.flagMasters, 
      this.customerPresentation, 
      this.siteId, 
      this.countryName, 
      this.categoryName, 
      this.siteName, 
      this.managerPresentation, 
      this.services, 
      this.masters,});

  MyApplicationDetail.fromJson(dynamic json) {
    id = json['id'];
    customerId = json['customer_id'];
    operatorId = json['operator_id'];
    managerId = json['manager_id'];
    countryId = json['country_id'];
    categoryId = json['category_id'];
    serviceId = json['service_id'];
    answerId = json['answer_id'];
    source = json['source'];
    visibilityType = json['visibility_type'];
    guid = json['guid'];
    username = json['username'];
    date = json['date'];
    time = json['time'];
    price = json['price'];
    text = json['text'];
    address = json['address'];
    addressNote = json['address_note'];
    contactPhone = json['contact_phone'];
    note = json['note'];
    cancelNote = json['cancel_note'];
    status = json['status'];
    dateOpened = json['date_opened'];
    dateAppointed = json['date_appointed'];
    // documents = [];
    // documents = json['documents'] != null ? json['documents'].cast<String>() : [];
    exportCrm = json['export_crm'];
    created = json['created'];
    flagMasters = json['flag_masters'];
    customerPresentation = json['customer_presentation'];
    siteId = json['site_id'];
    countryName = json['country_name'];
    categoryName = json['category_name'];
    siteName = json['site_name'];
    managerPresentation = json['manager_presentation'];
    services = [];
    if (json['services'] != null) {
      json['services'].forEach((v) {
        services?.add(Service.fromJson(v));
      });
    }
    masters = [];
    if (json['masters'] != null) {
      json['masters'].forEach((v) {
        masters?.add(Masters.fromJson(v));
      });
    }

    documents = [];
    if (json['documents'] != null) {
      json['documents'].forEach((v) {
        documents?.add(Docs.fromJson(v));
      });
    }

  }
  int? id;
  int? customerId;
  String? operatorId;
  int? managerId;
  int? countryId;
  int? categoryId;
  dynamic serviceId;
  dynamic answerId;
  int? source;
  String? visibilityType;
  String? guid;
  String? username;
  String? date;
  String? time;
  int? price;
  String? text;
  String? address;
  String? addressNote;
  String? contactPhone;
  String? note;
  String? cancelNote;
  int? status;
  String? dateOpened;
  String? dateAppointed;
  List<Docs>? documents;
  bool? exportCrm;
  String? created;
  String? flagMasters;
  String? customerPresentation;
  String? siteId;
  String? countryName;
  String? categoryName;
  String? siteName;
  String? managerPresentation;
  List<Service>? services;
  List<Masters>? masters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_id'] = customerId;
    map['operator_id'] = operatorId;
    map['manager_id'] = managerId;
    map['country_id'] = countryId;
    map['category_id'] = categoryId;
    map['service_id'] = serviceId;
    map['answer_id'] = answerId;
    map['source'] = source;
    map['visibility_type'] = visibilityType;
    map['guid'] = guid;
    map['username'] = username;
    map['date'] = date;
    map['time'] = time;
    map['price'] = price;
    map['text'] = text;
    map['address'] = address;
    map['address_note'] = addressNote;
    map['contact_phone'] = contactPhone;
    map['note'] = note;
    map['cancel_note'] = cancelNote;
    map['status'] = status;
    map['date_opened'] = dateOpened;
    map['date_appointed'] = dateAppointed;
    map['documents'] = documents;
    map['export_crm'] = exportCrm;
    map['created'] = created;
    map['flag_masters'] = flagMasters;
    map['customer_presentation'] = customerPresentation;
    map['site_id'] = siteId;
    map['country_name'] = countryName;
    map['category_name'] = categoryName;
    map['site_name'] = siteName;
    map['manager_presentation'] = managerPresentation;
    map['services'] = services;
    if (masters != null) {
      map['masters'] = masters?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Masters {
  Masters({
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
      this.requestId, 
      this.masterId, 
      this.guid, 
      this.addType, 
      this.message, 
      this.price, 
      this.paidSum, 
      this.paidTime, 
      this.flagViewed, 
      this.notificationStatus, 
      this.icon, 
      this.feedbackUrl,});

  Masters.fromJson(dynamic json) {
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
    badges = json['badges'] != null ? json['badges'] : [];
    balance = json['balance'];
    requestId = json['request_id'];
    masterId = json['master_id'];
    guid = json['guid'];
    addType = json['add_type'];
    message = json['message'];
    price = json['price'];
    paidSum = json['paid_sum'];
    paidTime = json['paid_time'];
    flagViewed = json['flag_viewed'];
    notificationStatus = json['notification_status'];
    icon = json['icon'];
    feedbackUrl = json['feedback_url'];
  }
  int? id;
  String? name;
  String? surname;
  String? patronymic;
  String? presentation;
  String? login;
  String? email;
  String? phone;
  String? gender;
  int? role;
  int? status;
  String? created;
  String? updated;
  String? birthday;
  dynamic image;
  dynamic importId;
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
  String? rankValue;
  String? rankCalculated;
  bool? flagRequests;
  bool? flagSms;
  String? notes;
  String? countryId;
  String? cityName;
  String? districtName;
  String? countryName;
  String? password;
  List<int>? categories;
  List<dynamic>? badges;
  dynamic balance;
  int? requestId;
  int? masterId;
  String? guid;
  int? addType;
  String? message;
  int? price;
  int? paidSum;
  String? paidTime;
  bool? flagViewed;
  int? notificationStatus;
  String? icon;
  String? feedbackUrl;

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
    map['badges'] = badges;
    map['balance'] = balance;
    map['request_id'] = requestId;
    map['master_id'] = masterId;
    map['guid'] = guid;
    map['add_type'] = addType;
    map['message'] = message;
    map['price'] = price;
    map['paid_sum'] = paidSum;
    map['paid_time'] = paidTime;
    map['flag_viewed'] = flagViewed;
    map['notification_status'] = notificationStatus;
    map['icon'] = icon;
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

class Service {
  Service({
    this.id,
    this.serviceId,
    this.parentId,
    this.name,
    this.question,
    this.hasPrices,
    this.itemsCount,
    this.serviceName,
    this.parentName,});

  Service.fromJson(dynamic json) {
    id = json['id'];
    serviceId = json['service_id'];
    parentId = json['parent_id'];
    name = json['name'];
    question = json['question'];
    hasPrices = json['has_prices'];
    itemsCount = json['items_count'];
    serviceName = json['service_name'];
    parentName = json['parent_name'];
  }
  int? id;
  int? serviceId;
  int? parentId;
  String? name;
  String? question;
  String? hasPrices;
  String? itemsCount;
  String? serviceName;
  String? parentName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_id'] = serviceId;
    map['parent_id'] = parentId;
    map['name'] = name;
    map['question'] = question;
    map['has_prices'] = hasPrices;
    map['items_count'] = itemsCount;
    map['service_name'] = serviceName;
    map['parent_name'] = parentName;
    return map;
  }

}



class Docs {
  String? name;
  String? href;
  String? guid;

  Docs({
    this.name,
    this.href,
    this.guid
  });

  Docs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    guid = json['guid'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['href'] = this.href;
    data['guid'] = this.guid;
    return data;

  }

}
