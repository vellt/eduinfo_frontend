import 'package:eduinfo/screens/dashboard/institution/story/create_story/create_story_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/public_view/public_view_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/settings/edit_category/edit_category_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/settings/public_contacts/edit_email/edit_email_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/event/edit_event/edit_event_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/event/edit_event_description/edit_event_description_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/event/edit_event_links/edit_event_links_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/story/edit_story/edit_story_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/settings/public_contacts/edit_phone/edit_phone_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/settings/edit_profile/edit_profile_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/settings/public_contacts/edit_website/edit_website_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/event/event_details/event_details_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/event/create_event/create_event_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/message_details/message_details_screen.dart' as institutionMessage;
import 'package:eduinfo/screens/dashboard/person/following_list/following_list_screen.dart';
import 'package:eduinfo/screens/dashboard/person/message_details/message_details_screen.dart' as personMessage;
import 'package:eduinfo/screens/dashboard/person/events/events_screen.dart';
import 'package:eduinfo/screens/dashboard/person/institution_results/institution_results_screen.dart';
import 'package:eduinfo/screens/dashboard/person/settings/settings_screen.dart';
import 'package:eduinfo/screens/others/banned_user/banned_user_screen.dart';
import 'package:eduinfo/screens/others/not_accepted_user/not_accepted_user_screen.dart';
import 'package:eduinfo/screens/auth/registration/institution_registration/institution_registration_screen.dart';
import 'package:eduinfo/screens/auth/registration/person_registration/person_registration_screen.dart';
import 'package:eduinfo/screens/auth/registration/registration_chooser/registration_chooser_screen.dart';
import 'package:get/get.dart';
import '../screens/auth/login/login_screen.dart';
import 'package:eduinfo/screens/dashboard/admin/home/home_screen.dart' as adminHome;
import 'package:eduinfo/screens/dashboard/admin/details/institution_details/institution_details_screen.dart' as adminInstitutionDetails;
import 'package:eduinfo/screens/dashboard/admin/details/person_details/person_details_screen.dart' as adminPersonDetails;
import 'package:eduinfo/screens/dashboard/institution/home/home_screen.dart' as institutionHome;
import 'package:eduinfo/screens/dashboard/institution/settings/settings_chooser/settings_chooser_screen.dart' as institutionProfile;
import 'package:eduinfo/screens/dashboard/institution/settings/public_contacts/public_contacts_chooser/public_contacts_chooser_screen.dart';
import 'package:eduinfo/screens/dashboard/institution/settings/edit_description/edit_description_screen.dart';
import 'package:eduinfo/screens/dashboard/person/home/home_screen.dart' as personHome;

class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/registration_chooser', page: ()=>RegistrationChooserScreen()),
    GetPage(name: '/institution_registration', page: ()=>InstitutionRegistrationScreen()),
    GetPage(name: '/person_registration', page: ()=>PersonRegistrationScreen()),
    GetPage(name: '/admin_dashboard', page: ()=>adminHome.HomeScreen()),
    GetPage(name: '/admin_institution_details', page: ()=>adminInstitutionDetails.InstitutionDetailsScreen()),
    GetPage(name: '/admin_person_details', page: ()=>adminPersonDetails.PersonDetailsScreen()),
    GetPage(name: '/institution_dashboard', page: ()=>institutionHome.HomeScreen()),
    GetPage(name: '/settings', page: ()=>institutionProfile.SettingsChooserScreen()),
    GetPage(name: '/institution_contacts_screen', page: ()=>PublicContactsChooserScreen()),
    GetPage(name: '/edit_description', page: ()=>EditDescriptionScreen()),
    GetPage(name: '/edit_phone', page: ()=>EditPhoneScreen()),
    GetPage(name: '/edit_email', page: ()=>EditEmailScreen()),
    GetPage(name: '/edit_website', page: ()=>EditWebsiteScreen()),
    GetPage(name: '/edit_category', page: ()=>EditCategoryScreen()),
    GetPage(name: '/event_details', page: ()=>EventDetailsScreen()),
    GetPage(name: '/edit_profile', page: ()=>EditProfileScreen()),
    GetPage(name: '/create_event', page: ()=>CreateEventScreen()),
    GetPage(name: '/create_story', page: ()=>CreateStoryScreen()),
    GetPage(name: '/edit_event_description', page: ()=>EditEventDescriptionScreen()),
    GetPage(name: '/edit_event_links', page: ()=>EditEventLinksScreen()),
    GetPage(name: '/edit_event', page: ()=>EditEventScreen()),
    GetPage(name: '/edit_story', page: ()=>EditStoryScreen()),
    GetPage(name: '/institution_message_details', page: ()=>institutionMessage.MessageDetailsScreen()),
    GetPage(name: '/person_message_details', page: ()=>personMessage.MessageDetailsScreen()),
    GetPage(name: '/banned_user', page: ()=>BannedUserScreen()),
    GetPage(name: '/not_accepted_user', page: ()=>NotAcceptedUserScreen()),
    GetPage(name: '/public_view', page: ()=>PublicViewScreen()),
    GetPage(name: '/person_dashboard', page: ()=>personHome.HomeScreen()),
    GetPage(name: '/all_events', page: ()=>EventsScreen()),
    GetPage(name: '/institution_results', page: ()=>InstitutionResultsScreen()),
    GetPage(name: '/person_settings', page: ()=>SettingsScreen()),
    GetPage(name: '/following_list', page: ()=>FollowingListScreen()),


    //GetPage(name: '/admin_dashboard', page: () => AdminDashboardScreen()),
    //GetPage(name: '/person_dashboard', page: () => PersonDashboardScreen()),
    //GetPage(name: '/institution_dashboard', page: () => InstitutionDashboardScreen()),
  ];
}
