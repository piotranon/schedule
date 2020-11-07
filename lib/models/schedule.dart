class Schedule {
  FieldOfStudy field;

  Week weekSchedule;

  Schedule(this.field, this.weekSchedule);

  Schedule.fromJson(Map json) {
    this.field = FieldOfStudy.fromJson(json['fieldOfStudy']);
    // print("xd: " + json['weekSchedule'].toString());
    this.weekSchedule = Week.fromJson(json['weekSchedule']);
  }

  @override
  String toString() {
    return '{"field":' + field.toString() + '}';
  }
}

class FieldOfStudy {
  int id;
  String name;
  int semester;
  String year;
  List<Specialization> specializations;
  List<int> groups;
  List<int> laboratories;

  FieldOfStudy(this.id, this.name, this.semester, this.year,
      this.specializations, this.groups, this.laboratories);

  FieldOfStudy.fromJson(Map json) {
    this.id = json['id'];
    this.name = json['name'];
    this.semester = json['semester'];
    this.year = json['year'];
    List<Specialization> spec = new List<Specialization>();
    json['specializations'].forEach((element) {
      spec.add(Specialization.fromJson(element));
    });

    // this.specializations = spec;
    this.specializations = json['specializations']
        .map((obj) => Specialization.fromJson(obj))
        .cast<Specialization>()
        .toList();
    this.groups = json['groups'].cast<int>();
    this.laboratories = json['laboratories'].cast<int>();
  }

  @override
  String toString() {
    return '{"id":' +
        id.toString() +
        ',"name":"' +
        name.toString() +
        '","semester":' +
        semester.toString() +
        ',"year":"' +
        year.toString() +
        '","specializations":' +
        specializations.toString() +
        ',"groups":' +
        groups.toString() +
        ',"laboratories":' +
        laboratories.toString() +
        '}';
  }
}

class Specialization {
  int id;
  String name;
  String short;
  Specialization(this.id, this.name, this.short);

  Specialization.fromJson(Map json) {
    this.id = json['id'];
    this.name = json['name'];
    this.short = json['short'];
  }

  @override
  String toString() {
    return '{"id":' +
        id.toString() +
        ',"name":"' +
        name.toString() +
        '","short":"' +
        short.toString() +
        '"}';
  }
}

class Week {
  List<WeekDay> weekDay;

  Week(this.weekDay);

  Week.fromJson(Map json) {
    print("json: " + json.toString());
    print("da: " + json.runtimeType.toString());
    
    this.weekDay = json.map((key, value) => WeekDay.fromJson())

    // this.weekDay = json
  }

  @override
  String toString() {
    return this.weekDay.toString();
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
  final String end_time;
  final int group;
  final int laboratories;
  final Lecturer lecturer;

  Lecture(
      {this.weeks,
      this.name,
      this.start_time,
      this.end_time,
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
        this.end_time +
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
