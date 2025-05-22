import 'package:byxelkroken/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'krok_page.dart';
import 'models/krok.dart';
import 'services/krok_service.dart';
import 'sign_in_screen.dart';

class KrokList extends StatelessWidget {
  final Iterable<Krok> nearby;

  const KrokList({super.key, required this.nearby});

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile>(context, listen: false);

    void onPressed(Krok k) {
      Future<int?> pushKrok() {
        final krokService = Provider.of<KrokService>(context, listen: false);
        return Navigator.push<int>(
          context,
          MaterialPageRoute(
            builder:
                (ctx) => Provider<KrokService>.value(
                  value: krokService,
                  builder: (c, child) => KrokPage(id: k.id!, title: k.title),
                ),
          ),
        );
      }

      // need to sign in first?
      if (!userProfile.signedIn) {
        Navigator.push<String>(
          context,
          MaterialPageRoute(builder: (ctx) => SignInScreen()),
        ).then((String? maybeUserId) {
          if (null != maybeUserId) {
            userProfile.signedIn = true;
            pushKrok();
          }
        });
      } else {
        pushKrok();
      }
    }

    final List<Widget> children =
        nearby
            .map(
              (k) => _KrokItem(
                title: k.title,
                leading:
                    null == k.distanceInMeters
                        ? null
                        : Text("${k.distanceInMeters}m"),
                imagePath: k.imagePath,
                onPressed: () => onPressed(k),
              ),
            )
            .toList();
    final scanItem = _KrokItem(
      title: "Scanna QR",
      leading: Icon(Icons.qr_code_scanner),
      backgroundColor: ColorScheme.of(context).surface,
      onPressed: () => {},
    );
    children.add(scanItem);
    return Container(
      color: ColorScheme.of(context).inversePrimary,
      child: ListView(children: children),
    );
  }
}

class _KrokItem extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Widget? leading;
  final String? imagePath;
  final void Function() onPressed;

  const _KrokItem({
    this.backgroundColor = Colors.white,
    super.key,
    required this.title,
    this.leading,
    this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              "$title ",
              textScaler: TextScaler.linear(1.3),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading ?? const Icon(Icons.near_me),
          ],
        ),
      ),
    ];
    if (null != imagePath) {
      rows.add(Image.asset("assets/$imagePath"));
    }
    return Card(
      color: backgroundColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: MaterialButton(
          onPressed: onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rows,
          ),
        ),
      ),
    );
  }
}
