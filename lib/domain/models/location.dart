import 'asset.dart';
import 'component.dart';

class Location {
  final String id;
  final String name;
  final String? parentId;
  final List<Location> subLocations;
  final List<Asset> assets;
  final List<Component> components;

  Location({
    required this.id,
    required this.name,
    this.parentId,
  })  : subLocations = [],
        components = [],
        assets = [];

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
