import 'package:eduinfo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init(); // Inicializálja a GetStorage-t
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EduInfo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: AppRoutes.routes,
      theme:  ThemeData(
         colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green, // Alapszín meghatározása
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 40,
        ),
      ),
      defaultTransition: Transition.cupertino,
    );
  }
}
