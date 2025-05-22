import 'package:byxelkroken/services/krok_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'krok_list.dart';
import 'models/krok.dart';
import 'models/user_profile.dart';
import 'sign_in_screen.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  void _onPressedProfile(BuildContext context, UserProfile userProfile) {
    if (userProfile.signedIn) {
      userProfile.signedIn = false;
    }
    else {
      Navigator.push<String>(
        context,
        MaterialPageRoute(builder: (ctx) => SignInScreen()),
      ).then((String? maybeUserId) {
        if (null != maybeUserId) {
          userProfile.signedIn = true;
        }
      });

    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: ColorScheme.of(context).inversePrimary,
      leading: Consumer<UserProfile>(
        builder:
            (BuildContext context, UserProfile userProfile, Widget? child) =>
                IconButton(
                  icon: Icon(
                    userProfile.signedIn
                        ? Icons.person_pin
                        : Icons.person_outline_outlined,
                  ),
                  onPressed: () => _onPressedProfile(context, userProfile),
                ),
      ),
      title: Text("Slingor nära dig"),
    ),
    body: FutureBuilder<Iterable<Krok>>(
      future: Provider.of<KrokService>(context, listen: false).findNearby(),
      builder: (BuildContext context, AsyncSnapshot<Iterable<Krok>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Text("Laddar..."),
                ],
              ),
            );
          case ConnectionState.done:
            return KrokList(nearby: snapshot.data!,);
          default:
            return Text("Fel vid laddning.");
        }
      },
    ),
  );
}
