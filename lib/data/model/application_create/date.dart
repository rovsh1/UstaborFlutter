import 'package:get/get.dart';

enum ApplicationDate {
  today,
  tomorrow,
  master_free,
  in_week,
}

class ApplicationDateData {
  String text;
  String id;

  ApplicationDateData({required this.text, required this.id});
}

