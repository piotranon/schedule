import 'package:schedule/models/lecture.dart';

class WeekDay {
  // final String dayName;
  List<Lecture> lectures = new List<Lecture>();

  WeekDay(this.lectures);

  WeekDay.fromJson(Map json) {
    json.forEach((key, value) {
      lectures.add(Lecture.toJson(value));
    });
  }

  @override
  String toString() {
    return lectures.toString();
  }
}
