import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsLoading());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is GetSettings) {
      print("SettingsLoading started");
      yield SettingsLoading();
      print("SettingsLoading2");

      SharedPreferences storage = await SharedPreferences.getInstance();

      print("SettingsLoaded");
      yield SettingsLoaded(storage);
      print("SettingsLoaded2");
    }
  }
}
