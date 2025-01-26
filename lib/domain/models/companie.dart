class Companie {
  final String id;
  final String name;

  const Companie({
    required this.id,
    required this.name,
  });

  factory Companie.fromJson(Map<String, dynamic> json) {
    return Companie(
      id: json['id'],
      name: json['name'],
    );
  }
}
