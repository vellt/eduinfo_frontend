import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/message.dart';
import 'package:eduinfo/models/person.dart';

class MessageDetails {
  int id;
  Person person;
  Institution institution;
  List<Message> messages;

  MessageDetails({
    required this.id,
    required this.person,
    required this.institution,
    required this.messages,
  });

  factory MessageDetails.fromJsonOfInstitution(Map<String, dynamic> json) {
    print(json);
    return MessageDetails(
      id: json['messaging_room_id'],
      person: Person.fromJsonOfMesssagesRoom(json['person_profile']),
      messages: (json['messages'] as List).map((item)=>Message.fromJsonOfInstitution(item)).toList(),
      institution: Institution.none()
    );
  }

  factory MessageDetails.fromJsonOfPerson(Map<String, dynamic> json) {
    print(json);
    return MessageDetails(
      id: json['messaging_room_id'],
      institution: Institution.fromJsonOfStories(json['institution_profile']),
      messages: (json['messages'] as List).map((item)=>Message.fromJsonOfPerson(item)).toList(),
      person: Person.none()
    );
  }

  factory MessageDetails.none() {
    return MessageDetails(
      id: 0,
      messages: [],
      person: Person.none(),
      institution: Institution.none()
    );
  }
}