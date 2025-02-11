import 'package:flutter/material.dart';
import 'package:tree_view_app/config/assets.dart';

import '../../../domain/models/component.dart';
import 'status_widget.dart';

class ComponentWidget extends StatelessWidget {
  final String title;
  final Status status;

  const ComponentWidget({
    super.key,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Image.asset(
          Assets.component,
          width: 22,
          height: 22,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        StatusWidget(status: status),
      ],
    );
  }
}
