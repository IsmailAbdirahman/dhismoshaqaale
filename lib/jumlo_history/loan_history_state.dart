import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/model/history_model.dart';
import 'package:shaqalahadhismoapp/model/loan_history_model.dart';
import 'package:shaqalahadhismoapp/service/service.dart';
import 'package:shaqalahadhismoapp/signIn/userId.dart';

final jumloHistoryState = ChangeNotifierProvider((ref) => JumloHistoryState());

//--
class JumloHistoryState extends ChangeNotifier {
  Service _service = Service();

  Stream<List<JumloHistoryModel>> getJumloHistoryStream({bool? isLoan}) {
    return _service.users
        .doc(userID)
        .collection("jumlo")
        .where("isLoan", isEqualTo: isLoan)
        .snapshots()
        .map(_service.getJumloSnapshot);
  }

  updateLoanTypeStatus(String historyID, bool isLoan) {
    _service.updateLoanTypeStatus(historyID, isLoan);
  }

  updateTotalBenefit(double pricePerItemSold) {
    _service.getTotal(pricePerItemSold);
  }
}
