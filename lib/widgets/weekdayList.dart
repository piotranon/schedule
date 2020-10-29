import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/viewmodels/weekDayListViewModel.dart';

class WeekDayList extends StatelessWidget {
  final List<WeekDayListViewModel> days;
  WeekDayList({this.days});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.days.length,
      itemBuilder: (BuildContext context, int index) {
        final day = this.days[index];

        return ListTile(
          title: Text(day.toString()),
        );
      },
    );
  }
}
