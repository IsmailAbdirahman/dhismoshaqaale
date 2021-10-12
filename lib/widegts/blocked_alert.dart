import 'package:flutter/material.dart';

Future<void> blockAlert(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Wala Xayiray Account kaga.'),
        content: const Text("Fadlan La xiriir Maamulkaga"),
      );
    },
  );
}
