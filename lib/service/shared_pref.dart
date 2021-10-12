import 'package:shared_preferences/shared_preferences.dart';

const String USER_UID_KEY = "uid";
const String CURRENT_DATE = "date";

class SharedPref {
  //--------START UID----------------//
  void saveUserUID(String userUID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(USER_UID_KEY, userUID);
    var now = DateTime.now();
    var timeToSave = DateTime(now.year, now.month, now.day);
    saveCurrentDate(timeToSave.toString());
  }

  Future<String> getUserUID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? uid = preferences.getString(USER_UID_KEY);
    return uid!;
  }

  //-------- END UID---------------------------//

  //--------START UID SAVED DATE----------------//
  void saveCurrentDate(String date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(CURRENT_DATE, date);
  }

  Future<String> getSavedDate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? uid = preferences.getString(CURRENT_DATE);
    return uid!;
  }

  clearUID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
//--------END UID SAVED DATE----------------//

}
