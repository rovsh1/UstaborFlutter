class CategoryResponse {
  String? date;
  Status? status;
  List<Category>? result;

  CategoryResponse({this.date, this.status, this.result});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'] != null ? new Status.fromJson(json['status']) : null;
    result = [];
    if (json['result'] != null) {
      json['result'].forEach((v) {
        result?.add(new Category.fromJson(v));
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

class Category {
  int? id;
  int? siteId;
  String? name;
  String? urlname;
  int? index;
  int? contactCounter;
  String? icon;
  String? siteDomain;
  String? siteName;
  List<int>? countries;

  Category(
      {this.id,
        this.siteId,
        this.name,
        this.urlname,
        this.index,
        this.contactCounter,
        this.icon,
        this.siteDomain,
        this.siteName,
        this.countries});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['site_id'];
    name = json['name'];
    urlname = json['urlname'];
    index = json['index'];
    contactCounter = json['contact_counter'];
    icon = json['icon'];
    siteDomain = json['site_domain'];
    siteName = json['site_name'];
    countries = json['countries'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site_id'] = this.siteId;
    data['name'] = this.name;
    data['urlname'] = this.urlname;
    data['index'] = this.index;
    data['contact_counter'] = this.contactCounter;
    data['icon'] = this.icon;
    data['site_domain'] = this.siteDomain;
    data['site_name'] = this.siteName;
    data['countries'] = this.countries;
    return data;
  }
}
