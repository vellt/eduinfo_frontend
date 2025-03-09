import 'package:eduinfo/models/public_email.dart';
import 'package:eduinfo/models/institution_category.dart';
import 'package:eduinfo/models/story.dart';
import 'package:eduinfo/models/public_phone.dart';
import 'package:eduinfo/models/user.dart';
import 'package:eduinfo/models/institution_event.dart';
import 'package:eduinfo/models/public_website.dart';
import 'package:eduinfo/services/api_service.dart' as api;

class Institution extends User {
  String bannerImage;
  int followers;
  String description;
  bool followed; // Új mező a személyes követési állapothoz
  List<Story> stories;
  List<InstitutionEvent> events;
  List<PublicEmail> emails;
  List<PublicPhone> phones;
  List<PublicWebsite> websites;
  List<InstitutionCategory> InstitutionCategories;

  Institution.forAdmin({
    required super.id,
    required super.email,
    required super.name,
    required super.avatarImage,
    required super.isAccepted,
    required super.isEnabled,
  }) : bannerImage = '', followers = 0, followed = false, InstitutionCategories=[], emails=[], description='', events=[], stories=[], phones=[], websites=[];

  Institution.forStories({
    required super.id,
    required super.avatarImage,
    required super.name,
  }) : bannerImage = '', followers = 0, followed = false, InstitutionCategories=[], emails=[], description='', events=[], stories=[], phones=[], websites=[], super(email: "", isAccepted: false, isEnabled: false, );

  Institution.forEvents({
    required super.id,
    required super.avatarImage,
    required this.bannerImage,
  }) : followers = 0, followed = false, InstitutionCategories=[], emails=[], description='', events=[], stories=[], phones=[], websites=[], super(email: "", isAccepted: false, isEnabled: false, name: "");

  Institution.forInstitution({
    required super.id,
    required super.email,
    required super.name,
    required super.avatarImage,
    required this.bannerImage,
    required this.followers,
    required this.description,
    required this.stories,
    required this.events,
    required this.emails,
    required this.phones,
    required this.websites,
    required this.InstitutionCategories,
  }) : followed = false, super(isAccepted: true, isEnabled: true);

  Institution.forPerson({
    required super.id,
    required super.name,
    required super.avatarImage,
    required this.bannerImage,
    required this.followers,
    required this.followed,
    required this.description,
    required this.stories,
    required this.events,
    required this.emails,
    required this.phones,
    required this.websites,
    required this.InstitutionCategories,
  }) : super(email: "", isAccepted: true, isEnabled: true);

  Institution.none() : InstitutionCategories=[], bannerImage='', description='', emails=[], events= [], followers=0, followed=false, stories=[], phones=[], websites=[],super(isAccepted: true, isEnabled: true, avatarImage: '', email: '',id: 1, name: '');

  factory Institution.fromJsonOfInstitution(Map<String, dynamic> json) {
    print(json);
    return Institution.forInstitution(
      id: json['institution_profile_id'],
      email: json['email'],
      name: json['name'],
      avatarImage: api.imageUrl + json['avatar_image'],
      bannerImage: api.imageUrl + json['banner_image'],
      followers: json['followers'],
      description: json['description'],
      stories: (json['stories'] as List).map((item) => Story.fromJson(item)).toList(),
      events: (json['events'] as List).map((item) => InstitutionEvent.fromJsonOfInstitution(item)).toList(),
      emails: (json['public_emails'] as List).map((item) => PublicEmail.fromJson(item)).toList(),
      phones: (json['public_phones'] as List).map((item) => PublicPhone.fromJson(item)).toList(),
      websites: (json['public_websites'] as List).map((item) => PublicWebsite.fromJson(item)).toList(),
      InstitutionCategories: (json['categories'] as List).map((item) => InstitutionCategory.fromJson(item)).toList(),
    );
  }

  factory Institution.fromJsonForAdmin(Map<String, dynamic> json) {
    return Institution.forAdmin(
      id: json['institution_profile_id'],
      email: json['email'],
      name: json['name'],
      isAccepted: json["is_accepted"],
      isEnabled: json["is_enabled"],
      avatarImage: api.imageUrl + json['avatar_image'],
    );
  }

  factory Institution.fromJsonForPerson(Map<String, dynamic> json) {
    return Institution.forPerson(
      id: json['institution_profile_id'],
      name: json['name'],
      avatarImage: api.imageUrl + json['avatar_image'],
      bannerImage: api.imageUrl + json['banner_image'],
      followers: json['followers'],
      followed: json['followed'],
      description: json['description'],
      stories: (json['stories'] as List).map((item) => Story.fromJson(item)).toList(),
      events: (json['events'] as List).map((item) => InstitutionEvent.fromJsonOfPerson(item)).toList(),
      emails: (json['public_emails'] as List).map((item) => PublicEmail.fromJson(item)).toList(),
      phones: (json['public_phones'] as List).map((item) => PublicPhone.fromJson(item)).toList(),
      websites: (json['public_websites'] as List).map((item) => PublicWebsite.fromJson(item)).toList(),
      InstitutionCategories: (json['categories'] as List).map((item) => InstitutionCategory.fromJson(item)).toList(),
    );
  }
  factory Institution.fromJsonOfStories(Map<String, dynamic> json){
    return Institution.forStories(
      id: json['institution_profile_id'],
      avatarImage: api.imageUrl+json['avatar_image'],
      name: json['name'],
    );
  }

  factory Institution.fromJsonOfEvents(Map<String, dynamic> json){
    return Institution.forEvents(
      id: json['institution_profile_id'],
      avatarImage: api.imageUrl+json['avatar_image'],
      bannerImage: api.imageUrl+json['banner_image'],
    );
  }
}