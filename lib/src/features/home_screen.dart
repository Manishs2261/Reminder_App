import 'dart:convert';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:reminder_app/src/core/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/work_model.dart';
import '../core/controller/notificaion_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(NotificationController());

  @override
  void initState() {
    controller.getSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        backgroundColor: Colors.white12,
        appBar: AppBar(
          backgroundColor: Colors.black12,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
          title: const Text("Reminder"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 15.0, right: 15.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: Colors.white70,
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Tab(
                      text: 'Reminder',
                    ),
                    Tab(
                      text: 'Set Reminder',
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  Obx(
                      ()=> ListView.builder(
                      itemCount: controller.workList.value.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                            padding: const EdgeInsets.all(10),
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.shade600, spreadRadius: 0.8),
                                ],
                                color: Colors.grey.shade800),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                controller.workList[index].time,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: const TextStyle(color: Colors.white, fontSize: 24),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                controller.workList[index].dayOfName,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: const TextStyle(color: Colors.white70, fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          controller.workList[index].dayOfWork,
                                          style: const TextStyle(color: Colors.white60, fontSize: 20),
                                        )
                                      ]),
                                ),
                                IconButton(
                                    onPressed: () {
                                      // Remove data for the 'counter' key.
                                      controller.deleteAlarm(index);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 36,
                                      color: Colors.white,
                                    ))
                              ],
                            ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 40),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration:
                              BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField<String>(
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                            dropdownColor: Colors.grey.shade800,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            value: 'Monday',
                            items: [
                              'Monday',
                              'Tuesday',
                              'Wednesday',
                              'Thursday',
                              'Friday',
                              'Saturday',
                              'Sunday',
                            ].map((day) {
                              return DropdownMenuItem<String>(
                                value: day,
                                child: Text(day),
                              );
                            }).toList(),
                            onChanged: (day) {
                              controller.selectedDay = day!;
                              // Handle day selection
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          height: 48,
                          decoration:
                              BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.initialTime.hour}:${controller.initialTime.minute}",
                                style: const TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade700,
                                  ),
                                  onPressed: () async {
                                    DateTime? dateTime = await showOmniDateTimePicker(context: context);
                                    controller.initialTime = dateTime!;
                                  },
                                  child: const Text(
                                    "Choose Time",
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonFormField<String>(
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                            dropdownColor: Colors.grey.shade800,
                            decoration: const InputDecoration(border: InputBorder.none),
                            borderRadius: BorderRadius.circular(10),
                            value: 'Wake up',
                            items: [
                              'Wake up',
                              'Go to gym',
                              'Breakfast',
                              'Meetings',
                              'Lunch',
                              'Quick nap',
                              'Go to library',
                              'Dinner',
                              'Go to sleep',
                            ].map((workActivity) {
                              return DropdownMenuItem<String>(
                                value: workActivity,
                                child: Text(workActivity),
                              );
                            }).toList(),
                            onChanged: (workActivity) {
                              // Handle day selection
                              controller.selectedDayOfWork = workActivity!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade700,
                                ),
                                onPressed: () async {
                                  //set Reminder
                                  controller.setAlarmReminder();
                                },
                                child: const Text(
                                  "Set Reminder",
                                  style: TextStyle(fontSize: 16),
                                ))),
                        ElevatedButton(
                            onPressed: () async {
                              await Alarm.stop(42);
                            },
                            child: Text("buttom")),
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }


}
