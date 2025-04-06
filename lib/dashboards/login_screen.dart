import 'package:flutter/material.dart';
import 'student_dashboard.dart';
import 'teacher_dashboard.dart';
import 'hod_dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = 'Student';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() {
    if (selectedRole == 'Student') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StudentDashboard()));
    } else if (selectedRole == 'Teacher') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TeacherDashboard()));
    } else if (selectedRole == 'HOD/Clerk') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HODDashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedRole,
              onChanged: (newValue) {
                setState(() {
                  selectedRole = newValue!;
                });
              },
              items: ['Student', 'Teacher', 'HOD/Clerk']
                  .map((role) => DropdownMenuItem(
                value: role,
                child: Text(role),
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
