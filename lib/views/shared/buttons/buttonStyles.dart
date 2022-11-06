import 'package:flutter/material.dart';

greyFlatButton(context) => ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).colorScheme.onSurface),
      backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).colorScheme.surface),
    );
