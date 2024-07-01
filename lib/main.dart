import 'package:attendanceapp/app/core/constant/string_const.dart';
import 'package:attendanceapp/app/core/utils/local_storage/storage_utility.dart';
import 'package:attendanceapp/app/modules/attendance/attendance_view.dart';
import 'package:attendanceapp/app/modules/auth/emailvarification/emailverificationscreen.dart';
import 'package:attendanceapp/app/modules/auth/forgot_screen.dart';
import 'package:attendanceapp/app/modules/home/home_view.dart';
import 'package:attendanceapp/app/modules/notice/notice_view.dart';
import 'package:attendanceapp/app/modules/notice/notice_list.dart';
import 'package:attendanceapp/app/modules/profile/profile_view.dart';
import 'package:attendanceapp/app/navigation.dart';
import 'package:attendanceapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/auth/login/login_screen.dart';
import 'app/modules/auth/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  //getsorage initialized
  await GetStorage.init();

  // initialized Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest,
    );
  } on FirebaseException catch (e) {
    if (kDebugMode) {
      print("Firebase initialization failed: ${e.message}");
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalStorage localStorage = LocalStorage();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: (localStorage.readData(StringConst.loggedin) == null ||
              localStorage.readData(StringConst.loggedin) == false)
          ? const LoginScreen()
          : const NavigationScreen(), 
      getPages: [
        GetPage(name: '/', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/emailver', page: () => const Emailverificationscreen()),
        GetPage(name: '/forgot', page: () => const ForgotPasswordScreen()),
        GetPage(name: '/profile', page: () => const ProfileView()),
        GetPage(name: '/notice_list', page: () => const NoticeList()),
        GetPage(name: '/notice_view', page: () => const NoticeView()),
        GetPage(name: '/attendance_view', page: () => const AttendanceView()),
      ],
    );
  }
}
