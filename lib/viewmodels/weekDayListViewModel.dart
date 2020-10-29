import 'package:flutter/cupertino.dart';
import 'package:schedule/models/week.dart';
import 'package:schedule/services/webservice.dart';

class WeekViewModel extends ChangeNotifier {
  List<WeekDayListViewModel> days;

  Future<void> fetchAllWeekDays() async {
    final days = await Webservice().getSchedule();
    // this.days = days.map((day) => WeekDayListViewModel(weekDay: day)).toList();
    notifyListeners();
  }
}

class WeekDayListViewModel {
  final String dayName;
  final WeekDay weekDay;

  WeekDayListViewModel({this.dayName, this.weekDay});
}
