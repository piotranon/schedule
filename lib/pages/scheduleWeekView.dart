import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/Theme/MyTheme.dart' as Theme;
import 'package:schedule/pages/schedule/bloc/schedule_bloc.dart';
import 'package:schedule/viewModels/ScheduleViewModel.dart';

class ScheduleWeekView extends StatefulWidget {
  @override
  _ScheduleWeekView createState() => _ScheduleWeekView();
}

class _ScheduleWeekView extends State<ScheduleWeekView> {
  DateTime currentDay = DateTime.now();
  List<DateTime> week = new List<DateTime>();
  DateTime selectedDay = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final scheduleBloc = new ScheduleBloc();

  void initState() {
    super.initState();

    DateTime xd =
        new DateTime(currentDay.year, currentDay.month, currentDay.day);
    DateTime weekStartDay =
        xd.subtract(new Duration(days: currentDay.weekday - 1));
    week.add(weekStartDay);
    while (weekStartDay.weekday < 7) {
      weekStartDay = weekStartDay.add(new Duration(days: 1));
      week.add(weekStartDay);
    }

    print(week.toString());

    scheduleBloc.add(GetSchedule(selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.Colors.DarkBlue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                for (var weekDay in week)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedDay = weekDay;
                          scheduleBloc.add(GetSchedule(selectedDay));
                        });
                      },
                      child: WeekDayWidget(
                        day: week[weekDay.weekday - 1],
                        selectedDay: selectedDay,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        Text("${selectedDay.toString()} - xd"),
        Container(
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
          cubit: scheduleBloc,
          builder: (context, state) {
            print("cont " + context.toString());
            print("state " + state.toString());
            if (state is ScheduleLoading) {
              return buildLoading();
            } else if (state is ScheduleLoaded) {
              return buildLoaded(state.schedule);
            }
            return Container();
          },
        ))
      ],
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Text buildText(ScheduleViewModel day) {
    return Text("elo " + day.toString());
  }

  Widget buildLoaded(ScheduleViewModel model) {
    if (model.lectures_in_day.length < 1)
      return Text("Nie masz zajeć :D");
    else
      return Expanded(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text(model.toString()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeLine(
                  startTime: model.start_time,
                  endTime: model.end_time,
                ),
              ],
            ),
          ],
        ),
      ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class WeekDayWidget extends StatefulWidget {
  final DateTime day;
  final DateTime selectedDay;

  const WeekDayWidget({Key key, this.day, this.selectedDay}) : super(key: key);

  @override
  _WeekDayWidget createState() => _WeekDayWidget();
}

class _WeekDayWidget extends State<WeekDayWidget> {
  var weekDayNames = ["Pon", "Wt", "Śr", "Czw", "Pt", "Sob", "Niedz"];

  @override
  Widget build(BuildContext context) {
    bool active = widget.day == widget.selectedDay;

    return Container(
      decoration: active
          ? BoxDecoration(
              color: Theme.Colors.LightestBlue,
              borderRadius: BorderRadius.all(Radius.circular(6)))
          : null,
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: [
          Text(
            weekDayNames[widget.day.weekday - 1],
            style: active
                ? TextStyle(
                    color: Theme.Colors.ShadowLightBlue,
                    fontWeight: FontWeight.bold)
                : TextStyle(
                    color: Theme.Colors.ShadowLightBlue.withOpacity(0.5),
                    fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Text(widget.day.day.toString(),
                style: active
                    ? TextStyle(
                        color: Theme.Colors.ShadowLightBlue,
                        fontWeight: FontWeight.bold)
                    : TextStyle(
                        color: Theme.Colors.ShadowLightBlue.withOpacity(0.5),
                        fontWeight: FontWeight.normal)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Container(
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: active
                      ? Theme.Colors.ShadowLightBlue
                      : Theme.Colors.ShadowLightBlue.withOpacity(0.5)),
            ),
          )
        ],
      ),
    );
  }
}

class TimeLine extends StatelessWidget {
  final startTime;
  final endTime;

  const TimeLine({Key key, this.startTime, this.endTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child:
                // Text(endTime.toString()),
                hours_lines(startTime, endTime),
          ),
        ),
      ],
    );
  }

  Column hours_lines(TimeOfDay startTime, TimeOfDay endTime) {
    List<Widget> hours = [];
    TimeOfDay x = new TimeOfDay(hour: startTime.hour, minute: 0);
    TimeOfDay end;
    if (endTime.minute > 0) {
      end = new TimeOfDay(hour: endTime.hour + 1, minute: 0);
    } else {
      end = new TimeOfDay(hour: endTime.hour, minute: 0);
    }

    while (true) {
      String time = x.hour.toString() + ":00";
      hours.add(LineGen(lines: [30.0, 10.0, 20.0, 10.0], time: time));
      x = new TimeOfDay(hour: x.hour + 1, minute: 0);
      print(x.toString());
      if (x == end) break;
    }

    //last line
    String time = x.hour.toString() + ":00";
    hours.add(LineGen(lines: [30.0], time: time));

    return Column(
      children: hours,
    );
  }
}

class LineGen extends StatelessWidget {
  final List lines;
  final String time;
  const LineGen({
    Key key,
    this.lines,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          lines.length,
          (index) => Row(
            children: [
              Container(
                width: lines[index],
                height: 2,
                color: Color(0xffd0d2d8),
                margin: EdgeInsets.symmetric(vertical: 10.0),
              ),
              if (index == 0)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: Color(0xff8b8b8f),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
