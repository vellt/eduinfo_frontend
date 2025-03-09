import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/person.dart';


class MessagingRoom {
  int id;
  String lastMessage;
  String formattedDate;
  bool dontAnswered;
  Person person;
  Institution institution;
  MessagingRoom({
    required this.id,
    required this.lastMessage,
    required this.formattedDate,
    required this.dontAnswered,
    required this.person,
    required this.institution,
  });

  factory MessagingRoom.fromJsonOfInstitution(Map<String, dynamic> json) {
    return MessagingRoom(
      id: json['messaging_room_id'],
      lastMessage: json['last_message'],
      formattedDate: json['formatted_date'],
      dontAnswered: json['from_person_profile'],
      person: Person.fromJsonOfMesssagesRoom(json['person_profile']),
      institution: Institution.none(),
    );
  }

  factory MessagingRoom.fromJsonOfPerson(Map<String, dynamic> json) {
    return MessagingRoom(
      id: json['messaging_room_id'],
      lastMessage: json['last_message'],
      formattedDate: json['formatted_date'],
      dontAnswered: !json['from_person_profile'],
      institution: Institution.fromJsonOfStories(json['institution_profile']),
      person: Person.none(),
      
    );
  }
}