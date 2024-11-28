class VideoDAO {
  final String key;
  final String name;
  VideoDAO({required this.key, required this.name});
  factory VideoDAO.fromJson(Map<String, dynamic> json) {
    return VideoDAO(
      key: json['key'],
      name: json['name'],
    );
  }
}
