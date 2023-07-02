import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:rental_camera_admin/screens/dashboard_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'menu_app_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBXvBpMDGSeF4Qewloh_2kQ_SPNXM_Z8-8",
        appId: "appId",
        messagingSenderId: "336287873014",
        projectId: "rental-camera-project",
        storageBucket: "rental-camera-project.appspot.com",
      ),
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      await Firebase.initializeApp();
    }
  }
  await initializeDateFormatting('id');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (_, __, ___) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ChangeNotifierProvider<MenuAppController>(
              create: (_) => MenuAppController(),
              child: const DashboardScreen(),
            ),
          );
        }
    );
  }
}
