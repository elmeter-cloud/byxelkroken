import 'package:flutter/material.dart';

class Themed {
  static Widget primaryButton(
    BuildContext context,
    String text, {
    void Function()? onPressed,
  }) => TextButton(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(
        ColorScheme.of(context).inverseSurface,
      ),
      foregroundColor: WidgetStatePropertyAll(
        ColorScheme.of(context).onInverseSurface,
      ),
    ),
    onPressed: onPressed,
    child: Text(text),
  );

  static Widget text13(String text) =>
      Text(text, textScaler: TextScaler.linear(1.3));
}
