import 'package:flutter/material.dart';

class ButtonStyles {
  static greyButton(context) => ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).colorScheme.onSurface),
      backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).colorScheme.surface),
    );
}
