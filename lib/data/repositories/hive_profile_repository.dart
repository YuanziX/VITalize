import 'package:hive_flutter/hive_flutter.dart';
import 'package:vitalize/data/constants.dart';
import 'package:vitalize/data/repositories/api_repository.dart';
import 'package:vitalize/data/utils/hive_box_utils.dart';

class HiveProfileRepository {
  APIRepository apiRepository = APIRepository();

  Future<Map<dynamic, String>> get getProfileFromApiAndCache async {
    Box<String> box = Hive.box<String>(profileBoxName);

    if (await serverAvailable) {
      Map<String, String> profile = await apiRepository.getProfile;
      if (profile.isNotEmpty) {
        box.putAll(profile);
        return profile;
      }
    }
    Map<dynamic, String> profile = box.toMap();
    return profile;
  }

  Future<Map<dynamic, String>> get getProfileFromBox async {
    Box<String> profileBox = Hive.box(profileBoxName);

    if (profileBox.isEmpty) {
      return getProfileFromApiAndCache;
    }

    return profileBox.toMap();
  }
}
