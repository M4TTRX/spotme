import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotme/views/shared/text/headings.dart';

class DangerButton extends Card {
  DangerButton(String text, Function onTap)
      : super(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.red,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonBodyText(
                    text,
                    color: Colors.white,
                  ),
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
