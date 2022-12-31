import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../theme/layout_values.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          height: LayoutValues.SMALLER,
        ),
        Divider(
          thickness: LayoutValues.DIVIDER_THICKNESS,
          height: LayoutValues.DIVIDER_THICKNESS,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ],
    );
  }
}
