import 'package:flutter/material.dart';
import 'package:schedule/models/teacher.dart';

class Class {
  final String name;
  final TimeOfDay startTime;
  final int meetingTime;
  final Teacher teacher;

  Class(this.name, this.startTime, this.meetingTime, this.teacher);
}
