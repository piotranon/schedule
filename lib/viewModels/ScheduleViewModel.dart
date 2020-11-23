import 'package:flutter/material.dart';
import 'package:schedule/models/all.dart';

class ScheduleViewModel {
  TimeOfDay start_time;
  TimeOfDay end_time;

  List<Lecture> lectures_in_day;
  ScheduleViewModel({this.start_time, this.end_time, this.lectures_in_day});
  @override
  String toString() {
    String lec = "";
    for (Lecture l in lectures_in_day) {
      lec += l.name.toString() + ",";
    }

    return '{"start_time":"' +
        start_time.toString() +
        '","end_time":"' +
        end_time.toString() +
        '","lectures":"' +
        lec +
        '"' +
        lectures_in_day.length.toString();
  }
}
