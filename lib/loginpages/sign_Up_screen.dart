import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petscare/api/api_service.dart';
import 'package:petscare/app_screens/mainscreen.dart';
import 'package:petscare/loginpages/custom_textformfield.dart';
import 'package:petscare/loginpages/sign_In_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/user_service.dart';

class SignUpScreen extends StatefulWidget {
  final String role;
  const SignUpScreen({super.key, required this.role});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool agree = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final List fields;

  @override
  void initState() {
    super.initState();
    fields = [
      {
        "text": "Username",
        "keyboardtype": TextInputType.name,
        "obscuretext": false,
        "Controller": nameController,
        "prefixIcon": Icons.person,
        "suffixIcon": false,
        "textColor": const Color(0xff222222),
        "validator": (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your username';
          }
          if (value.length < 3) {
            return 'Username must be at least 3 characters';
          }
          return null;
        },
      },
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
      {
        "text": "Confirm Password",
        "keyboardtype": TextInputType.text,
        "obscuretext": true,
        "Controller": confirmPasswordController,
        "prefixIcon": Icons.lock,
        "suffixIcon": true,
        "textColor": const Color(0xff222222),
        "validator": (value) {
          if (value == null || value.isEmpty) {
            return 'Please confirm your password';
          }
          if (value != passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                // height: screenHeight,
                color: const Color(0xffF6F6F6),
                padding: const EdgeInsets.only(top: 92, left: 28, right: 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create \nYour Account",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: const Color(0xff222222),
                          fontSize: 28,
                          fontFamily: 'Poppins2',
                          letterSpacing: 2.24,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0250,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: fields.length,
                        itemBuilder: (context, index) {
                          var field = fields[index];
                          bool isPasswordField = field['text']
                              .toString()
                              .toLowerCase()
                              .contains('password');
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CustomTextFormField(
                              hintText: field['text'],
                              keyboardType: field['keyboardtype'],
                              obscureText: isPasswordField
                                  ? (index == 2
                                      ? !passwordVisible
                                      : !confirmPasswordVisible)
                                  : false,
                              controller: field['Controller'],
                              prefixIcon: field['prefixIcon'],
                              suffixIcon: isPasswordField
                                  ? (index == 2
                                      ? (passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off)
                                      : (confirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off))
                                  : null,
                              onSuffixTap: isPasswordField
                                  ? () {
                                      setState(() {
                                        if (index == 2) {
                                          passwordVisible = !passwordVisible;
                                        } else {
                                          confirmPasswordVisible =
                                              !confirmPasswordVisible;
                                        }
                                      });
                                    }
                                  : null,
                              textColor: field['textColor'],
                              validator: field['validator'],
                            ),
                          );
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: agree,
                            onChanged: (value) {
                              setState(() {
                                agree = value ?? false;
                              });
                            },
                            activeColor: const Color(0xff99DDCC),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          const Text(
                            "I agree to the terms and conditions",
                            style: TextStyle(
                              color: Color(0xFF757575),
                              fontSize: 14,
                              fontFamily: 'Poppins1',
                              letterSpacing: 1.12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _handleSignUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff99DDCC),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                elevation: 0,
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      "Sign Up",
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
                      SizedBox(
                        // Adjusted this spacer
                        height: MediaQuery.of(context).viewInsets.bottom > 0
                            ? 20
                            : MediaQuery.of(context).size.height * 0.1,
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
                  'Already Have An Account ? ',
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
                          builder: (context) => SignInScreen(
                                role: widget.role,
                              )),
                    );
                  },
                  child: const Text(
                    'Sign In',
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

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!agree) {
      _showErrorDialog('Please agree to the terms and conditions');
      return;
    }

    setState(() => isLoading = true);
    FocusScope.of(context).unfocus();

    try {
      final response = await ApiService.signUp({
        'username': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'role': 'petOwner',
        'phoneNumber': "0000000000", // Make this a field if needed
        'address': 'N/A', // Make this a field if needed
      });

      if (response.statusCode == 201) {
        // Auto-login after successful registration
        final loginResponse = await ApiService.signIn({
          'email': emailController.text.trim(),
          'password': passwordController.text,
          'role': widget.role,
        });

        if (loginResponse.statusCode == 200) {
          final loginData = jsonDecode(loginResponse.body);
          final user = loginData['user'] as Map<String, dynamic>? ?? {};

          await UserService.saveUserData(
            userId: user['_id']?.toString() ?? user['id']?.toString() ?? '',
            username: user['username']?.toString(),
            email: user['email']?.toString(),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Mainscreen()),
          );
        }
      } else {
        _handleSignUpError(response);
      }
    } catch (e) {
      _showErrorDialog('An error occurred: ${e.toString()}');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _handleSignUpError(http.Response response) {
    final responseBody = jsonDecode(response.body);
    String errorMessage = 'Registration failed';

    if (responseBody['errors'] != null) {
      errorMessage =
          responseBody['errors'].values.map((v) => v.join('\n')).join('\n');
    } else if (responseBody['message'] != null) {
      errorMessage = responseBody['message'];
    }

    _showErrorDialog(errorMessage);
  }

  void _showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
