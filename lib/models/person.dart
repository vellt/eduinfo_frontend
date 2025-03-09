import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/user.dart';
import 'package:eduinfo/services/api_service.dart' as api;
class Person extends User {
  List<Institution> followedInstitutions;
  
  Person({required super.email, required super.name, required super.id, required super.avatarImage, required super.isAccepted, required super.isEnabled, required this.followedInstitutions});

  Person.forAdmin({
    required super.id,
    required super.name,
    required super.avatarImage,
    required super.email,
    required super.isAccepted,
    required super.isEnabled,
  }) : this.followedInstitutions=[];

  Person.forMessageRoom({
    required super.id,
    required super.name,
    required super.avatarImage,
  }) : this.followedInstitutions=[],super(isAccepted: true, isEnabled: true, email: "");

  Person.forProfile({
    required super.name,
    required super.avatarImage,
    required super.email,
    required this.followedInstitutions
  }) : super(isAccepted: true, isEnabled: true,id: 0);

  Person.none() : this.followedInstitutions=[],super(isAccepted: true, isEnabled: true, email: "", avatarImage: "", id: 0, name: "");

  factory Person.fromJsonForAdmin(Map<String, dynamic> json){
    return Person.forAdmin(
      email: json["email"],
      name: json["name"],
      id: json["person_profile_id"],
      avatarImage: api.imageUrl + json["avatar_image"],
      isAccepted: json["is_accepted"],
      isEnabled: json["is_enabled"],
    );
  }

  factory Person.fromJsonOfMesssagesRoom(Map<String, dynamic> json){
    return Person.forMessageRoom(
      id: json['person_profile_id'],
      avatarImage: api.imageUrl+json['avatar_image'],
      name: json['name'],
    );
  }

  factory Person.fromJsonOfProfile(Map<String, dynamic> json){
    return Person.forProfile(
      avatarImage: api.imageUrl+json['avatar_image'],
      name: json['name'],
      email: json['email'],
      followedInstitutions:(json['followed_institutions'] as List).map((item)=>Institution.fromJsonOfStories(item)).toList(),
    );
  }
}