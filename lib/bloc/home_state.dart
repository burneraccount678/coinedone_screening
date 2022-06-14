part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class Loading extends HomeState {}

class Failed extends HomeState {}

class Success extends HomeState {
  final DataModel data;

  Success(this.data);

  String get totalDuration => durationToString(data.data.screenTime.total);
  String get classDuration =>
      durationToString(data.data.screenTime.screenTimeClass);
  String get studyDuration => durationToString(data.data.screenTime.study);
  String get freeTime => durationToString(data.data.screenTime.free);
  String get usedfreeTime => durationToString(data.data.freeTime.usage);
  String get freeTimeLimit => durationToString(data.data.freeTime.limit);
}
