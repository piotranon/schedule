import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:schedule/models/week.dart';
import 'package:schedule/viewmodels/weekDayListViewModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class weekDayListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _weekDayListState();
}

class _weekDayListState extends State<weekDayListPage> {
  @override
  void initState() {
    super.initState();
    // Provider.of<WeekViewModel>(context, listen: false).fetchAllWeekDays();
  }

  void reload() async {
    // Provider.of<WeekViewModel>(context, listen: false).fetchAllWeekDays();
    print("reolad started");
    final response =
        await http.get('http://10.0.2.2:8000/schedule/api/lecture/');
    final json = jsonDecode(response.body) as Map;
    print("reolad data obtained");

    print(json);
    // print(json.keys);

    List<WeekDay> weekDays = new List<WeekDay>();

    json.forEach((key, value) {
      // print("$key - $value\n");

      // List<dynamic> days =
      // WeekDay weekDay;
      // weekDay.dayName = key;

      List<Lecture> lectures = new List<Lecture>();

      List<dynamic> lec = value;

      lec.forEach((element) {
        Lecturer lecturer = new Lecturer(
            // lecturer.name =
            name: element['lecturer']['name'],
            surname: element['lecturer']['surname'],
            email: element['lecturer']['email'],
            academic_title: element['lecturer']['academic_title']);

        Lecture lecture = new Lecture(
            lecturer: lecturer,
            weeks: element['weeks'],
            name: element['name'],
            start_time: element['start_time'],
            duration: element['duration'],
            group: element['group'],
            laboratories: element['laboratories']);

        lectures.add(lecture);
      });

      WeekDay weekDay = new WeekDay(dayName: key, lectures: lectures);
      weekDays.add(weekDay);
    });
    Week week = new Week(
        fieldOfStudy: "Informatyka",
        yearOfStudy: "3rok 1 semestr",
        weekDay: weekDays);
    print(week);
  }

  @override
  Widget build(BuildContext context) {
    // final vm = Provider.of<WeekViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("WeekDays"),
      ),
      body: RaisedButton(
        onPressed: () => {reload()},
        child: new Text('Click me'),
      ),
    );
  }
}
