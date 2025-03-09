class Message {
  int id;
  String message;
  String formattedDate;
  bool isMine;

  Message({
    required this.id,
    required this.message,
    required this.formattedDate,
    required this.isMine,
  });

  factory Message.fromJsonOfInstitution(Map<String, dynamic> json) {
    print(json);
    return Message(
      id: json['message_id'],
      message: json['message'],
      formattedDate: json['formatted_date'],
      isMine: !(json['from_person_profile'] as bool),
    );
  }

  factory Message.fromJsonOfPerson(Map<String, dynamic> json) {
    print(json);
    return Message(
      id: json['message_id'],
      message: json['message'],
      formattedDate: json['formatted_date'],
      isMine: (json['from_person_profile'] as bool),
    );
  }

}