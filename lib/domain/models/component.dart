enum Status {
  operating,
  alert,
}

class Component {
  final String id;
  final String name;
  final String? parentId;
  final String sensorId;
  final String sensorType;
  final Status status;
  final String? gatewayId;
  final String? locationId;

  const Component({
    required this.id,
    required this.name,
    this.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    this.gatewayId,
    this.locationId,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'] == "alert" ? Status.alert : Status.operating,
      gatewayId: json['gatewatId'],
      locationId: json['locationId'],
    );
  }
}
