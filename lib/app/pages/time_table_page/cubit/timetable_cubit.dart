import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalize/data/models/period.dart';
import 'package:vitalize/data/repositories/hive_timetable_repository.dart';
import 'package:vitalize/app/core/utils/time_utils.dart';

part 'timetable_state.dart';

class TimetableCubit extends Cubit<TimetableState> {
  HiveTimetableRepository repository = HiveTimetableRepository();

  TimetableCubit() : super(TimetableInitial());

  void todayTimeTable() async {
    emit(TimetableLoading());
    String day = todayAsWord;
    if (day != 'Holiday') {
      List<Period> periods =
          (await repository.getTimetableFromBox)[todayAsWord]!.periods;
      emit(TimetablePeriods(periods));
    } else {
      emit(TimetableHoliday());
    }
  }

  void timetableByDay(String day) async {
    emit(TimetableLoading());
    emit(
        TimetablePeriods((await repository.getTimetableFromBox)[day]!.periods));
  }
}
