import 'package:hive_flutter/hive_flutter.dart';

import 'package:vtop_app/0_data/constants.dart';
import 'package:vtop_app/0_data/models/attendance.dart';
import 'package:vtop_app/0_data/utils/hive_box_utils.dart';
import 'package:vtop_app/0_data/repositories/api_repository.dart';

class HiveAttendanceRepository {
  APIRepository apiRepository = APIRepository();
  Future<Map<dynamic, Attendance>> get getAttendanceFromApiAndCache async {
    Box<Attendance> box = Hive.box<Attendance>(attendanceBoxName);

    if (await serverAvailable) {
      Map<dynamic, String> user = getCreds;

      Map<String, Attendance> attendance = await apiRepository.getAttendance(
          user['username']!, user['password']!);
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
    String day = DateTime.now().day.toString();

    if (attendanceBox.isEmpty || userBox.get('attendanceLastUpdated') != day) {
      userBox.put('attendanceLastUpdated', day);
      return getAttendanceFromApiAndCache;
    }

    return attendanceBox.toMap();
  }
}
