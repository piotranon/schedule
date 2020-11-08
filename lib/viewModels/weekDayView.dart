import 'package:flutter/cupertino.dart';
import 'package:schedule/models/models.dart';

class WeekDayModel extends ChangeNotifier {
  List<WeekDayViewModel> days;

  // Future<void> fetchAllWeekDays() async {
  //   final days = await Webservice().getSchedule();
  //   // this.days = days.map((day) => WeekDayListViewModel(weekDay: day)).toList();
  //   notifyListeners();
  // }
}

class WeekDayViewModel {
  WeekDay weekDay;

  String startTime;
  String endTime;

  WeekDayViewModel({this.weekDay});

  settings() {
    // startTime = weekDay.lectures[0].start_time;
    // endTime = weekDay.lectures[weekDay.lectures.length - 1].end_time;
  }
}
