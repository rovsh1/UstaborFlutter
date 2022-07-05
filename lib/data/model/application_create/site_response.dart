class SiteResponse {
  String? date;
  Status? status;
  List<Site>? result;

  SiteResponse({this.date, this.status, this.result});

  SiteResponse.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'] != null ? new Status.fromJson(json['status']) : null;
    result = [];
    if (json['result'] != null) {
      json['result'].forEach((v) {
        result?.add(new Site.fromJson(v));
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
  int? error;
  Status({this.code, this.message});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class Site {
  int? id;
  String? icon;
  String? name;
  String? menuName;
  String? domain;

  Site({this.id, this.icon, this.name, this.menuName, this.domain});

  Site.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    menuName = json['menu_name'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['menu_name'] = this.menuName;
    data['domain'] = this.domain;
    return data;
  }
}
