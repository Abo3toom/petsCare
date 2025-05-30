import 'package:flutter/material.dart';
import 'package:petscare/loginpages/sign_In_Screen.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  String role = "petOwner";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF6F6F6),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: -200,
              top: 705,
              child: Container(
                width: 399,
                height: 432,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffFFE2E2).withOpacity(0.6),
                        blurRadius: 300,
                      ),
                    ]),
              ),
            ),
            Positioned(
              left: 207,
              top: -342,
              child: Container(
                width: 399,
                height: 432,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffBAD7DF).withOpacity(0.6),
                        blurRadius: 300,
                      ),
                    ]),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width *
                  0.1399, // in figma width screen = 393, and padding 55, 55\393 = 0.1399
              top: MediaQuery.of(context).size.height *
                  0.2312, // in figma height screen = 852, and padding 197, 197\852 = 0.2312
              child: SizedBox(
                width: 309,
                child: Text(
                  'Select Your Account Type',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF222222),
                    fontSize: 24,
                    fontFamily: 'Poppins2',
                    letterSpacing: 1.92,
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.0814,
              top: MediaQuery.of(context).size.height * 0.3955,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        role = 'petOwner'; // Set the selected container
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3944,
                          height: MediaQuery.of(context).size.height * 0.2511,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.23, 0.01),
                              end: Alignment(-0.20, 0.99),
                              colors: [
                                const Color(0xFFE1ECE9),
                                const Color(0xFF99DDCC),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                            border: role == 'petOwner'
                                ? Border.all(
                                    color: Color(
                                        0xff99DDCC), // Selected border color
                                    width: 3.0,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          "Pet Owner",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF4A4A4A),
                            fontSize: 15,
                            fontFamily: 'Poppins2',
                            letterSpacing: 1.20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.0508,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        role = 'veterinaryClinic'; // Set the selected container
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3944,
                          height: MediaQuery.of(context).size.height * 0.2511,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.23, 0.01),
                              end: Alignment(-0.20, 0.99),
                              colors: [
                                const Color(0xFFE1ECE9),
                                const Color(0xFF99DDCC),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                            border: role == 'veterinaryClinic'
                                ? Border.all(
                                    color: Color(
                                        0xff99DDCC), // Selected border color
                                    width: 3.0,
                                  )
                                : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 38),
                            child: Image.asset(
                                "assets/images/PhotoVeterinaryClinic.png",
                                fit: BoxFit.none),
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          "Veterinary Clinic",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF4A4A4A),
                            fontSize: 15,
                            fontFamily: 'Poppins2',
                            letterSpacing: 1.20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), //assets/images/PhotoBetOwner1.png

            Positioned(
              left: MediaQuery.of(context).size.width * 0.0076,
              top: MediaQuery.of(context).size.height * 0.4272,
              child: Image.asset(
                "assets/images/PhotoBetOwner1.png",
                width: MediaQuery.of(context).size.width * 0.5012,
                height: MediaQuery.of(context).size.height * 0.2312,
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.022,
              top: MediaQuery.of(context).size.height * 0.3644,
              child: Image.asset(
                "assets/images/PhotoBetOwner2.png",
              ),
            ),

            Positioned(
                right: MediaQuery.of(context).size.width * 0.0508,
                top: MediaQuery.of(context).size.height * 0.8873,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen(role: role)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff99DDCC),
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 14),
                      elevation: 0,
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins1',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2.72,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
