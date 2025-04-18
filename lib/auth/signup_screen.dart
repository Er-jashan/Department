import 'dart:developer';
import 'auth_service.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:department_management/home_screen.dart';
import 'package:department_management/widgets/button.dart';
import 'package:department_management/widgets/textfield.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();
  final _firestore = FirebaseFirestore.instance;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _rollNo = TextEditingController();

  String _selectedRole = 'Student';
  final List<String> _roles = ['Student', 'Teacher', 'HOD'];

  String _errorMessage = '';

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    if (_selectedRole == 'Student')
      _rollNo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            const Text("Signup",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            const SizedBox(height: 50),

            CustomTextField(
              hint: "Enter Name",
              label: "Name",
              controller: _name,
            ),
            const SizedBox(height: 20),

            CustomTextField(
              hint: "Enter Email",
              label: "Email",
              controller: _email,
            ),
            const SizedBox(height: 20),

            CustomTextField(
              hint: "Enter Password",
              label: "Password",
              isPassword: true,
              controller: _password,
            ),
            const SizedBox(height: 20),

            CustomTextField(
              hint: "Enter Roll No.",
              label: "Roll No.",
              controller: _rollNo,
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Select Role",
                border: OutlineInputBorder(),
              ),
              value: _selectedRole,
              items: _roles
                  .map((role) =>
                  DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Error Message Display
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            CustomButton(
              label: "Signup",
              onPressed: _signup,
            ),
            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                InkWell(
                  onTap: () => goToLogin(context),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  goToLogin(BuildContext context) =>
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  goToHome(BuildContext context) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );

  _signup() async {
    setState(() {
      _errorMessage = '';
    });

    try {
      final role = _selectedRole.toLowerCase(); // convert role to lowercase

      final user = await _auth.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
        name: _name.text.trim(),
        role: role,
      );

      if (user != null) {
        // Add extra fields like rollNo for students only
        if (role == 'student') {
          await _firestore.collection('users').doc(user.uid).update({
            'rollNo': _rollNo.text.trim(),
          });
        }

        log("User Created Successfully");
        goToHome(context);
      }
    } catch (e) {
      log("Signup Error: $e");
      setState(() {
        _errorMessage = e
            .toString()
            .split('] ')
            .last;
      });
    }
  }
}