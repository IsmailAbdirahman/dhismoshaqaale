import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shaqalahadhismoapp/service/service.dart';
import 'package:shaqalahadhismoapp/service/shared_pref.dart';

import 'userId.dart';

final signInProvider = ChangeNotifierProvider<SignInState>((ref) {
  return SignInState();
});

//--
class SignInState extends ChangeNotifier {
  Service _service = Service();
  SharedPref _sharedPref = SharedPref();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  getUsersInfo(String registeredPhoneNumber, BuildContext context) {
    return _service.getUsersInfo(registeredPhoneNumber, context);
  }

  saveUserUID(String userUID) async {
    notifyListeners();
    return _sharedPref.saveUserUID(userUID);
  }

  Future<String> getUserUID() async {
    return await _sharedPref.getUserUID();
  }

  Future<String> getSavedDate() async {
    return await _sharedPref.getSavedDate();
  }

  clearUID() async {
    notifyListeners();
    return await _sharedPref.clearUID();
  }

  showLoadingBarWhileSinging() {
    _isLoading = true;
    notifyListeners();
  }
  hideLoadingBarWhileSinging() {
    _isLoading = false;
    notifyListeners();
  }






  ///TODO: call this method
  void deleteAfterOneDay() {
    getSavedDate().then((date) {
      var savedDate = DateTime(int.parse(date));
      var currentDate = DateTime.now();
      if (savedDate.isBefore(currentDate)) {
        clearUID();
      }
    });
  }
}
