import 'package:byxelkroken/services/krok_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'models/krok_step.dart';
import 'themed.dart';

class KrokPage extends StatefulWidget {
  final String id;
  final String title;

  const KrokPage({super.key, required this.id, required this.title});

  @override
  State<StatefulWidget> createState() => _KrokPageState();
}

class _KrokPageState extends State<KrokPage> {
  int index = 0;
  bool nearby = false;
  Future<List<KrokStep>>? krokFuture;

  Widget _buildNearbyStep(BuildContext context, List<KrokStep> steps) {
    final step = steps[index];
    final rows = <Widget>[
      Themed.text13(step.promptNearby),
      Expanded(child: Image.asset("assets/${step.imageNearby}")),
      Container(
        margin: EdgeInsets.only(top: 8, bottom: 24),
        child:
            index < steps.length - 1
                ? Themed.primaryButton(
                  context,
                  "Fortsätt",
                  onPressed:
                      () => setState(() {
                        index++;
                        nearby = false;
                      }),
                )
                : Themed.primaryButton(
                  context,
                  "Klar",
                  onPressed: () => Navigator.pop(context, steps.length),
                ),
      ),
    ];
    if (null != step.qrData) {
      rows.insert(2, QrImageView(data: step.qrData!, size: 128));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: rows,
    );
  }

  Widget _buildProceedTo(BuildContext context, List<KrokStep> steps) {
    final step = steps[index];
    return Column(
      children: [
        Themed.text13("${index + 1}: Gå till ${step.title}"),
        Expanded(child: Image.asset("assets/${step.imageProceedTo}")),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 24),
          child: Themed.primaryButton(
            context,
            "Framme",
            onPressed:
                () => setState(() {
                  nearby = true;
                }),
          ),
        ),
      ],
    );
  }

  Widget _buildStep(BuildContext context, List<KrokStep> steps) {
    return nearby || KrokType.qrVoucher == steps[index].type
        ? _buildNearbyStep(context, steps)
        : _buildProceedTo(context, steps);
  }

  @override
  Widget build(BuildContext context) {
    krokFuture ??= Provider.of<KrokService>(
      context,
      listen: false,
    ).get(widget.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScheme.of(context).inversePrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, index),
        ),
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<KrokStep>>(
          future: krokFuture,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<KrokStep>> snapshot,
          ) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Column(
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
                );
              case ConnectionState.done:
                return _buildStep(context, snapshot.data!);
              default:
                return Text("Fel vid laddning.");
            }
          },
        ),
      ),
    );
  }
}
