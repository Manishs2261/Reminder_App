import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/work_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TimeOfDay initialTime = TimeOfDay.now();
  String selectedDay = "Monday";
  String selectedDayOfWork = "Wake up";
  List<WorkModel> workList = List.empty(growable: true);



  late SharedPreferences sp;

  getSharedPrefrences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntoSp() {
    //
    List<String> contactListString =
    workList.map((contact) => jsonEncode(contact.toJson())).toList();
    sp.setStringList('myData', contactListString);
    //
  }

  readFromSp() {
    //
    List<String>? contactListString = sp.getStringList('myData');
    if (contactListString != null) {
      workList = contactListString
          .map((contact) => WorkModel.fromJson(json.decode(contact)))
          .toList();
    }
    setState(() {});
    //
  }

  @override
  void initState() {
    getSharedPrefrences();
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
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
          title: Text("Reminder"),
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
                  tabs: [
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
                      ListView.builder(
                        itemCount: workList.length,
                        itemBuilder: (context, index) => getRow(index),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 40),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration:
                              BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField<String>(
                                style: TextStyle(color: Colors.white, fontSize: 18),
                                dropdownColor: Colors.grey.shade800,
                                decoration: InputDecoration(
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
                                  selectedDay = day!;
                                  // Handle day selection
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              height: 48,
                              decoration:
                              BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${initialTime.hour}:${initialTime.minute}",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade700,
                                      ),
                                      onPressed: () async {
                                        final timeOfDay = await showTimePicker(
                                          context: context,
                                          initialTime: initialTime,
                                        );
                                        if (timeOfDay != null) {
                                          setState(() {
                                            initialTime = timeOfDay;
                                          });
                                        }
                                      },
                                      child: Text(
                                        "Choose Time",
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonFormField<String>(
                                style: TextStyle(color: Colors.white, fontSize: 18),
                                dropdownColor: Colors.grey.shade800,
                                decoration: InputDecoration(border: InputBorder.none),
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
                                  selectedDayOfWork = workActivity!;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade700,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        workList.add(WorkModel(
                                            dayOfName: selectedDay,
                                            dayOfWork: selectedDayOfWork,
                                            time: "${initialTime.hour}:${initialTime.minute}"));
                                        print("save");
                                      });

                                    saveIntoSp();

                                      print("save retu");
                                    },
                                    child: Text(
                                      "Set Reminder",
                                      style: TextStyle(fontSize: 16),
                                    )))
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



  Widget getRow(int index) {
    return   Container(
      margin: EdgeInsets.only(top: 10,left: 5,right: 5),
      padding: EdgeInsets.all(10),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade600, spreadRadius: 0.8),
          ],
          color: Colors.grey.shade800),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Row(
      children: [
      Text(
      "${workList[index].time}",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
      SizedBox(
        width: 15,
      ),
      Text(
        "${workList[index].dayOfName}",
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
      ],
    ),
    Text(
    "${workList[index].dayOfWork}",
    style: TextStyle(color: Colors.white60, fontSize: 20),
    )
    ]
    )
    );
  }
}







