class PublicWebsite {
  int id;
  String title;
  String website;
  PublicWebsite({required this.id, required this.title, required this.website});

  factory PublicWebsite.fromJson(Map<String, dynamic> json) {
    return PublicWebsite(
      id: json['public_website_id'],
      title: json['title'],
      website: json['website'],
    );
  }
}