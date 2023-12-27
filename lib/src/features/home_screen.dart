import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  String? _dropDownValue;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white,fontSize: 30),
          title: Text("Home"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 15.0,right: 15.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
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
                    color: Colors.green,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'Watch reminder',

                    ),
                    Tab(
                      text: 'set reminder',
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                border: InputBorder.none
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
                              // Handle day selection
                            },

                          ),
                        ),
                        SizedBox(height: 10,),


                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField<String>(

                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
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
                            ].map((day) {
                              return DropdownMenuItem<String>(
                                value: day,
                                child: Text(day),
                              );
                            }).toList(),
                            onChanged: (day) {
                              // Handle day selection
                            },

                          ),
                        ),

                      ],
                    ),
                  ),

                  Center(
                    child: Text("watch notification"),
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
