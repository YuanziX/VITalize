import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalize/data/repositories/hive_sem_ids_repository.dart';

part 'semester_id_menu_state.dart';

class SemesterIDsMenuCubit extends Cubit<SemesterIDsMenuState> {
  HiveSemIDsRepository repository = HiveSemIDsRepository();

  SemesterIDsMenuCubit() : super(SemesterIDsMenuInitial());

  void getSemIDs() async {
    Map<dynamic, String> semIDs = await repository.getSemIDsFromBox;
    List<MapEntry<dynamic, String>> sortedList = semIDs.entries.toList();
    sortedList.sort((a, b) => b.key.toString().compareTo(a.key.toString()));
    emit(SemesterIDsMenuLoaded(Map.fromEntries(sortedList)));
  }
}
