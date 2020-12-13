part of 'settings_server_bloc.dart';

abstract class SettingsServerState extends Equatable {
  const SettingsServerState();

  @override
  List<Object> get props => [];

  get fields => null;
}

class SettingsServerLoading extends SettingsServerState {}

class SettingsServerLoaded extends SettingsServerState {
  final List<FieldOfStudy> fields;
  SettingsServerLoaded(this.fields);
}
