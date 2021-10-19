import 'package:flutter/material.dart';
import 'package:shaqalahadhismoapp/ProductsScreen/product_details.dart';
import 'package:shaqalahadhismoapp/ProductsScreen/products_screen.dart';
import 'package:shaqalahadhismoapp/model/history_model.dart';
import 'package:shaqalahadhismoapp/model/product_model.dart';

class SearchBarProductName extends StatelessWidget {
  final List<ProductModel>? searchHistoryID;

  const SearchBarProductName({this.searchHistoryID});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        color: Colors.white,
        size: 27,
      ),
      onPressed: () {
        showSearch(
            context: context,
            delegate: SearchHistory(searchHistoryID: searchHistoryID));
      },
    );
  }
}

//--
class SearchHistory extends SearchDelegate {
  final List<ProductModel>? searchHistoryID;

  SearchHistory({this.searchHistoryID});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.deepOrange,
      backgroundColor: Colors.deepOrange,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear, color: Colors.white70),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white70,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final List suggestionList = (query.isEmpty
        ? searchHistoryID
        : searchHistoryID!
            .where((element) => element.productName
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList())!;
    return Container(
      height: 280,
      width: double.infinity,
      child: ListView.builder(
          primary: false,
          itemCount: suggestionList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ProductTile(
              productModel: suggestionList[index],
              //  productModel: suggestionList[index],
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionList = query.isEmpty
        ? searchHistoryID!
        : searchHistoryID!
            .where((element) => element.productName
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList();
    return Container(
      height: 280,
      width: double.infinity,
      child: ListView.builder(
          primary: false,
          itemCount: suggestionList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(
                              productModel: suggestionList[index],
                            )));
              },
              child: ProductTile(
                productModel: suggestionList[index],
                //  productModel: suggestionList[index],
              ),
            );
          }),
    );
  }
}
