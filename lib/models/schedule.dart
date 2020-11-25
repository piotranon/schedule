import 'package:flutter/material.dart';
import 'package:schedule/models/lecture.dart';
import 'package:schedule/models/weekDay.dart';
import 'package:schedule/models/fieldOfStudy.dart';
import 'package:schedule/viewModels/ScheduleViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Schedule {
  FieldOfStudy field;

  // Week weekSchedule;
  List<WeekDay> weekDay;

  List<DateTime> week1_3 = new List<DateTime>();
  List<DateTime> week2_4 = new List<DateTime>();

  Schedule(this.field, this.weekDay);

  Schedule.fromJson(Map json) {
    this.field = FieldOfStudy.fromJson(json['fieldOfStudy']);
    this.weekDay = json['weekSchedule']
        .map((obj) => WeekDay.fromJson(obj.asMap()))
        .cast<WeekDay>()
        .toList();
    this.week1_3 = json['week1/3']
        .map((obj) => DateFormat("dd-MM-yyyy").parse(obj.toString()))
        .cast<DateTime>()
        .toList();
    this.week2_4 = json['week2/4']
        .map((obj) => DateFormat("dd-MM-yyyy").parse(obj.toString()))
        .cast<DateTime>()
        .toList();
  }

  @override
  String toString() {
    return '{"field":' +
        field.toString() +
        ',"weekSchedule":' +
        weekDay.toString() +
        '}';
  }

  String _checkWeek(DateTime input) {
    // making sure that time in dateTime is not something weird
    // so it will be easy to compare dates
    DateTime date = new DateTime(input.year, input.month, input.day);

    //checking each week 1/3
    for (DateTime element in week1_3) {
      DateTime elementCopy = element;

      // checking date in table
      if (elementCopy == date) return "1/3";

      // checking each day after in same week as start date
      while (true) {
        if (elementCopy.weekday < 7) {
          elementCopy = elementCopy.add(new Duration(days: 1));

          if (elementCopy == date) return "1/3";
        } else
          break;
      }
    }
    // checking each week 2/4
    for (DateTime element in week2_4) {
      DateTime elementCopy = element;

      // checking date in table

      if (elementCopy == date) return "2/4";

      // checking each day after in same week as start date
      while (true) {
        if (elementCopy.weekday < 7) {
          elementCopy = elementCopy.add(new Duration(days: 1));
          if (elementCopy == date) return "2/4";
        } else
          break;
      }
    }
    return "error";
  }

  _getLecturesForWeekDay(int weekDay) {
    // -1 cause array starts from 0, weekday from 1
    return this.weekDay[weekDay - 1];
  }

  ScheduleViewModel getLecturesForDay({
    DateTime date,
    int group,
    int laboratories,
    int specialization,
  }) {
    // print("Start");
    TimeOfDay start_time;
    TimeOfDay end_time;

    // SharedPreferences storage = await SharedPreferences.getInstance();

    String week = _checkWeek(date);

    // print("tydz: " + week.toString());

    //lectures to operate
    // WeekDay weekDay = this._getForWeekDay(date.weekday);
    // print("week: " + weekDay.toString());
    // print("weekday:" + date.weekday.toString());
    List<Lecture> lec = this.weekDay[date.weekday - 1].lectures;
    // print("lec:" + lec.toString());

    List<Lecture> filtered = new List<Lecture>();

    // getting lectures for the same week
    // if week == week or week of lecture not specified (all)
    for (Lecture l in lec) {
      if (l.weeks == week || l.weeks == "all") filtered.add(l);
    }

    //getting lectures only for this group
    //if group in lecture is specified and isn't same as saved remove
    List<Lecture> toRemove = new List<Lecture>();
    for (Lecture l in filtered) {
      if (!(l.group == 0 || l.group == group)) toRemove.add(l);
    }
    filtered.removeWhere((element) => toRemove.contains(element));

    //getting lectures only for this specialization
    //if specialization in lecture is specified and isn't same as saved remove
    toRemove.clear();
    for (Lecture l in filtered) {
      if (!(l.specialization == 0 || l.specialization == specialization))
        toRemove.add(l);
    }
    filtered.removeWhere((element) => toRemove.contains(element));

    //getting lectures only for this laboratories
    //if laboratories in lecture is specified and isn't same as saved remove
    toRemove.clear();
    // print("Xd");
    for (Lecture l in filtered) {
      if (!(l.laboratories == 0 || l.laboratories == laboratories))
        toRemove.add(l);
    }
    filtered.removeWhere((element) => toRemove.contains(element));

    // for (Lecture l in filtered) {
    // print(l.name.toString());
    // }

    if (filtered.length > 1) {
      start_time = filtered[0].start_time;
      end_time = filtered[filtered.length - 1].end_time;
    } else {
      filtered = new List<Lecture>();
      start_time = null;
      end_time = null;
    }
    // print("lec:" + filtered.toString());

    // print("start:" + start_time.toString());
    // print("start:" + end_time.toString());

    return new ScheduleViewModel(
        lectures_in_day: filtered, start_time: start_time, end_time: end_time);
  }
}
