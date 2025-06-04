import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:petscare/api/api_service.dart';
import 'package:petscare/api/user_service.dart';
import 'package:petscare/app_screens/mainscreen.dart';
import 'package:petscare/clinicprofil/clinicprofile.dart';
import 'package:petscare/loginpages/custom_textformfield.dart';
import 'package:petscare/loginpages/sign_Up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  final String role;
  const SignInScreen({super.key, required this.role});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final List<Map<String, dynamic>> fields;

  bool passwordVisible = false;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Renamed for clarity

  @override
  void initState() {
    super.initState();
    fields = [
      {
        "text": "Email",
        "keyboardtype": TextInputType.emailAddress,
        "obscuretext": false,
        "Controller": emailController,
        "prefixIcon": Icons.email,
        "suffixIcon": false,
        "textColor": const Color(0xff222222),
        "validator": (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
      },
      {
        "text": "Password",
        "keyboardtype": TextInputType.text,
        "obscuretext": true,
        "Controller": passwordController,
        "prefixIcon": Icons.lock,
        "suffixIcon": true,
        "textColor": const Color(0xff222222),
        "validator": (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
      },
    ];
  }

  void _showErrorDialog(String errorMessage) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: errorMessage,
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    String role = widget.role;
    bool _isLoading = false;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                // height: screenHeight,
                color: const Color(0xffF6F6F6),
                padding: const EdgeInsets.only(top: 144, left: 28, right: 28),
                child: Form(
                  key: _formKey, // Only one Form widget with this key
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let's Get You \nSign In !",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: const Color(0xff222222),
                          fontSize: 28,
                          fontFamily: 'Poppins2',
                          letterSpacing: 2.24,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: fields.length,
                        itemBuilder: (context, index) {
                          final field = fields[index];
                          final isPasswordField = field["text"]
                              .toString()
                              .toLowerCase()
                              .contains('password');
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CustomTextFormField(
                              hintText: field["text"],
                              keyboardType: field["keyboardtype"],
                              obscureText:
                                  isPasswordField ? !passwordVisible : false,
                              controller: field["Controller"],
                              prefixIcon: field["prefixIcon"],
                              suffixIcon: isPasswordField
                                  ? (passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off)
                                  : null,
                              onSuffixTap: isPasswordField
                                  ? () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    }
                                  : null,
                              textColor: field["textColor"],
                              validator: field["validator"],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 54),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    setState(() => _isLoading = true);
                                    FocusScope.of(context).unfocus();

                                    final response = await ApiService.signIn({
                                      'email': emailController.text.trim(),
                                      'password': passwordController.text,
                                      'role': role,
                                    });

                                    if (response.statusCode == 200) {
                                      final responseData =
                                          jsonDecode(response.body);

                                      // Debug: Print the entire response to verify structure
                                      debugPrint(
                                          'Login Response: $responseData');

                                      final user = responseData['user']
                                              as Map<String, dynamic>? ??
                                          {};
                                      final userId = user['_id']?.toString() ??
                                          user['id']?.toString();
                                      final username = user['username']
                                          ?.toString(); // or user['username']?
                                      final email = user['email']?.toString();

                                      if (userId == null) {
                                        throw Exception(
                                            'User ID not found in response');
                                      }

                                      // Debug: Print values before saving
                                      debugPrint(
                                          'Saving user data: $userId, $username, $email');

                                      await UserService.saveUserData(
                                        userId: userId,
                                        username:
                                            username, // Make sure this matches the API response field
                                        email: email,
                                      );

                                      // Verify the data was saved
                                      // await UserService.debugPrintAllValues();

                                      if (widget.role == "petOwner") {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Mainscreen()),
                                        );
                                      } else if (widget.role ==
                                          "veterinaryClinic") {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Clinicprofile()),
                                        );
                                      }
                                    } else {
                                      final error = jsonDecode(
                                              response.body)?['message'] ??
                                          'Sign-in failed';
                                      _showErrorDialog(error.toString());
                                    }
                                  } catch (e) {
                                    _showErrorDialog(
                                        'Error during sign-in: ${e.toString()}');
                                    debugPrint('Sign-in error: $e');
                                  } finally {
                                    if (mounted)
                                      setState(() => _isLoading = false);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff99DDCC),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                elevation: 0,
                              ),
                              child: _isLoading
                                  // ignore: dead_code
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "Sign In",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Poppins1',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 2.72,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t Have An Account ? ',
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 14,
                    fontFamily: 'Poppins1',
                    letterSpacing: 2.38,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpScreen(
                                role: role,
                              )),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xFF99DDCC),
                      fontSize: 14,
                      fontFamily: 'Poppins1',
                      letterSpacing: 2.38,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
