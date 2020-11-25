part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetSchedule extends ScheduleEvent {
  final DateTime day;

  GetSchedule(this.day);
}
