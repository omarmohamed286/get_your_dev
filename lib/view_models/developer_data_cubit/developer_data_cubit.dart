import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_your_dev/app/repositories/developer_data_repository.dart';
import 'package:get_your_dev/models/developer_model.dart';
import 'package:meta/meta.dart';
part 'developer_data_state.dart';

class DeveloperDataCubit extends Cubit<DeveloperDataState> {
  DeveloperDataCubit(this.dev) : super(DeveloperDataInitial());
  DeveloperDataRepository dev;

  List<DeveloperModel> developersList = [];
  DeveloperModel? developerModel;

  Future<void> addDeveloper(DeveloperModel developerModel) async {
    emit(DeveloperAddingLoading());
    try {
      await dev.addDeveloper(developerModel);
      emit(DeveloperAddingSuccess());
    } catch (e) {
      emit(DeveloperAddingFailure(e.toString()));
    }
  }

  Future<void> getDevelopers() async {
    emit(DeveloperDataLoading());
    try {
      developersList = await dev.getDevelopers();
      emit(DeveloperDataSuccess());
    } catch (e) {
      DeveloperDataFailure(e.toString());
    }
  }

  Future<void> getCurrentDeveloper() async {
    emit(CurrentDeveloperLoading());
    try {
      developerModel = await dev.getCurrentDeveloper();
      emit(CurrentDeveloperSuccess());
    } catch (e) {
      emit(CurrentDeveloperFailure());
    }
  }
}
