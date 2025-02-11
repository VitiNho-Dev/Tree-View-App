import 'package:flutter/material.dart';
import 'package:tree_view_app/config/assets.dart';
import 'package:tree_view_app/ui/core/widgets/component_widget.dart';

class LocationWidget extends StatelessWidget {
  final String title;
  final List<LocationWidget> subLocations;
  final List<ComponentWidget> components;

  const LocationWidget({
    super.key,
    required this.title,
    required this.subLocations,
    required this.components,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Image.asset(Assets.location),
      title: Text(title),
      children: [
        ...components.map(
          (comp) => ComponentWidget(title: comp.title, status: comp.status),
        ),
      ],
    );
  }
}
