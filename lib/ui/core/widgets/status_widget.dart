import 'package:flutter/material.dart';
import 'package:tree_view_app/config/assets.dart';
import 'package:tree_view_app/domain/models/component.dart';

class StatusWidget extends StatelessWidget {
  final Status status;

  const StatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.alert:
        return Icon(
          Icons.bolt,
          color: Colors.red,
        );
      case Status.operating:
        return Icon(
          Icons.bolt,
          color: Colors.green,
          size: 18,
        );
    }
  }
}
