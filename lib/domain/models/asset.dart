import 'component.dart';

class Asset {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  final List<Asset> subAssets;
  final List<Component> components;

  Asset({
    required this.id,
    required this.name,
    this.parentId,
    this.locationId,
  })  : subAssets = [],
        components = [];

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      locationId: json['locationId'],
    );
  }
}
