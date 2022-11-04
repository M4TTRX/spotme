import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotme/views/shared/text/headings.dart';

class SecondaryButton extends Card {
  SecondaryButton(String text, Function onTap)
      : super(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.grey[200],
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonBodyText(text),
                ],
              ),
            ),
            onTap: () {
              HapticFeedback.lightImpact();
              onTap();
            },
          ),
        );
}
