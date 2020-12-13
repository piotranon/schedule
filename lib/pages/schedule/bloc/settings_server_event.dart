part of 'settings_server_bloc.dart';

abstract class SettingsServerEvent extends Equatable {
  const SettingsServerEvent();

  @override
  List<Object> get props => [];
}

class GetServerSettings extends SettingsServerEvent {}
