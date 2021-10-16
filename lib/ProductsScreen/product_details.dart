import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/ProductsScreen/product_screen_state.dart';
import 'package:shaqalahadhismoapp/model/product_model.dart';
import 'package:shaqalahadhismoapp/widegts/bottom_navigation_screen.dart';
import 'package:shaqalahadhismoapp/widegts/toast_message.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel? productModel;

  const ProductDetails({this.productModel});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _loanNameController = TextEditingController();

  int _selectedPurchaseIndex = 0;
  int _selectedPaymentIndex = 0;
  static String purType = "Tafariq";
  static String payType = "iibi-hada";
  bool isJumla = false;
  bool isDeen = false;
  double _totalPriceToDisplayOnScreenBeforePaying = 0.0;

  double? get totalPriceToDisplayOnScreenBeforePaying =>
      _totalPriceToDisplayOnScreenBeforePaying;

  List<String> purchaseTypeList = ['Tafariq', 'Jumlo'];
  List<String> paymentTypeList = ['iibi-hada', 'Deen'];

  Widget purchasingType(int index) {
    return GestureDetector(
      onTap: () {
        clearDataInputs();

        setState(() {
          _selectedPurchaseIndex = index;
          purType = purchaseTypeList[index];
          if (purType == purchaseTypeList[1]) {
            setState(() {
              isJumla = true;
              print("IS JUMLO::::::: $isJumla");
            });
          } else {
            isJumla = false;
          }
          print("INSIDE::::: ${purType}");
        });
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
          ),
          child: OutlineButton(
            disabledBorderColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: null,
            child: Text(
              purchaseTypeList[index],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: _selectedPurchaseIndex == index
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          )),
    );
  }

  clearDataInputs() {
    _quantityController.clear();
    _totalPriceToDisplayOnScreenBeforePaying = 0.0;
  }

  Widget paymentType(int index) {
    return GestureDetector(
      onTap: () {
        clearDataInputs();
        setState(() {
          _selectedPaymentIndex = index;
          payType = paymentTypeList[index];
          if (payType == paymentTypeList[1]) {
            setState(() {
              isDeen = true;
            });
          } else {
            isDeen = false;
          }
          print("INSIDE::::: ${payType}");
        });
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
          ),
          child: OutlineButton(
            disabledBorderColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: null,
            child: Text(
              paymentTypeList[index],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color:
                    _selectedPaymentIndex == index ? Colors.white : Colors.grey,
              ),
            ),
          )),
    );
  }

  Widget purchaseTypeButtons() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: purchaseTypeList
            .asMap()
            .entries
            .map((singleType) => purchasingType(singleType.key))
            .toList());
  }

  Widget paymentTypeButtons() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: paymentTypeList
            .asMap()
            .entries
            .map((singleType) => paymentType(singleType.key))
            .toList());
  }

  void totalPriceToDisplay(int quantity, double price) {
    setState(() {
      _totalPriceToDisplayOnScreenBeforePaying = quantity * price;
    });
  }

  Future<void> _tafaariiqDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ma Hubtaa in tiradaas lo bahan yahay ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Haa'),
              onPressed: () {
                if (int.parse(_quantityController.text) >
                    widget.productModel!.quantity!) {
                  showToastMessage("Tirada ad galisay suuqa lagama heli karo");
                } else {
                  double totalPrice =
                      widget.productModel!.pricePerItemPurchased! *
                          int.parse(_quantityController.text);

                  int totalRemainingQuantity = widget.productModel!.quantity! -
                      int.parse(_quantityController.text);
                  context.read(productListProvider).saveTafaariiqProductInfo(
                      widget.productModel!.productID!.toString(),
                      widget.productModel!.productName!,
                      int.parse(_quantityController.text),
                      widget.productModel!.pricePerItemPurchased!,
                      totalPrice);

                  context.read(productListProvider).updateQuantity(
                      widget.productModel!.productID!.toString(),
                      totalRemainingQuantity);
                  showToastMessage("Dalabkaaga wala fuliyay");

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DisplayData()),
                    (route) => false,
                  );

                  context.read(productListProvider).updateQuantity(
                      widget.productModel!.productID!.toString(),
                      totalRemainingQuantity);
                  showToastMessage("Dalabkaaga wala fuliyay");

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DisplayData()),
                    (route) => false,
                  );
                }
              },
            ),
            TextButton(
              child: const Text('Maya'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.all(12),
              child: Card(
                color: Colors.deepOrange[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductNameDisplay(
                          title: "Magaca: ",
                          data: widget.productModel!.productName!),
                      Divider(
                        color: Colors.white,
                      ),
                      ProductNameDisplay(
                          title: "Inta xabo taalo: ",
                          data: widget.productModel!.quantity.toString()),
                      Divider(
                        color: Colors.white,
                      ),
                      // ProductNameDisplay(
                      //     title: "Qimaha halki xabo: ",
                      //     data:
                      //         "\$${widget.productModel!.pricePerItemPurchased}"),
                      // Divider(
                      //   color: Colors.white,
                      //   thickness: 2,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Inta Xabo lo bahanyahy hada: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70,
                                  fontSize: 25),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _quantityController,
                              onChanged: (value) {
                                totalPriceToDisplay(
                                    int.parse(value),
                                    widget
                                        .productModel!.pricePerItemPurchased!);
                              },
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "00",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      // ProductNameDisplay(
                      //     title: "Total: ",
                      //     data: "\$$totalPriceToDisplayOnScreenBeforePaying"),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () async {
                  if (_quantityController.text.isNotEmpty &&
                      purType.isNotEmpty &&
                      !_quantityController.text.startsWith('0')) {
                    _tafaariiqDialog();
                  } else {
                    //Quantity can not be epmty
                    showToastMessage("Fadlan geli tirada loo bahan yahay");
                  }
                },
                child: Text("Isticmaal"))
          ],
        ),
      )),
    );
  }
}

class ProductNameDisplay extends StatelessWidget {
  final String? title;
  final String? data;

  ProductNameDisplay({this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title!,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white70,
                fontSize: 25),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Text(data!,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 25)),
          ),
        ),
      ],
    );
  }
}
