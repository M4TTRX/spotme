import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotme/views/shared/text/headings.dart';

class BasicButton extends Card {
  BasicButton(String text, Function onTap)
      : super(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          color: Colors.grey[200],
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: ButtonBodyText(
                text,
                fontSize: 14,
              ),
            ),
            onTap: () {
              HapticFeedback.lightImpact();
              onTap();
            },
          ),
        );
}
