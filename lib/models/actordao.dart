class ActorDAO {
  final int id;
  final String name;
  final String character;
  final String profilePath;
  ActorDAO({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });
  factory ActorDAO.fromJson(Map<String, dynamic> json) {
    return ActorDAO(
      id: json['id'],
      name: json['name'],
      character: json['character'],
      profilePath: json['profile_path'] ?? '',
    );
  }
}
