import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_workouts/views/shared/text/headings.dart';

class PrimaryButton extends Card {
  PrimaryButton(String text, Function onTap)
      : super(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          color: Colors.indigo,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Heading1(
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
