import 'package:equatable/equatable.dart';

class AnswerResponse {
  AnswerResponse({
    this.date,
    this.status,
    this.result,
  });

  AnswerResponse.fromJson(dynamic json) {
    date = json['date'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Answer.fromJson(v));
      });
    }
  }

  String? date;
  Status? status;
  List<Answer>? result;

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

class Answer extends Equatable {
  Answer({
    this.id,
    this.serviceId,
    this.parentId,
    this.name,
    this.question,
    this.hasPrices,
    this.itemsCount,
    this.serviceName,
    this.parentName,
  });

  Answer.fromJson(dynamic json) {
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

  @override
  List<Object?> get props => [
        this.id,
        this.serviceId,
        this.parentId,
        this.name,
        this.question,
        this.hasPrices,
        this.itemsCount,
        this.serviceName,
        this.parentName,
      ];
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
