class PublicEmail{
  int id;
  String title;
  String email;

  PublicEmail({required this.id, required this.title, required this.email});

  factory PublicEmail.fromJson(Map<String, dynamic> json) {
    return PublicEmail(
      id: json['public_email_id'],
      title: json['title'],
      email: json['email'],
    );
  }
}