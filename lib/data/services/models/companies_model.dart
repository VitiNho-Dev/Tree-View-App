class CompanieModel {
  final String id;
  final String name;

  const CompanieModel({
    required this.id,
    required this.name,
  });

  factory CompanieModel.fromJson(Map<String, dynamic> json) {
    return CompanieModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class AssetModel {
  final String? getwayId;
  final String id;
  final String? locationId;
  final String name;
  final String? parentId;
  final String? sensorType;
  final String? sensorId;
  final String? status;

  const AssetModel({
    this.getwayId,
    required this.id,
    this.locationId,
    required this.name,
    this.parentId,
    this.sensorType,
    this.sensorId,
    this.status,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      getwayId: json['getwayId'],
      id: json['id'],
      locationId: json['locationId'],
      name: json['name'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
      sensorId: json['sensorId'],
      status: json['status'],
    );
  }
}

class LocationModel {
  final String id;
  final String name;
  final String parentId;

  const LocationModel({
    required this.id,
    required this.name,
    required this.parentId,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
