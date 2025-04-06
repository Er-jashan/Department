// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'department_provider.dart';
// import 'signup_screen.dart';
// import 'login_screen.dart';
// import 'student_dashboard.dart';
// import 'teacher_dashboard.dart';
// import 'hod_dashboard.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => DepartmentProvider(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData.light(),
//         darkTheme: ThemeData.dark(),
//         initialRoute: '/signup',
//         routes: {
//           '/signup': (context) => SignupScreen(),
//           '/login': (context) => LoginScreen(),
//           '/student': (context) => StudentDashboard(),
//           '/teacher': (context) => TeacherDashboard(),
//           '/hod': (context) => HODDashboard(),
//         },
//       ),
//     );
//   }
// }