import 'package:flutter/material.dart';

class Schedule {
  FieldOfStudy field;

  // Week weekSchedule;
  List<WeekDay> weekDay;

  Schedule(this.field, this.weekDay);

  Schedule.fromJson(Map json) {
    this.field = FieldOfStudy.fromJson(json['fieldOfStudy']);
    // print("xd1: " + json['weekSchedule'].toString());
    // print("xd2: " + json['weekSchedule'].runtimeType.toString());
    // print("xd3: " +
    //     json['weekSchedule']
    //         .map((obj) => print(obj))
    //         .cast<Week>()
    //         .toList()
    //         .toString());
    List<dynamic> xd;

    // print("test: " +
    //     json['weekSchedule']
    //         .map((obj) => WeekDay.fromJson(obj.asMap()))
    //         .cast<WeekDay>()
    //         .toList()
    //         .toString());

    this.weekDay = json['weekSchedule']
        .map((obj) => WeekDay.fromJson(obj.asMap()))
        .cast<WeekDay>()
        .toList();

    // json['weekSchedule'].forEach((element) {
    //   print(element);
    // });
    // this.weekDay = json['weekSchedule']
    // .map((obj) => WeekDay.fromJson(obj))
    // .cast<WeekDay>()
    // .toList();
    // this.weekSchedule = ;
  }

  @override
  String toString() {
    return '{"field":' +
        field.toString() +
        ',"weekSchedule":' +
        weekDay.toString() +
        '}';
  }
}

class FieldOfStudy {
  int id;
  String name;
  int semester;
  String year;
  List<Specialization> specializations;
  List<int> groups;
  List<int> laboratories;

  FieldOfStudy(this.id, this.name, this.semester, this.year,
      this.specializations, this.groups, this.laboratories);

  FieldOfStudy.fromJson(Map json) {
    this.id = json['id'];
    this.name = json['name'];
    this.semester = json['semester'];
    this.year = json['year'];
    // List<Specialization> spec = new List<Specialization>();
    // json['specializations'].forEach((element) {
    //   spec.add(Specialization.fromJson(element));
    // });
    // print("special: " + json['specializations'].runtimeType.toString());
    // this.specializations = spec;
    this.specializations = json['specializations']
        .map((obj) => Specialization.fromJson(obj))
        .cast<Specialization>()
        .toList();
    this.groups = json['groups'].cast<int>();
    this.laboratories = json['laboratories'].cast<int>();
  }

  @override
  String toString() {
    return '{"id":' +
        id.toString() +
        ',"name":"' +
        name.toString() +
        '","semester":' +
        semester.toString() +
        ',"year":"' +
        year.toString() +
        '","specializations":' +
        specializations.toString() +
        ',"groups":' +
        groups.toString() +
        ',"laboratories":' +
        laboratories.toString() +
        '}';
  }
}

class Specialization {
  int id;
  String name;
  String short;
  Specialization(this.id, this.name, this.short);

  Specialization.fromJson(Map json) {
    this.id = json['id'];
    this.name = json['name'];
    this.short = json['short'];
  }

  @override
  String toString() {
    return '{"id":' +
        id.toString() +
        ',"name":"' +
        name.toString() +
        '","short":"' +
        short.toString() +
        '"}';
  }
}

class WeekDay {
  // final String dayName;
  List<Lecture> lectures = new List<Lecture>();

  WeekDay(this.lectures);

  WeekDay.fromJson(Map json) {
    print("weekday: " + json.toString());
    print("weekday2: " + json.runtimeType.toString());
    // List<Lecture> xd

    json.forEach((key, value) {
      print("k: " + key.toString());
      print("v: " + value.toString());
      lectures.add(Lecture.toJson(value));
    });
    // var x = json.map((key, value) => value[key]);
    // print('a ' + x.toString());
    // print('b ' + x.runtimeType.toString());
    // this.lectures = json.map((key, value) => null)
    // this.lectures = json
  }

  @override
  String toString() {
    return lectures.toString();
  }
}

class Lecture {
  String weeks;
  String name;
  TimeOfDay start_time;
  TimeOfDay end_time;
  int group;
  int laboratories;
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
    this.group = json['group'];
    this.laboratories = json['laboratories'];
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

class Lecturer {
  String name;
  String surname;
  String email;
  String academic_title;

  Lecturer(this.name, this.surname, this.email, this.academic_title);

  Lecturer.fromJson(Map json) {
    this.name = json['name'];
    this.surname = json['surname'];
    this.email = json['email'];
    this.academic_title = json['academic_title'];
  }

  @override
  String toString() {
    return '{"name":"' +
        this.name +
        '","surname":"' +
        this.surname +
        '","email":"' +
        this.email +
        '","academic_title":"' +
        this.academic_title +
        '"}';
  }
}
