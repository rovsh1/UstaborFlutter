class MyApplicationResponse {
  String? date;
  Status? status;
  List<MyApplication>? result;

  MyApplicationResponse({this.date, this.status, this.result});

  MyApplicationResponse.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    result = [];
    if (json['result'] != null) {
      json['result'].forEach((v) {
        result?.add(new MyApplication.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.status != null) {
      data['status'] = this.status?.toJson();
    }
    if (this.result != null) {
      data['result'] = this.result?.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class Status {
  String? code;
  String? message;

  Status({this.code, this.message});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }

}

class MyApplication {
  int? id;
  int? customerId;
  Null operatorId;
  int? managerId;
  int? countryId;
  int? categoryId;
  int? serviceId;
  int? answerId;
  int? source;
  Null visibilityType;
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
  int? status;
  bool? exportCrm;
  String? created;
  String? flagMasters;
  String? customerPresentation;
  String? siteId;
  String? countryName;
  String? categoryName;
  String? siteName;
  String? managerPresentation;
  List<Masters>? masters;
  List<Docs>? documents;

  MyApplication({this.id,
    this.customerId,
    this.operatorId,
    this.managerId,
    this.countryId,
    this.categoryId,
    this.serviceId,
    this.answerId,
    this.documents,
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
    this.status,
    this.exportCrm,
    this.created,
    this.flagMasters,
    this.customerPresentation,
    this.siteId,
    this.countryName,
    this.categoryName,
    this.siteName,
    this.managerPresentation,
    this.masters
  });

  MyApplication.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
    exportCrm = json['export_crm'];
    created = json['created'];
    flagMasters = json['flag_masters'];
    customerPresentation = json['customer_presentation'];
    siteId = json['site_id'];
    countryName = json['country_name'];
    categoryName = json['category_name'];
    siteName = json['site_name'];
    managerPresentation = json['manager_presentation'];
    documents = [];
    if (json['documents'] != null) {
      json['documents'].forEach((v) {
        documents?.add(new Docs.fromJson(v));
      });
    }

      masters = [];
      if (json['masters'] != null) {
        json['masters'].forEach((v) {
          masters?.add(new Masters.fromJson(v));
        });
      }
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['customer_id'] = this.customerId;
      data['operator_id'] = this.operatorId;
      data['manager_id'] = this.managerId;
      data['country_id'] = this.countryId;
      data['category_id'] = this.categoryId;
      data['service_id'] = this.serviceId;
      data['answer_id'] = this.answerId;
      data['source'] = this.source;
      data['visibility_type'] = this.visibilityType;
      data['guid'] = this.guid;
      data['username'] = this.username;
      data['date'] = this.date;
      data['time'] = this.time;
      data['price'] = this.price;
      data['text'] = this.text;
      data['address'] = this.address;
      data['address_note'] = this.addressNote;
      data['contact_phone'] = this.contactPhone;
      data['note'] = this.note;
      data['status'] = this.status;
      data['export_crm'] = this.exportCrm;
      data['created'] = this.created;
      data['flag_masters'] = this.flagMasters;
      data['customer_presentation'] = this.customerPresentation;
      data['site_id'] = this.siteId;
      data['country_name'] = this.countryName;
      data['category_name'] = this.categoryName;
      data['site_name'] = this.siteName;
      data['manager_presentation'] = this.managerPresentation;
      if (this.masters != null) {
        data['masters'] = this.masters?.map((v) => v.toJson()).toList();
      }

      if (this.documents != null) {
        data['documents'] = this.documents?.map((v) => v.toJson()).toList();
      }

      return data;
    }
  }

class Masters {
  int? requestId;
  int? masterId;
  String? guid;
  int? addType;
  int? status;
  int? paidSum;
  String? paidTime;
  bool? flagViewed;
  int? notificationStatus;
  String? icon;

  Masters(
      {this.requestId,
        this.masterId,
        this.guid,
        this.addType,
        this.status,
        this.paidSum,
        this.paidTime,
        this.flagViewed,
        this.notificationStatus,
        this.icon});

  Masters.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    masterId = json['master_id'];
    guid = json['guid'];
    addType = json['add_type'];
    status = json['status'];
    paidSum = json['paid_sum'];
    paidTime = json['paid_time'];
    flagViewed = json['flag_viewed'];
    notificationStatus = json['notification_status'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['master_id'] = this.masterId;
    data['guid'] = this.guid;
    data['add_type'] = this.addType;
    data['status'] = this.status;
    data['paid_sum'] = this.paidSum;
    data['paid_time'] = this.paidTime;
    data['flag_viewed'] = this.flagViewed;
    data['notification_status'] = this.notificationStatus;
    data['icon'] = this.icon;
    return data;
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
