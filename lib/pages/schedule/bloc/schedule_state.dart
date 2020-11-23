part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();
  
  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}
