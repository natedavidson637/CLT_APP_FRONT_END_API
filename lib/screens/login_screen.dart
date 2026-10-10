import 'package:flutter/material.dart';

import '../services/api.dart';
import 'home_screen.dart';
import 'home_feed_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  Future<void> _submitLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      try {
        final result = await ApiService.login(
          username: username,
          password: password,
        );

        print("Login success: $result");

        // TODO: Store JWT token
        final token = result["access_token"];

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeFeedScreen()),
        );
      } catch (e) {
        setState(() {
          errorMessage = "Invalid username or password";
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 40),

                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                if (errorMessage != null)
                  Text(errorMessage!, style: TextStyle(color: Colors.red)),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: isLoading ? null : _submitLogin,
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Login"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),

                SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back to Signup"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
