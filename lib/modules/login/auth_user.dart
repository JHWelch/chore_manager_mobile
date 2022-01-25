class AuthUser {
  final int id;
  final String name;
  final String email;
  final int currentTeamId;
  final String? profilePhotoPath;

  AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.currentTeamId,
    this.profilePhotoPath,
  });

  AuthUser.fromJson(json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        profilePhotoPath = json['profile_photo_path'],
        currentTeamId = json['current_team_id'];
}
