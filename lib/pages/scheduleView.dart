import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/Theme/MyTheme.dart' as Theme;
import 'package:schedule/models/all.dart';
import 'package:http/http.dart' as http;
import 'package:schedule/viewModels/ScheduleViewModel.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ScheduleView extends StatefulWidget {
  final String name;
  final List daysNumbers;

  ScheduleView({this.name, this.daysNumbers});

  @override
  _ScheduleView createState() => _ScheduleView();
}

refresh() async {
  print("ref1");
  SharedPreferences storage = await SharedPreferences.getInstance();
  var a = storage.get('test');
  if (a != null) {
    print("a exist " + a.toString());
  } else {
    storage.setString('test', "ale pamiec");
    print("not exist" + a.toString());
  }
  print("ref2");
  // print("data " + storage.getKeys().toList().toString());
  // var storageService = locator<LocalStorageService>();
  // print(storage.getKeys().toList().toString());
}

getData() async {
  print("get data");
  final response =
      await http.get('http://10.0.2.2:8000/schedule/api/lectures/1');
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body) as Map;
    print("response: " + response.body);
    // Map xd = jsonCodec.decode()
    Map test = jsonDecode(response.body);
    var x = Schedule.fromJson(test);

    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('schedule', response.body);
    print("st:" + storage.get('schedule'));
  }
  print("get data end");
}

accessData() async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  print("schedule:" + storage.get('schedule').toString());
  print("group " + storage.getInt("group").toString());
  print("laboratories " + storage.getInt("laboratories").toString());
  print("specialization " + storage.getInt("specialization").toString());
  return Schedule.fromJson(jsonDecode(storage.get('schedule')));
}

setSettings() async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  storage.setInt("group", 1);
  storage.setInt("laboratories", 1);
  storage.setInt("specialization", 1);
  print("group " + storage.getInt("group").toString());
  print("laboratories " + storage.getInt("laboratories").toString());
  print("specialization " + storage.getInt("specialization").toString());
}

checkSchedule() async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  print("st:" + storage.get('schedule').toString());
  Schedule xd = Schedule.fromJson(jsonDecode(storage.get('schedule')));
  // ScheduleViewModel test = await xd.getLecturesForDay(DateTime.now());
  // print("schedule View " + test.toString());
  // todo z tego scheduleViewModel wygenerowac wyglad przy zmianie
}

class _ScheduleView extends State<ScheduleView> {
  int selectedDay = DateTime.now().weekday;
  bool isWeekEven = true;

  // Schedule x = accessData();

  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) => reload());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              color: Theme.Colors.DarkBlue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: List.generate(
                      7,
                      (index) => Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedDay = index;
                                });
                              },
                              child: DayWidget(
                                index: index,
                                activeButton: selectedDay,
                                daysNumbers: widget.daysNumbers,
                              ),
                            ),
                          )),
                ),
              ),
            ),
          ],
        ),
        LecturesView(
          selectedDay: selectedDay,
        ),
        RaisedButton(
          onPressed: accessData,
          child: Text("accessData"),
        ),
        RaisedButton(
          onPressed: getData,
          child: Text("getdata"),
        ),
        RaisedButton(
          onPressed: setSettings,
          child: Text("setSettings"),
        ),
        RaisedButton(
          onPressed: checkSchedule,
          child: Text("checkSchedule"),
        )
      ],
    );
  }
}

class LecturesView extends StatelessWidget {
  const LecturesView({
    Key key,
    this.selectedDay,
    this.startTime,
    this.endTime,
  }) : super(key: key);

