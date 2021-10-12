import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/signIn/sign_in.dart';
import 'package:shaqalahadhismoapp/signIn/sign_in_state.dart';
import 'package:shaqalahadhismoapp/signIn/userId.dart';

import 'bottom_navigation_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, watch, child) {
          final signInProviderWatch = watch(signInProvider);

          return FutureBuilder(
              future: signInProviderWatch.getUserUID(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  userID = snapshot.data.toString();
                //  signInProviderWatch.getUsersInfo(userID!, context);
                  return SignInScreen();
                } else {
                  return SignInScreen();
                }
              });
        },
        child: CircularProgressIndicator());
  }
}
