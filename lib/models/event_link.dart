class EventLink {
  int id;
  String title;
  String link;

  EventLink({required this.id, required this.title, required this.link});

  factory EventLink.fromJson(Map<String, dynamic> json) {
    return EventLink(
      id: json['event_link_id'],
      title: json['title'],
      link: json['link'],
    );
  }

  Map<String, String> toJson() {
    return {
      'event_link_id':id.toString(),
      'title': title,
      'link': link,
    };
  }
}