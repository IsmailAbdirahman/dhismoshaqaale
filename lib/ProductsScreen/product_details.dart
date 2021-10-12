import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shaqalahadhismoapp/History/history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/ProductsScreen/product_screen_state.dart';
import 'package:shaqalahadhismoapp/model/product_model.dart';
import 'package:shaqalahadhismoapp/widegts/bottom_navigation_screen.dart';
import 'package:shaqalahadhismoapp/widegts/toast_message.dart';

// class ProductDetails extends StatefulWidget {
//   // final String? name;
//   // final int? quantity;
//   // final double? pricePerItem;
//   // final String? productID;
//   final ProductModel? productModel;
//
//   const ProductDetails({this.productModel});
//
//   @override
//   _ProductDetailsState createState() => _ProductDetailsState();
// }
//
// class _ProductDetailsState extends State<ProductDetails> {
//   int incrementDecrement = 1;
//   late double totalPrice;
//   int? totalRemainingQuantity;
//
//   double calculateTotal(double priceperItem, int incrementDecremt) {
//     double total = priceperItem * incrementDecrement;
//     return total;
//   }
//
//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Ma Hubtaa in aad ii bisay?'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: const <Widget>[],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Haa'),
//               onPressed: () {
//                 context.read(productListProvider).saveSoldProductInfo(
//                     widget.productModel!.productID!.toString(),
//                     widget.productModel!.productName!,
//                     incrementDecrement,
//                     widget.productModel!.pricePerItemToSell!,
//                     totalPrice);
//
//                 context.read(productListProvider).updateQuantity(
//                     widget.productModel!.productID!.toString(),
//                     totalRemainingQuantity!);
//                 showToastMessage("Dalabkaaga wala fuliyay");
//
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => DisplayData()),
//                   (route) => false,
//                 );
//               },
//             ),
//             TextButton(
//               child: const Text('Maya'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     totalRemainingQuantity =
//         int.parse(widget.productModel!.quantity!.toString()) -
//             incrementDecrement;
//     if (totalRemainingQuantity! < 1) {
//       totalRemainingQuantity = 0;
//     }
//
//     double aa = widget.productModel!.pricePerItemToSell!;
//     totalPrice = pricePerItemValue(aa);
//     super.initState();
//   }
//
//   double pricePerItemValue(double pricePerItem) {
//     double aa = widget.productModel!.pricePerItemToSell!;
//     double totall = aa;
//     return totall;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.4,
//             padding: EdgeInsets.all(12),
//             child: Card(
//               color: Colors.deepPurple,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     RowInformationDisplay(
//                         title: "Magaca: ",
//                         data: widget.productModel!.productName!),
//                     Divider(
//                       color: Colors.white,
//                     ),
//                     RowInformationDisplay(
//                       title: "Inta Xabo hartay: ",
//                       data: totalRemainingQuantity.toString(),
//                     ),
//                     Divider(
//                       color: Colors.white,
//                     ),
//                     RowInformationDisplay(
//                       title: "Inta Xabo la rabo: ",
//                       data: incrementDecrement.toString(),
//                     ),
//                     Divider(
//                       color: Colors.white,
//                       thickness: 2,
//                     ),
//                     RowInformationDisplay(
//                       title: "Qiimaha:",
//                       data: "\$$totalPrice",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 InkWell(
//                     onTap: () {
//                       setState(() {
//                         if (widget.productModel!.quantity! != 0 &&
//                             totalRemainingQuantity != 0) {
//                           incrementDecrement++;
//                           totalRemainingQuantity =
//                               widget.productModel!.quantity! -
//                                   incrementDecrement;
//                           totalPrice = calculateTotal(
//                               pricePerItemValue(
//                                   widget.productModel!.pricePerItemToSell!),
//                               incrementDecrement);
//                         }
//                       });
//                     },
//                     child: Center(
//                         child: Container(
//                             color: Colors.deepPurple,
//                             height: 60,
//                             width: 60,
//                             child: Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             )))),
//                 VerticalDivider(
//                   color: Colors.black,
//                   thickness: 10,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       if (widget.productModel!.quantity! != 0 &&
//                           totalRemainingQuantity != 0) {
//                         totalRemainingQuantity =
//                             widget.productModel!.quantity! - incrementDecrement;
//                         incrementDecrement--;
//                         totalPrice = calculateTotal(
//                             pricePerItemValue(
//                                 widget.productModel!.pricePerItemToSell!),
//                             incrementDecrement);
//                         if (incrementDecrement < 1) {
//                           incrementDecrement = 1;
//                           totalPrice = pricePerItemValue(
//                               widget.productModel!.pricePerItemToSell!);
//                         }
//                       }
//                     });
//                   },
//                   child: Container(
//                       color: Colors.deepPurple,
//                       height: 60,
//                       width: 60,
//                       padding: EdgeInsets.only(bottom: 14),
//                       child: Icon(
//                         Icons.minimize,
//                         color: Colors.white,
//                       )),
//                 )
//               ],
//             ),
//           ),
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(primary: Colors.red),
//               onPressed: () async {
//                 if (widget.productModel!.quantity! != 0 ||
//                     totalRemainingQuantity != 0) {
//                   await _showMyDialog();
//                 } else {
//                   showToastMessage("Sheygaan Wuu dhamaaday");
//                 }
//               },
//               child: Text("iibi"))
//         ],
//       )),
//     );
//   }
// }
//
// class RowInformationDisplay extends StatelessWidget {
//   final String? title;
//   final String? data;
//
//   RowInformationDisplay({this.title, this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Text(
//             title!,
//             style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white70,
//                 fontSize: 25),
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(right: 5.0),
//             child: Text(data!,
//                 style: TextStyle(
//                     fontWeight: FontWeight.w800,
//                     color: Colors.white,
//                     fontSize: 25)),
//           ),
//         ),
//       ],
//     );
//   }
// }

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

  Future<void> _jumloWithoutDeenDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ma Hubtaa in aad ii bisay?'),
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
                  double totalPrice = widget.productModel!.groupPriceToSell! *
                      int.parse(_quantityController.text);

                  int totalRemainingQuantity = widget.productModel!.quantity! -
                      int.parse(_quantityController.text);
                  context.read(productListProvider).saveJumloProductInfo(
                      prdName: widget.productModel!.productName!,
                      prdID: widget.productModel!.productID!.toString(),
                      nameOfPerson: _loanNameController.text,
                      isLoan: false,
                      quantity: int.parse(_quantityController.text),
                      priceGroupItems: widget.productModel!.groupPriceToSell,
                      totalPrice: totalPrice);

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

  Future<void> _jumloWitDeenDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ma Hubtaa in aad ii bisay?'),
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
                  double totalPrice = widget.productModel!.groupPriceToSell! *
                      int.parse(_quantityController.text);

                  int totalRemainingQuantity = widget.productModel!.quantity! -
                      int.parse(_quantityController.text);
                  context.read(productListProvider).saveJumloProductInfo(
                      prdName: widget.productModel!.productName!,
                      prdID: widget.productModel!.productID!.toString(),
                      nameOfPerson: _loanNameController.text,
                      isLoan: true,
                      quantity: int.parse(_quantityController.text),
                      priceGroupItems: widget.productModel!.groupPriceToSell,
                      totalPrice: totalPrice);

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

  Future<void> _tafaariiqDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ma Hubtaa in aad ii bisay?'),
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
                  double totalPrice = widget.productModel!.pricePerItemToSell! *
                      int.parse(_quantityController.text);

                  int totalRemainingQuantity = widget.productModel!.quantity! -
                      int.parse(_quantityController.text);
                  context.read(productListProvider).saveTafaariiqProductInfo(
                      widget.productModel!.productID!.toString(),
                      widget.productModel!.productName!,
                      int.parse(_quantityController.text),
                      widget.productModel!.pricePerItemToSell!,
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
              height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsets.all(12),
              child: Card(
                color: Colors.deepPurple,
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
                          title: "Inta xabo suuqa taalo: ",
                          data: widget.productModel!.quantity.toString()),
                      Divider(
                        color: Colors.white,
                      ),
                      ProductNameDisplay(
                          title: "Qimaha halki xabo: ",
                          data: "\$${widget.productModel!.pricePerItemToSell}"),
                      Divider(
                        color: Colors.white,
                      ),
                      ProductNameDisplay(
                          title: "Qimaha Jumlada: ",
                          data: "\$${widget.productModel!.groupPriceToSell}"),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      purchaseTypeButtons(),
                      Divider(
                        color: Colors.white,
                      ),
                      isJumla == true ? paymentTypeButtons() : SizedBox(),
                      Divider(
                        color: Colors.white,
                      ),
                      isDeen == true
                          ? TextField(
                              controller: _loanNameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "magaca qofka daynta qadanaya",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            )
                          : SizedBox(),
                      Divider(
                        color: Colors.white,
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Inta Xabo la rabo: ",
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
                                if (isJumla == true) {
                                  totalPriceToDisplay(int.parse(value),
                                      widget.productModel!.groupPriceToSell!);
                                } else {
                                  totalPriceToDisplay(int.parse(value),
                                      widget.productModel!.pricePerItemToSell!);
                                }
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
                      ProductNameDisplay(
                          title: "Total: ",
                          data: "\$$totalPriceToDisplayOnScreenBeforePaying"),
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
                    if (purType == 'Jumlo') {
                      if (payType == "Deen") {
                        if (_loanNameController.text.isNotEmpty) {
                          //pay the product jumlo  with deen
                          _jumloWitDeenDialog();
                        } else {
                          showToastMessage(
                              "Magacga qofka deynta qadanyo ebar ma noqon karo");
                        }
                      } else {
                        //pay the product jumlo but without deen
                        _jumloWithoutDeenDialog();
                      }
                    } else {
                      // pay the product as tafaariq
                      _tafaariiqDialog();
                    }
                  } else {
                    //Quantity can not be epmty
                    showToastMessage("Fadlan geli tirada loo bahan yahay");
                  }

                },
                child: Text("iibi"))
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
