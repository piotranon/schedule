import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/Theme/MyTheme.dart' as Theme;

class ScheduleView extends StatefulWidget {
  final String name;
  final List daysNumbers;

  ScheduleView({this.name, this.daysNumbers});

  @override
  _ScheduleView createState() => _ScheduleView();
}

class _ScheduleView extends State<ScheduleView> {
  int selectedDay = DateTime.now().weekday;
  bool isWeekEven = true;
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
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Text(selectedDay.toString()),
              Row(
                children: [
                  HoursCard(),
                ],
              ),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard(),
              ClassCard()
            ],
          ),
        ))
      ],
    );
  }
}

class HoursCard extends StatelessWidget {
  const HoursCard({
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
        // Expanded(
        //     child: Container(
        //   height: 100.0,
        //   decoration: BoxDecoration(
        //       color: Colors.red,
        //       borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(8.0),
        //           bottomLeft: Radius.circular(8.0))),
        //   child: Container(
        //     margin: EdgeInsets.only(left: 4.0),
        //     color: Color(0xfffcf9f5),
        //     padding: EdgeInsets.only(left: 12.0, top: 8.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Container(
        //           height: 21.0,
        //           child: Row(
        //             children: [
        //               Text("13:00-14:00"),
        //               VerticalDivider(),
        //               Text("Dodatkowy tekst"),
        //             ],
        //           ),
        //         ),
        //         Text(
        //           "Opis wydarzenia",
        //           style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
        //         )
        //       ],
        //     ),
        //   ),
        // ))
      ],
    );
  }
}

class ClassCard extends StatelessWidget {
  const ClassCard({
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
          height: 100.0,
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
