import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/Theme/MyTheme.dart' as Theme;
import 'package:schedule/pages/scheduleView.dart';

class MainView extends StatefulWidget {
  final String name;

  MainView({this.name});

  @override
  _MainView createState() => _MainView();
}

class _MainView extends State<MainView> {
  String currentMenu = "schedule";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Plan zajęć"),
                    onPressed: () {
                      setState(() {
                        currentMenu = "schedule";
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Calendar"),
                    onPressed: () {
                      setState(() {
                        currentMenu = "calendar";
                      });
                    },
                  ),
                ),
              ),
            ]),
          ),
          centerTitle: true,
          backgroundColor: Theme.Colors.DarkBlue,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  currentMenu = "settings";
                });
              },
            )
          ]),
      backgroundColor: Colors.white,
      body: (() {
        if (currentMenu == "schedule")
          return ScheduleView(
            daysNumbers: daysNumber(),
          );
        // else if (currentMenu == "calendar")
        // return weekDayListPage();
        else if (currentMenu == "settings") return Text("$currentMenu");
      }()),
    );
  }

  //return callendar day numbers for this week
  List daysNumber() {
    int selectedDay = DateTime.now().weekday;
    var list = new List(7);
    int daysdifference = 0 + selectedDay;

    for (int i = 0; i < list.length; i++) {
      if (i < selectedDay) {
        list[i] =
            DateTime.now().subtract(new Duration(days: daysdifference)).day;
        daysdifference--;
      } else if (i == selectedDay) {
        list[i] = DateTime.now().day;
        daysdifference++;
      } else if (i > selectedDay) {
        list[i] = DateTime.now().add(new Duration(days: daysdifference)).day;
        daysdifference++;
      }
    }
    // print(list);
    return list;
  }
}
