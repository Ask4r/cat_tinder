class Breed {
  const Breed({required this.id, required this.name});
  final String id;
  final String name;

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(
    id: json['id'] is String ? json['id'] as String : '',
    name: json['name'] is String ? json['name'] as String : '',
  );
}
