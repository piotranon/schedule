class Week {
  final String fieldOfStudy;
  final String yearOfStudy;
  final List<WeekDay> weekDay;

  Week({this.fieldOfStudy, this.yearOfStudy, this.weekDay});
  @override
  String toString() {
    return this.fieldOfStudy +
        " | " +
        this.fieldOfStudy +
        " | " +
        this.weekDay.toString();
  }
}

class WeekDay {
  final String dayName;
  final List<Lecture> lectures;

  WeekDay({this.dayName, this.lectures});
}

class Lecture {
  final String weeks;
  final String name;
  final String start_time;
  final int duration;
  final int group;
  final int laboratories;
  final Lecturer lecturer;

  Lecture(
      {this.weeks,
      this.name,
      this.start_time,
      this.duration,
      this.group,
      this.laboratories,
      this.lecturer});
  @override
  String toString() {
    return this.weeks +
        " | " +
        this.name +
        " | " +
        this.start_time +
        " | " +
        this.duration.toString() +
        " | " +
        this.group.toString() +
        " | " +
        this.laboratories.toString() +
        " | " +
        this.lecturer.toString();
  }
}

class Lecturer {
  final String name;
  final String surname;
  final String email;
  final String academic_title;

  Lecturer({this.name, this.surname, this.email, this.academic_title});

  @override
  String toString() {
    return this.name +
        " | " +
        this.surname +
        " | " +
        this.email +
        " | " +
        this.academic_title;
  }
}
