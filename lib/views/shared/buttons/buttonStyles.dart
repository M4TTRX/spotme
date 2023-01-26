import 'package:flutter/material.dart';

class ButtonStyles {
  static greyButton(context) => ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).colorScheme.onSurface),
      backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).colorScheme.surface),
    );
  static actionButton(context) => ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.onPrimaryContainer),
        backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary),
      );
  static dangerButton(context) => ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.error),
        backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.errorContainer),
      );
}
