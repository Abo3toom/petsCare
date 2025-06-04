import 'package:flutter/material.dart';
import 'package:petscare/app_screens/mainscreen.dart';
import 'package:petscare/clinicScreensAndAppointment/mainClinicScreen.dart';

class Appointmentsuccess extends StatefulWidget {
  const Appointmentsuccess({super.key});

  @override
  State<Appointmentsuccess> createState() => _Appointmentsuccess();
}

class _Appointmentsuccess extends State<Appointmentsuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          bottom: 58,
        ),
        color: Color(0xffF6F6F6),
        child: Column(
          children: [
            Container(
              width: 1000,
              height: 420,
              // color: Colors.amber,
              padding: EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/appsucc.png",
                  height: 350,
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 75, right: 21, left: 21),
              child: Column(
                children: [
                  Text(
                    "Appointment Booked \nSuccessfully!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: 24,
                      fontFamily: 'Poppins2',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.92,
                    ),
                  ),
                  SizedBox(height: 37),
                  Text(
                    "Your appointment has been \nconfirmed. We look forward to \nseeing you! ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF888888),
                      fontSize: 16,
                      fontFamily: 'Poppins1',
                      letterSpacing: 2.72,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 145,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 31),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Mainscreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff99DDCC),
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 14),
                        elevation: 0,
                      ),
                      child: Text(
                        "View Appointment",
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
            ),
          ],
        ),
      ),
    );
  }
}
