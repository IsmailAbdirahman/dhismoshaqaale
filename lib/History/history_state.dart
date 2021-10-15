import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/model/history_model.dart';
import 'package:shaqalahadhismoapp/service/service.dart';
import 'package:shaqalahadhismoapp/signIn/userId.dart';

final historyState = ChangeNotifierProvider((ref) => HistoryState());

//--
class HistoryState extends ChangeNotifier {
  Service _service = Service();

  Stream<List<HistoryModel>> get getHistoryStream {
    return _service.projects
        .doc(projectID)
        .collection("users").doc(userID).collection('History')
        .snapshots()
        .map(_service.getHistorySnapshot);
  }
}
