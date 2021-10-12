import 'package:flutter/cupertino.dart';

enum typeOfPurchasing { jumlo, tafaariiq }

class ProductDetailsState extends ChangeNotifier {
  int _gHowManyItemsNeeded = 0;
  double _totalPriceOfItems = 0.0;

  int get gHowManyItemsNeeded => _gHowManyItemsNeeded;

  double get totalPriceOfItems => _totalPriceOfItems;

  void calculateItemsPrice(
      {int? howManyItemNeeded,
      String? purchasingType,
      String? paymentType,
      double? priceType}) {
    if (purchasingType == "jumlo") {
      double totalPrice = howManyItemNeeded! * priceType!;
    }
  }
}
