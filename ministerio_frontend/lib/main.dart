import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ministerio_frontend/core/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple, textTheme: GoogleFonts.latoTextTheme()),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages,
      // initialBinding: AppBindings(),
      initialRoute: AppRoutes.initialRoute,
      
    );
  }
}
