import 'package:flutter/material.dart';

class UserProfile extends ChangeNotifier {
  bool _signedIn = false;

  bool get signedIn => _signedIn;

  set signedIn(bool isSignedIn) {
    _signedIn = isSignedIn;
    notifyListeners();
  }

  String get firstName => _signedIn
      ? "John"
      : "anonymous";
}
