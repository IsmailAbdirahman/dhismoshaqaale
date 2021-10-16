import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/History/search_history.dart';
import 'package:shaqalahadhismoapp/ProductsScreen/products_screen.dart';
import 'package:shaqalahadhismoapp/model/history_model.dart';

import 'history_state.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Stream<List<HistoryModel>>? historyStreamData;

  @override
  void initState() {
    super.initState();
    historyStreamData = context.read(historyState).getHistoryStream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HistoryModel>>(
        stream: historyStreamData,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<HistoryModel> dataSnapshot = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("History"),
                centerTitle: true,
                actions: [
                  SearchBarHistoryWidget(
                    searchHistoryID: dataSnapshot,
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: dataSnapshot.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HistoryTile(
                            historyModel: dataSnapshot[index],
                          );
                        }),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class HistoryTile extends StatelessWidget {
  final HistoryModel? historyModel;

  const HistoryTile({this.historyModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.deepOrange[700],
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            CardInfo(
              desc: "Taarikhda la isticmalay: ",
              text: historyModel!.dateTold,
            ),
            Divider(
              color: Colors.white70,
            ),
            CardInfo(
              desc: "ID: ",
              text: historyModel!.historyID,
            ),
            Divider(
              color: Colors.white70,
            ),
            CardInfo(
              desc: "Magaca: ",
              text: historyModel!.productName,
            ),
            Divider(
              color: Colors.white70,
            ),
            CardInfo(
              desc: "Inta Xabo la isticmalay: ",
              text: historyModel!.quantity.toString(),
            ),
            Divider(
              color: Colors.white70,
            ),
            // CardInfo(
            //   desc: "Halki xabo Qiimaha Lagu so iibiyay: ",
            //   text: "\$${historyModel!.pricePerItemToSell}",
            // ),
            // Divider(
            //   thickness: 2.5,
            //   color: Colors.white70,
            // ),
            // CardInfo(
            //   desc: "Total: ",
            //   text: "\$${historyModel!.totalPrice}",
            // ),
          ],
        ),
      ),
    );
  }
}
