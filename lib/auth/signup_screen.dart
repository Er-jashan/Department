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
  final _rollNo = TextEditingController(); // NEW: Controller for Roll No

  String _selectedRole = 'Student';
  final List<String> _roles = ['Student', 'Teacher', 'HOD'];

  String _errorMessage = '';

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _rollNo.dispose(); // NEW: Dispose roll no controller
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

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Select Role",
                border: OutlineInputBorder(),
              ),
              value: _selectedRole,
              items: _roles
                  .map((role) => DropdownMenuItem(
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

            // Conditionally show Roll No field
            if (_selectedRole == 'Student')
              Column(
                children: [
                  CustomTextField(
                    hint: "Enter Roll No",
                    label: "Roll No",
                    controller: _rollNo,
                  ),
                  const SizedBox(height: 20),
                ],
              ),

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

  goToLogin(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );

  goToHome(BuildContext context) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const HomeScreen()),
  );

  _signup() async {
    setState(() {
      _errorMessage = '';
    });

    try {
      final user = await _auth.createUserWithEmailAndPassword(
        _email.text.trim(),
        _password.text.trim(),
      );

      if (user != null) {
        final userData = {
          'uid': user.uid,
          'name': _name.text.trim(),
          'email': _email.text.trim(),
          'role': _selectedRole,
          'createdAt': FieldValue.serverTimestamp(),
        };

        // Add Roll No only if the user is a Student
        if (_selectedRole == 'Student') {
          userData['rollNo'] = _rollNo.text.trim();
        }

        await _firestore.collection('users').doc(user.uid).set(userData);

        log("User Created Successfully");
        goToHome(context);
      }
    } catch (e) {
      log("Signup Error: $e");
      setState(() {
        _errorMessage = e.toString().split('] ').last; // Clean error message
      });
    }
  }
}
