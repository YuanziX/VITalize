import 'package:hive_flutter/hive_flutter.dart';
import 'package:vitalize/app/core/utils/time_utils.dart';
import 'package:vitalize/data/constants.dart';
import 'package:vitalize/data/models/attendance.dart';
import 'package:vitalize/data/repositories/api_repository.dart';
import 'package:vitalize/data/utils/hive_box_utils.dart';

class HiveAttendanceRepository {
  APIRepository apiRepository = APIRepository();

  Future<Map<dynamic, Attendance>> get getAttendanceFromApiAndCache async {
    Box<Attendance> box = Hive.box<Attendance>(attendanceBoxName);

    if (await serverAvailable) {
      Map<String, Attendance> attendance = await apiRepository.getAttendance;
      if (attendance.isNotEmpty) {
        box.putAll(attendance);
        return attendance;
      }
    }
    Map<dynamic, Attendance> attendance = box.toMap();
    return attendance;
  }

  Future<Map<dynamic, Attendance>> get getAttendanceFromBox async {
    Box<Attendance> attendanceBox = Hive.box(attendanceBoxName);
    Box<String> userBox = Hive.box(userBoxName);
    String todaysDate = getTodaysDate;

    if (attendanceBox.isEmpty ||
        userBox.get(attendanceLastUpdated) != todaysDate ||
        userBox.get(allDataLastUpdated) != todaysDate) {
      userBox.put(attendanceLastUpdated, todaysDate);
      return getAttendanceFromApiAndCache;
    }

    return attendanceBox.toMap();
  }
}
