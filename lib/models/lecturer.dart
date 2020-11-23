class Lecturer {
  String name;
  String surname;
  String email;
  String academic_title;

  Lecturer(this.name, this.surname, this.email, this.academic_title);

  Lecturer.fromJson(Map json) {
    this.name = json['name'];
    this.surname = json['surname'];
    this.email = json['email'];
    this.academic_title = json['academic_title'];
  }

  @override
  String toString() {
    return '{"name":"' +
        this.name +
        '","surname":"' +
        this.surname +
        '","email":"' +
        this.email +
        '","academic_title":"' +
        this.academic_title +
        '"}';
  }
}
