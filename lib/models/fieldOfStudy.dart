import 'package:schedule/models/specialization.dart';

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
    this.specializations = json['specializations']
        .map((obj) => Specialization.fromJson(obj))
        .cast<Specialization>()
        .toList();
    this.groups = json['groups'].cast<int>();
    this.laboratories = json['laboratories'].cast<int>();
  }

  getGroups() {
    return this.groups;
  }

  getLaboratories() {
    return this.laboratories;
  }

  getSpecializations() {
    return this.specializations;
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
