import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onPressed() => Navigator.pop(context, "mockUserId");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScheme.of(context).inversePrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Logga in för att fortsätta"),
      ),
      body: Center(
        child: SizedBox(height: 100, child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [SignInButton(Buttons.AppleDark, onPressed: onPressed),SignInButton(Buttons.Google, onPressed: onPressed)],
        ),),
      ),
    );
  }
}
