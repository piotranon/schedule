import 'package:flutter/material.dart';
import 'package:schedule/Theme/MyTheme.dart' as Theme;
import 'package:schedule/models/all.dart';
import 'package:schedule/pages/schedule/bloc/settings_bloc.dart';
import 'package:schedule/pages/schedule/bloc/settings_server_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schedule/models/schedule.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class SettingsView extends StatefulWidget {
  @override
  _SettingsView createState() => _SettingsView();
}

class _SettingsView extends State<SettingsView> {
  int _selectedDay = DateTime.now().weekday > 4 ? 0 : DateTime.now().weekday;

  final settingsBloc = new SettingsBloc();

  void initState() {
    super.initState();
    settingsBloc.add(GetSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SettingsBloc, SettingsState>(
        cubit: settingsBloc,
        builder: (context, state) {
          // print("cont " + context.toString());
          // print("state " + state.toString());
          if (state is SettingsLoading) {
            return buildLoading();
          } else if (state is SettingsLoaded) {
            return SettingsLoadedView(storage: state.storage);
          }
          return Container();
        },
      ),
    );
  }
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

class SettingsLoadedView extends StatefulWidget {
  final SharedPreferences storage;
  const SettingsLoadedView({Key key, this.storage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsLoadedView();
}

class _SettingsLoadedView extends State<SettingsLoadedView> {
  final settingsServerBloc = new SettingsServerBloc();

  void initState() {
    super.initState();
    settingsServerBloc.add(GetServerSettings());
  }

  @override
  Widget build(BuildContext context) {
    Schedule schedule =
        Schedule.fromJson(jsonDecode(widget.storage.get('schedule')));
    // print(schedule.toString());
    List<Specialization> specializations = schedule.field.specializations;
    List<int> groups = schedule.field.groups;
    List<int> laboratories = schedule.field.laboratories;
    Specialization spec = null;
    int group = widget.storage.getInt("group") ?? 0;
    int lab = widget.storage.getInt("laboratories") ?? 0;

    specializations.forEach((element) {
      if (element.id == widget.storage.getInt("specialization") ?? 0) {
        spec = element;
      }
    });
    if (spec == null) spec = specializations[0];

    // print(specializations);
    // print(spec);
    // print(groups);
    // print(group);
    // print(laboratories);
    // print(lab);

    FieldOfStudy field = schedule.field;

    return Container(
      color: Theme.Colors.LightestBlue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Text(
                          "Specjalizacja",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = Theme.Colors.ShadowDarkBlue,
                          ),
                        ),
                        Text(
                          "Specjalizacja",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Theme.Colors.ShadowLightBlue,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton(
                      hint: Text("Select Specialization"),
                      value: spec,
                      onChanged: (value) {
                        print("zmieniono " + value.toString());
                        setState(() {
                          widget.storage.setInt("specialization", value.id);
                        });
                      },
                      items:
                          specializations.map((Specialization specialization) {
                        return new DropdownMenuItem<Specialization>(
                          value: specialization,
                          child: Container(
                            child: Text(
                              specialization.name,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w600),
                            ),
                            alignment: Alignment.center,
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Text(
                          "Grupa",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = Theme.Colors.ShadowDarkBlue,
                          ),
                        ),
                        Text(
                          "Grupa",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Theme.Colors.ShadowLightBlue,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton(
                        hint: Text("Select Group"),
                        value: group,
                        items: groups.map((int value) {
                          return new DropdownMenuItem<int>(
                              value: value,
                              child: Container(
                                child: new Text(
                                  value.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                alignment: Alignment.center,
                              ));
                        }).toList(),
                        onChanged: (value) {
                          print("zmieniono " + value.toString());
                          setState(() {
                            widget.storage.setInt("group", value);
                          });
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Text(
                          "Grupa Laboratoryjna",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = Theme.Colors.ShadowDarkBlue,
                          ),
                        ),
                        Text(
                          "Grupa Laboratoryjna",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Theme.Colors.ShadowLightBlue,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton(
                        hint: Text("Select Laboratories"),
                        value: lab,
                        items: laboratories.map((int value) {
                          return new DropdownMenuItem<int>(
                              value: value,
                              child: Center(
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ));
                        }).toList(),
                        onChanged: (value) {
                          print("zmieniono " + value.toString());
                          setState(() {
                            widget.storage.setInt("laboratories", value);
                          });
                        }),
                  ],
                ),
              ),
              Stack(children: [
                Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Container(
                      height: 8.0,
                      width: 400.0,
                      color: Theme.Colors.ShadowDarkBlue,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 18.0, left: 3.0),
                    child: Container(
                      height: 4.0,
                      width: 355.0,
                      color: Colors.white,
                    ))
              ]),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Stack(
                  children: [
                    Text(
                      "Aktualny Plan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 4
                          ..color = Theme.Colors.ShadowDarkBlue,
                      ),
                    ),
                    Text(
                      "Aktualny Plan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Theme.Colors.ShadowLightBlue,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    field.name.toString() +
                        " / " +
                        field.year.toString() +
                        " / " +
                        field.semester.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Theme.Colors.DarkBlue,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: BlocBuilder<SettingsServerBloc, SettingsServerState>(
                  cubit: settingsServerBloc,
                  builder: (context, state) {
                    // print("cont " + context.toString());
                    // print("state " + state.toString());
                    print("settingsServerBloc loading");
                    if (state is SettingsServerLoading) {
                      return buildLoadingServer();
                    } else if (state is SettingsServerLoaded) {
                      return SettingsServerLoadedView(fields: state.fields);
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildLoadingServer() {
  return Column(
    children: [
      Center(
        child: CircularProgressIndicator(),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text("Łączenie z serwerem."),
      )
    ],
  );
}

class SettingsServerLoadedView extends StatefulWidget {
  final List<FieldOfStudy> fields;
  final FieldOfStudy field;
  const SettingsServerLoadedView({Key key, this.fields, this.field})
      : super(key: key);

  @override
  _SettingsServerView createState() => _SettingsServerView();
}

class _SettingsServerView extends State<SettingsServerLoadedView> {
  // void initState() {
  //   super.initState();
  //   settingsServerBloc.add(GetServerSettings());
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Text(
              "Lista Planów",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4
                  ..color = Theme.Colors.ShadowDarkBlue,
              ),
            ),
            Text(
              "Lista Planów",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Theme.Colors.ShadowLightBlue,
              ),
            ),
          ],
        ),
        DropdownButton(
            hint: Text("Wybierz plan do ustawienia"),
            items: widget.fields.map((FieldOfStudy value) {
              return new DropdownMenuItem<FieldOfStudy>(
                  value: value,
                  child: Center(
                    child: Text(
                      value.name.toString() +
                          " / " +
                          value.year.toString() +
                          " / " +
                          value.semester.toString(),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                  ));
            }).toList(),
            onChanged: (value) async {
              // print("zmieniono " + value.toString());
              // print("current: " + current.toString());
              // current = value;
              //przeładowanie na nowy plan
              final response = await http.get(
                  'http://10.0.2.2:8000/schedule/api/lectures/' +
                      value.id.toString());
              var json = jsonDecode(response.body);
              print("json response: " + json.toString());
              if (json["error"] != null) {
                print("error");
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("There was an error loading schedule"),
                    content: Text(json["error"].toString()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("okay"),
                      ),
                    ],
                  ),
                );
              } else {
                //zapisac json do pamieci przeładować cały widok
                Schedule schedule = Schedule.fromJson(json);
                print("ustawiono schedule: " + schedule.toString());
                SharedPreferences storage =
                    await SharedPreferences.getInstance();
                storage.setString("schedule", response.body);
                this.reassemble();
              }
            }),
      ],
    );
  }
}
