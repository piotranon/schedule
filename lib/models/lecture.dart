import 'package:flutter/material.dart';
import 'package:schedule/models/lecturer.dart';

class Lecture {
  String weeks;
  String name;
  TimeOfDay start_time;
  TimeOfDay end_time;
  int group;
  int laboratories;
  int specialization;
  Lecturer lecturer;

  Lecture(this.weeks, this.name, this.start_time, this.end_time, this.group,
      this.laboratories, this.lecturer);

  Lecture.toJson(Map json) {
    this.weeks = json['weeks'];
    this.name = json['name'];
    this.start_time = TimeOfDay.fromDateTime(
        DateTime.parse("2012-02-27 " + json['start_time'].toString()));
    this.end_time = TimeOfDay.fromDateTime(
        DateTime.parse("2012-02-27 " + json['end_time'].toString()));
    this.group = json['group'] ?? 0;
    this.laboratories = json['laboratories'] ?? 0;
    this.specialization = json['specialization'] ?? 0;
    this.lecturer = Lecturer.fromJson(json['lecturer']);
  }

  @override
  String toString() {
    return '{"weeks":"' +
        this.weeks +
        '","name":"' +
        this.name +
        '","start_time":"' +
        start_time.toString() +
        '","end_time":"' +
        end_time.toString() +
        '","group":"' +
        this.group.toString() +
        '","laboratories":"' +
        this.laboratories.toString() +
        '","lecturer":' +
        this.lecturer.toString() +
        '}';
  }
}
