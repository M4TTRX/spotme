import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.title, this.details = ""});

  final String title;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            details,
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
    );
  }
}
