import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vitalize/data/constants.dart';
import 'package:vitalize/data/models/attendance.dart';
import 'package:vitalize/data/models/marks.dart';
import 'package:vitalize/data/models/periods.dart';
import 'package:vitalize/data/utils/attendance_parser.dart';
import 'package:vitalize/data/utils/hive_box_utils.dart';
import 'package:vitalize/data/utils/marks_parser.dart';
import 'package:vitalize/data/utils/profile_parser.dart';
import 'package:vitalize/data/utils/sem_id_parser.dart';
import 'package:vitalize/data/utils/timetable_parser.dart';
import 'package:vitalize/data/models/response.dart';

class APIRepository {
  Future<Map<String, Periods>> get getTimetable async {
    try {
      final http.Response resp =
          await http.post(Uri.parse(timetableURL), body: getCreds);
      if (resp.statusCode == 200) {
        Map<String, Periods> timetable =
            parseTimetableAllDays(jsonDecode(resp.body));
        return timetable;
      }
    } on Exception {
      // return empty dict
    }
    return {};
  }

  Future<Map<String, String>> get getProfile async {
    try {
      final http.Response resp =
          await http.post(Uri.parse(profileURL), body: getCreds);
      if (resp.statusCode == 200) {
        return parseProfile(jsonDecode(resp.body));
      }
    } on Exception {
      // return empty dict
    }
    return {};
  }

  Future<Response<Map<String, Attendance>>> get getAttendance async {
    try {
      final http.Response resp =
          await http.post(Uri.parse(attendanceURL), body: getCreds);
      if (resp.statusCode == 200) {
        return Response.bool(parseAttendance(jsonDecode(resp.body)), true);
      }
    } on Exception {
      // return empty dict
    }
    return Response.bool({}, false);
  }

  Future<Map<String, String>> get getSemIDs async {
    try {
      final http.Response resp =
          await http.post(Uri.parse(semIDsURL), body: getCreds);
      if (resp.statusCode == 200) {
        return parseSemID(jsonDecode(resp.body));
      }
    } on Exception {
      // return empty dict
    }
    return {};
  }

  Future<Map<String, Marks>> getMarks(String semID) async {
    Map<dynamic, String> body = getCreds;
    body['semID'] = semID;
    try {
      final http.Response resp =
          await http.post(Uri.parse(marksURL), body: body);
      if (resp.statusCode == 200) {
        return parseMarks(jsonDecode(resp.body));
      }
    } on Exception {
      // return empty dict
    }
    return {};
  }

  Future<Map> get getGrades async {
    try {
      final http.Response resp =
          await http.post(Uri.parse(gradesURL), body: getCreds);
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      }
    } on Exception {
      // return empty dict
    }
    return {};
  }

  Future<Response<Map>> get getExamSchedule async {
    try {
      final http.Response resp =
          await http.post(Uri.parse(examScheduleURL), body: getCreds);
      if (resp.statusCode == 200) {
        return Response.bool(jsonDecode(resp.body), true);
      }
    } on Exception {
      // return empty dict
    }
    return Response.bool({}, false);
  }

  Future<Map<String, Map<String, dynamic>>> get getAll async {
    try {
      final http.Response resp =
          await http.post(Uri.parse(allURL), body: getCreds);

      var body = jsonDecode(resp.body);

      if (resp.statusCode == 200) {
        Map<String, Map<String, dynamic>> all = {};
        all['timetable'] = parseTimetableAllDays(body['timetable']);
        all['profile'] = parseProfile(body['profile']);
        all['attendance'] = parseAttendance(body['attendance']);
        all['semIDs'] = parseSemID(body['semIDs']);
        all['grades'] = body['grades'];
        all['examSchedule'] = body['examSchedule'];
        return all;
      }
    } on Exception {
      // return empty dict
    }
    return {};
  }
}
