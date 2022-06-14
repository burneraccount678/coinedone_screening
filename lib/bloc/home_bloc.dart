import 'package:coinedone_screening/data_layer/data_repo.dart';
import 'package:coinedone_screening/data_layer/models.dart';
import 'package:coinedone_screening/data_layer/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DataRepo dataRepo;
  HomeBloc({required this.dataRepo}) : super(HomeInitial()) {
    on<LoadDataEvent>(_onLoadingEvent);
  }

  void _onLoadingEvent(LoadDataEvent event, Emitter emitter) async {
    try {
      emitter(Loading());
      final data = await dataRepo.fetchdata();
      emitter(Success(data));
    } catch (e) {
      emitter(Failed());
    }
  }
}
