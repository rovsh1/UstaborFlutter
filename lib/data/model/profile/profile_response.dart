class ProfileResponse {
  String? date;
  Status? status;
  Profile? result;

  ProfileResponse({this.date, this.status, this.result});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    result =
    json['result'] != null ? new Profile.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.status != null) {
      data['status'] = this.status?.toJson();
    }
    if (this.result != null) {
      data['result'] = this.result?.toJson();
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

class Profile {
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
  String? image;
  String? password;
  String? feedback;

  Profile(
      {this.id,
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
        this.password,
        this.feedback});

  Profile.fromJson(Map<String, dynamic> json) {
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
    password = json['password'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['patronymic'] = this.patronymic;
    data['presentation'] = this.presentation;
    data['login'] = this.login;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['role'] = this.role;
    data['status'] = this.status;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['birthday'] = this.birthday;
    data['image'] = this.image;
    data['password'] = this.password;
    data['feedback'] = this.feedback;
    return data;
  }
}
