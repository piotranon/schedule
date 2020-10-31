import 'package:flutter/cupertino.dart';
import 'package:schedule/viewModels/weekDayView.dart';

class WeekModel extends ChangeNotifier {
  // Future<void> fetchAllWeekDays() async {
  //   final days = await Webservice().getSchedule();
  //   // this.days = days.map((day) => WeekDayListViewModel(weekDay: day)).toList();
  //   notifyListeners();
  // }
}

class WeekViewModel {
  final List<WeekDayViewModel> week;
  List<WeekDayViewModel> filtered;

  int group;
  int laboratories;

  WeekViewModel({this.week});

  setting() {
    group = 1;
    laboratories = 1;
  }

  filter() {
    filtered = new List<WeekDayViewModel>();

    for (var weekDay in week) {
      WeekDayViewModel dayFiltered = new WeekDayViewModel();
      for (var lecture in weekDay.weekDay.lectures) {}
    }
  }
}
