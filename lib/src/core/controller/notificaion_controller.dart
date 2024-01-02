import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/work_model.dart';
import '../notification.dart';

class NotificationController extends GetxController {
  DateTime initialTime = DateTime.now();

  String selectedDay = "Monday";
  String selectedDayOfWork = "Wake up";
  RxList workList = List.empty(growable: true).obs;

  late SharedPreferences sp;

  getSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntoSp() {
    //
    List<String> contactListString = workList.map((contact) => jsonEncode(contact.toJson())).toList();
    sp.setStringList('myData', contactListString);
    //
  }

  readFromSp() {
    //
    List<String>? contactListString = sp.getStringList('myData');
    if (contactListString != null) {
      workList.value = contactListString.map((contact) => WorkModel.fromJson(json.decode(contact))).toList();
    }
  }

  setAlarmReminder() {
    workList.add(WorkModel(
        dayOfName: selectedDay, dayOfWork: selectedDayOfWork, time: "${initialTime.hour}:${initialTime.minute}"));
    print("save");

    NotificationServices().setAlarmNotification(initialTime, selectedDay, selectedDayOfWork);
    saveIntoSp();
  }

  deleteAlarm(index) {
    workList.removeAt(index);

    saveIntoSp();
  }
}