  final int selectedDay;
  final String startTime;
  final String endTime;
  // final WeekDayViewModel weekDay;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Text(selectedDay.toString()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HoursCard(startTime: "13:00", endTime: "16:00"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: Column(
                    children: [
                      ClassCard(
                        paddingTop: 0.0,
                      ),
                      ClassCard(
                        paddingTop: 45.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class ClassCard extends StatelessWidget {
  final double paddingTop;
  const ClassCard({
    Key key,
    this.paddingTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Container(
        child: Column(
          children: [
            Container(
              height: 90.0,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0))),
              child: Container(
                margin: EdgeInsets.only(left: 4.0),
                color: Color(0xfffcf9f5),
                padding: EdgeInsets.only(left: 12.0, top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 21.0,
                      child: Row(
                        children: [
                          Text("13:00-14:00"),
                          VerticalDivider(),
                          Text("Dodatkowy tekst"),
                        ],
                      ),
                    ),
                    Text(
                      "Opis wydarzenia",
                      style: TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HoursCard extends StatelessWidget {
  final startTime;
  final endTime;
  const HoursCard({
    Key key,
    this.startTime,
    this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: hoursLines2(startTime, endTime),
          ),
        ),
      ],
    );
  }

  Column hoursLines2(TimeOfDay startTime, TimeOfDay endTime) {
    List<Widget> hours = [];
    TimeOfDay x = new TimeOfDay(hour: startTime.hour, minute: 0);

    TimeOfDay end;
    if (endTime.minute > 0) {
      end = new TimeOfDay(hour: endTime.hour + 1, minute: 0);
    } else {
      end = new TimeOfDay(hour: endTime.hour, minute: 0);
    }

    while (true) {
      hours.add(LineGen2(lines: [30.0, 10.0, 20.0, 10.0], godz: x.toString()));
      if (x == end) break;
    }

    return Column(
      children: hours,
    );
  }

  Column hoursLines(String startTime, String endTime) {
    var startTimeFormated =
        int.parse(startTime.substring(0, startTime.indexOf(":")));

    var endTimeFormated = int.parse(endTime.substring(0, endTime.indexOf(":")));
    var temp2 = int.parse(endTime.substring(endTime.indexOf(":") + 1));
    if (temp2 > 0) endTimeFormated += 1;

    List<Widget> hours = [];

    hours.add(LineGen2(
        lines: [30.0, 10.0, 20.0, 10.0],
        godz: startTimeFormated.toString() + ":00"));

    var index = startTimeFormated + 1;
    while (index <= endTimeFormated) {
      if (index != endTimeFormated)
        hours.add(LineGen2(
            lines: [30.0, 10.0, 20.0, 10.0], godz: index.toString() + ":00"));
      else
        hours.add(LineGen2(lines: [30.0], godz: index.toString() + ":00"));
      index++;
    }

    return Column(
      children: hours,
    );
  }
}

class ClassCard2 extends StatelessWidget {
  const ClassCard2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Godzina"),
              LineGen(lines: [10.0, 20.0, 10.0, 20.0]),
            ],
          ),
        ),
        SizedBox(
          width: 12.0,
        ),
        Expanded(
            child: Container(
          height: 88.0,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0))),
          child: Container(
            margin: EdgeInsets.only(left: 4.0),
            color: Color(0xfffcf9f5),
            padding: EdgeInsets.only(left: 12.0, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 21.0,
                  child: Row(
                    children: [
                      Text("13:00-14:00"),
                      VerticalDivider(),
                      Text("Dodatkowy tekst"),
                    ],
                  ),
                ),
                Text(
                  "Opis wydarzenia",
                  style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ))
      ],
    );
  }
}

class LineGen extends StatelessWidget {
  final List lines;
  const LineGen({
    Key key,
    this.lines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          4,
          (index) => Container(
            width: lines[index],
            height: 2,
            color: Color(0xffd0d2d8),
            margin: EdgeInsets.symmetric(vertical: 14.0),
          ),
        ));
  }
}

class LineGen2 extends StatelessWidget {
  final List lines;
  final String godz;
  const LineGen2({
    Key key,
    this.lines,
    this.godz,
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
                    godz,
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

class DayWidget extends StatefulWidget {
  final index;
  final activeButton;
  final daysNumbers;

  const DayWidget({Key key, this.index, this.activeButton, this.daysNumbers})
      : super(key: key);
  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<DayWidget> {
  var weekDayNames = ["Pon", "Wt", "Śr", "Czw", "Pt", "Sob", "Niedz"];
  int currentDay = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.activeButton == widget.index
          ? BoxDecoration(
              color: Theme.Colors.LightestBlue,
              borderRadius: BorderRadius.all(Radius.circular(6)))
          : null,
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: [
          Text(
            weekDayNames[widget.index],
            style: widget.activeButton == widget.index
                ? TextStyle(
                    color: Theme.Colors.ShadowLightBlue,
                    fontWeight: FontWeight.bold)
                : TextStyle(
                    color: Theme.Colors.ShadowLightBlue.withOpacity(0.5),
                    fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Text(widget.daysNumbers[widget.index].toString(),
                style: widget.activeButton == widget.index
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
                  color: widget.activeButton == widget.index
                      ? Theme.Colors.ShadowLightBlue
                      : Theme.Colors.ShadowLightBlue.withOpacity(0.5)),
            ),
          )
        ],
      ),
    );
  }
}
