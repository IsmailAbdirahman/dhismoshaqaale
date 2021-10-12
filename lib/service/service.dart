import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shaqalahadhismoapp/model/history_model.dart';
import 'package:shaqalahadhismoapp/model/loan_history_model.dart';
import 'package:shaqalahadhismoapp/model/product_model.dart';
import 'package:shaqalahadhismoapp/service/shared_pref.dart';
import 'package:shaqalahadhismoapp/signIn/sign_in.dart';
import 'package:shaqalahadhismoapp/signIn/sign_in_state.dart';
import 'package:shaqalahadhismoapp/signIn/userId.dart';
import 'package:shaqalahadhismoapp/widegts/blocked_alert.dart';
import 'package:shaqalahadhismoapp/widegts/bottom_navigation_screen.dart';
import 'package:shaqalahadhismoapp/widegts/toast_message.dart';

const String PROJECTS = "projects";
const String PRODUCTS = "products";
const String USERS = "users";
const String LOAN = "jumlo";
const String projectID = "madiino";

class Service {
  SharedPref _sharedPref = SharedPref();
  CollectionReference projects =
  FirebaseFirestore.instance.collection(PROJECTS);
  CollectionReference products =
      FirebaseFirestore.instance.collection(PRODUCTS);
  CollectionReference users = FirebaseFirestore.instance.collection(USERS);

  CollectionReference loan = FirebaseFirestore.instance.collection(LOAN);

  List<ProductModel> getProductSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ProductModel(
          groupPriceToSell: doc['groupPrice'],
          productID: doc['productID'],
          productName: doc['productName'],
          pricePerItemPurchased: doc['pricePerItemPurchased'],
          pricePerItemToSell: doc['pricePerItemToSell'],
          quantity: doc['quantity']);
    }).toList();
  }

  updateQuantity(String productID, int quantity) {
    products
        .doc(productID)
        .update({'productID': productID, 'quantity': quantity})
        .then((value) => print("Updated"))
        .catchError((error) => print("Something Went Wrong"));
  }

  //update the totalSold
  updateTotalSold(double totalSold) {
    products
        .doc('totalData')
        .collection("totalOfProducts")
        .doc('totalData')
        .update({"totalPriceToSell": totalSold}).then((value) {
      print("DATA IS UPDATED");
    });
  }

  getTotal(double pricePerItemSold) {
    double totalPriceOfSell = 0;
    products
        .doc('totalData')
        .collection('totalOfProducts')
        .doc('totalData')
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        totalPriceOfSell = snapshot.get('totalPriceToSell');
        double totalSold = totalPriceOfSell += pricePerItemSold;
        updateTotalSold(totalSold);
      }
    });
  }

  void saveTafariiqProductInfo(String prdID, String prdName, int quantity,
      double pricePerItem, double totalPrice) {
    String historyID = Random.secure().nextInt(10000000).toString();
    DateTime now = DateTime.now();
    String currentDate =
        "${now.hour}:${now.minute} | ${now.day}:${now.month}:${now.year}";
    print("CURRENT DATE IS T:T:T:T:T:T:T: $currentDate");

    users.doc(userID).collection('History').doc(historyID).set({
      "historyID": historyID,
      "productName": prdName,
      "pricePerItemToSell": pricePerItem,
      "quantity": quantity,
      "totalPrice": totalPrice,
      "dateSold": currentDate
    }).then((value) {
      getTotal(totalPrice);
      print("SAVED PRODUCTS INFORMATION");
    });
  }

  void saveJumloProductInfo(
      {String? nameOfPerson,
      bool? isLoan,
      String? prdID,
      String? prdName,
      int? quantity,
      double? priceGroupItems,
      double? totalPrice}) {
    String historyID = Random.secure().nextInt(10000000).toString();
    DateTime now = DateTime.now();
    String currentDate =
        "${now.hour}:${now.minute} | ${now.day}:${now.month}:${now.year}";

    users.doc(userID).collection('jumlo').doc(historyID).set({
      "historyID": historyID,
      "nameOfPerson": isLoan == true ? nameOfPerson : "Deen ma qadan",
      "isLoan": isLoan,
      "productName": prdName,
      "priceGroupItems": priceGroupItems,
      "quantity": quantity,
      "totalPrice": totalPrice,
      "dateSold": currentDate
    }).then((value) {
      if (isLoan == false) {
        getTotal(totalPrice!);
      }
    });
  }

  List<HistoryModel> getHistorySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return HistoryModel(
          historyID: doc['historyID'],
          productName: doc['productName'],
          pricePerItemToSell: doc['pricePerItemToSell'],
          totalPrice: doc['totalPrice'],
          dateTold: doc['dateSold'],
          quantity: doc['quantity']);
    }).toList();
  }

  updateLoanTypeStatus(String historyID, bool isLoan) {
    users.doc(userID).collection('jumlo').doc(historyID).update({
      "isLoan": isLoan,
    });
  }

  List<JumloHistoryModel> getJumloSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return JumloHistoryModel(
          historyID: doc['historyID'],
          productName: doc['productName'],
          priceGroupItems: doc['priceGroupItems'],
          totalPrice: doc['totalPrice'],
          dateTold: doc['dateSold'],
          quantity: doc['quantity'],
          isLoan: doc['isLoan'],
          nameOfPerson: doc['nameOfPerson']);
    }).toList();
  }

  //parent Login
  getUsersInfo(String registeredPhoneNumber, BuildContext context) {
    final DocumentReference documentReference =
        FirebaseFirestore.instance.doc("projects/$projectID/users/$registeredPhoneNumber");
    StreamSubscription<DocumentSnapshot> subscription;
    subscription = documentReference.snapshots().listen((dataSnapshot) {
      if (dataSnapshot.exists) {
        if (dataSnapshot.get('isBlocked') == false) {
          _sharedPref.saveUserUID(dataSnapshot.get('phoneNumber'));
          userID = dataSnapshot.get('phoneNumber');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DisplayData()));
        } else if (dataSnapshot.get('isBlocked') == true) {
          blockAlert(context);
        }
      } else {
        showToastMessage('Sax ma ahan user ID ga ad galisay');
        context.read(signInProvider).hideLoadingBarWhileSinging();
      }
    });
    return subscription;
  }
}
