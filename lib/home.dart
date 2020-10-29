import 'package:flutter/material.dart';
import 'Theme/MyTheme.dart' as Theme;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

// ValueNotifier<int> _selectedDay = ValueNotifier(DateTime.now().weekday);

// void changeSelectedDay(int value) {
//   _selectedDay = ValueNotifier(value);
//   print(value);
// }

class _HomeViewState extends State<HomeView> {
  int _selectedDay = DateTime.now().weekday > 4 ? 0 : DateTime.now().weekday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Theme.Colors.DarkBlue,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            topRow(),
            // Padding(
            //   padding: const EdgeInsets.only(top: 16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children:
            //     // List.generate(
            //       // 5,
            //       // (index) => dateWidget(index: index),
            //     // ),
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }
}

class topRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.Colors.LighterBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Plan zajęć UR",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.Colors.ShadowLightBlue),
          ),
        ],
      ),
    );
  }
}

// class dateWidget extends StatefulWidget {
//   final index;
//   dateWidget({Key key, this.index}) : super(key: key);
//   @override
//   _dateWidgetState createState() => _dateWidgetState();
// }

// class _dateWidgetState extends State<dateWidget> {
//   var list = ["Pon", "Wto", "Śr", "Czw", "Pt"];
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<MyWeekDay>(
//       builder: (context) => MyWeekDay(),
//       child: InkWell(
//       onTap: () {
//         setState(() {
//           //remove style from others
//           changeSelectedDay(widget.index);
//         });
//       },
//       child: Container(
//         child: Row(
//           children: [
//             Container(
//                 child: Container(
//               padding: EdgeInsets.all(10),
//               decoration: _selectedDay.value == widget.index
//                   ? BoxDecoration(
//                       color: Theme.Colors.LighterBlue,
//                       borderRadius: BorderRadius.all(Radius.circular(10)))
//                   : null,
//               child: Column(
//                 children: [
//                   Text(
//                     list[widget.index],
//                     style: TextStyle(
//                         color: _selectedDay.value == widget.index
//                             ? Theme.Colors.ShadowLightBlue
//                             : Colors.grey.shade400,
//                         fontSize: 24,
//                         fontWeight: _selectedDay.value == widget.index
//                             ? FontWeight.bold
//                             : FontWeight.w400),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 6.0),
//                     width: 4,
//                     height: 4,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: _selectedDay.value == widget.index
//                             ? Theme.Colors.ShadowLightBlue
//                             : Colors.grey.shade500),
//                   )
//                 ],
//               ),
//             ))
//           ],
//         ),
//       ),
//     );
//     )
//   }
// }
