import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/signIn/sign_in_state.dart';
import 'package:shaqalahadhismoapp/signIn/userId.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _registeredPhoneNumbercontroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(38.0),
            child: TextField(
              maxLength: 6,
              controller: _registeredPhoneNumbercontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter your ID or Phone Number",
              ),
            ),
          ),
          Consumer(
            builder: (BuildContext context, watch, child) {
              final signInProviderWatch = watch(signInProvider);
              return signInProviderWatch.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        signInProviderWatch.showLoadingBarWhileSinging();
                        context.read(signInProvider).getUsersInfo(
                            _registeredPhoneNumbercontroller.text, context);
                      },
                      child: Text("Enter"));
            },
          )
        ],
      ),
    );
  }
}
