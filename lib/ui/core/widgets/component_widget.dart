import 'package:flutter/material.dart';

import '../../../domain/models/component.dart';
import 'status_widget.dart';

class ComponentWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Status status;

  const ComponentWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(icon),
        Text(title),
        StatusWidget(status: status),
      ],
    );
  }
}
