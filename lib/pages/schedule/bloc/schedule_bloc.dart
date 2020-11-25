import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:schedule/models/schedule.dart';
import 'package:schedule/viewModels/ScheduleViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleLoading());

  @override
  Stream<ScheduleState> mapEventToState(
    ScheduleEvent event,
  ) async* {
    if (event is GetSchedule) {
      print("Schedule Loading1");
      yield ScheduleLoading();
      print("Schedule Loading2");

      //get data
      // Future.delayed(const Duration(seconds: 3));
      //getting storage items
      SharedPreferences storage = await SharedPreferences.getInstance();
      Schedule xd = Schedule.fromJson(jsonDecode(storage.get('schedule')));

      int group = storage.getInt("group") ?? 0;
      int laboratories = storage.getInt("laboratories") ?? 0;
      int specialization = storage.getInt("specialization") ?? 0;
      print("zala");
      ScheduleViewModel scheduleForDay = xd.getLecturesForDay(
          date: event.day,
          group: group,
          laboratories: laboratories,
          specialization: specialization);
      print("zala");

      print("Schedule loaded1");
      yield ScheduleLoaded(scheduleForDay);
      print("Schedule loaded1");
    }
  }
}
