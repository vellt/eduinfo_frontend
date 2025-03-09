abstract class User {
  int id;
  String email;
  String name;
  bool isEnabled;
  bool isAccepted;
  String avatarImage;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarImage,
    required this.isAccepted,
    required this.isEnabled,
  });
}