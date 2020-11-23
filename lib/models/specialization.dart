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
