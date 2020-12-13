import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule/models/all.dart';
import 'package:http/http.dart' as http;

part 'settings_server_event.dart';
part 'settings_server_state.dart';

class SettingsServerBloc
    extends Bloc<SettingsServerEvent, SettingsServerState> {
  SettingsServerBloc() : super(SettingsServerLoading());

  @override
  Stream<SettingsServerState> mapEventToState(
    SettingsServerEvent event,
  ) async* {
    if (event is GetServerSettings) {
      print("SettingsServerLoading started");
      yield SettingsServerLoading();
      print("SettingsServerLoading2");

      final response =
          await http.get('http://10.0.2.2:8000/schedule/api/lectures/');
      // final json = jsonDecode() as Map;
      final List<dynamic> json = jsonDecode(response.body);

      print("json: " + json.toString());

      List<FieldOfStudy> fields = json
          .map((obj) => FieldOfStudy.fromJson(obj))
          .cast<FieldOfStudy>()
          .toList();
      print("fields: " + fields.toString());

      print("response:" + response.body);

      print("SettingsServerLoaded");
      yield SettingsServerLoaded(fields);
      print("SettingsServerLoaded2");
    }
  }
}
