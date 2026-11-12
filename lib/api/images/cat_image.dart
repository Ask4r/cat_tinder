import '../breeds/breed.dart';

class CatImage {
  CatImage({required this.id, required this.url, required List<Breed> breeds})
    : breeds = List.unmodifiable(breeds);
  final String id;
  final String url;
  final List<Breed> breeds;

  bool get usable =>
      id.isNotEmpty &&
      Uri.tryParse(url)?.scheme == 'https' &&
      Uri.tryParse(url)?.hasAuthority == true &&
      breeds.isNotEmpty &&
      breeds.first.id.trim().isNotEmpty &&
      breeds.first.name.trim().isNotEmpty;

  factory CatImage.fromJson(Map<String, dynamic> json) => CatImage(
    id: json['id'] is String ? json['id'] as String : '',
    url: json['url'] is String ? json['url'] as String : '',
    breeds: json['breeds'] is List
        ? (json['breeds'] as List)
              .map(
                (value) => Breed.fromJson(
                  value is Map<String, dynamic> ? value : <String, dynamic>{},
                ),
              )
              .toList()
        : [],
  );
}
