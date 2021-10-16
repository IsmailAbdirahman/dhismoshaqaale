import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/History/search_history.dart';
import 'package:shaqalahadhismoapp/ProductsScreen/product_search.dart';
import 'package:shaqalahadhismoapp/model/product_model.dart';
import 'package:shaqalahadhismoapp/project_names/project_names_state.dart';

import 'product_details.dart';
import 'product_screen_state.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Stream<List<ProductModel>>? productStreamData;

  @override
  void initState() {
    super.initState();
    String projectID = context.read(projectNamesProvider).currentProjectName!;
    productStreamData =
        context.read(productListProvider).getProductStream(projectID);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: productStreamData,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Home"),
              centerTitle: true,
              actions: [
                SearchBarProductName(
                  searchHistoryID: data,
                ),
              ],
            ),
            body: Column(
              children: [
                Consumer(
                  builder: (BuildContext context, watch, child) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                              productModel: data[index],
                                            )),
                                  );
                                },
                                child: ProductTile(
                                  productModel: data[index],
                                ),
                              );
                            }));
                  },
                )
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class ProductTile extends StatelessWidget {
  final ProductModel? productModel;

  const ProductTile({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        color: Colors.deepOrangeAccent[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              CardInfo(
                desc: "Magaca: ",
                text: productModel!.productName,
              ),
              Divider(
                color: Colors.white,
              ),

              CardInfo(
                desc: "Inta Xabo ka taalo: ",
                text: productModel!.quantity.toString(),
                color: productModel!.quantity! > 16 ? Colors.white : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  final String? desc;
  final String? text;
  final Color? color;

  const CardInfo({Key? key, this.desc, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          desc!,
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white70),
        ),
        VerticalDivider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: Text(
            text!,
            style: TextStyle(
                color: color ?? Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
