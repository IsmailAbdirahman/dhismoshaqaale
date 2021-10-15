import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/model/product_model.dart';
import 'package:shaqalahadhismoapp/service/service.dart';
import 'package:shaqalahadhismoapp/signIn/userId.dart';

final productListProvider = ChangeNotifierProvider((ref) => ProductListState());

//--
class ProductListState extends ChangeNotifier {
  Service _service = Service();

  Stream<List<ProductModel>>  getProductStream(String projectID) {
    return Service()
        .projects.doc(projectID).collection("products")
        .snapshots()
        .map(_service.getProductSnapshot);
  }

  saveTafaariiqProductInfo(String prdID, String prdName, int quantity,
      double pricePerItem, double totalPrice) {
    return _service.saveTafariiqProductInfo(
        prdID, prdName, quantity, pricePerItem, totalPrice);
  }

  saveJumloProductInfo(
      {required String? nameOfPerson,
      required bool? isLoan,
      required String? prdID,
      required String? prdName,
      required int? quantity,
      required double? priceGroupItems,
      required double? totalPrice}) {
    return _service.saveJumloProductInfo(
        nameOfPerson: nameOfPerson,
        isLoan: isLoan,
        prdID: prdID,
        prdName: prdName,
        quantity: quantity,
        priceGroupItems: priceGroupItems,
        totalPrice: totalPrice);
  }

  updateQuantity(String productID, int quantity) {
    return _service.updateQuantity(productID, quantity);
  }
}
