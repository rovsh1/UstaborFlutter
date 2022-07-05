import 'package:get/get.dart';

enum CallDate {
  morning,
  day,
  evening,
}

class CallDateData {
  String text;
  String id;

  CallDateData({required this.text, required this.id});
}

List<CallDateData> callDates = [
  CallDateData(
    id: "1",
      text: "08-12 ${'morning'.tr}",
  ),
  CallDateData(
    id: "2",
    text: "12-17 ${'day'.tr}",
  ),
  CallDateData(
    id: "3",
    text: "17-21 ${'evening'.tr}",
  ),
];
