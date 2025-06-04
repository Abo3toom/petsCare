import 'package:flutter/material.dart';

class Midicalrecords extends StatefulWidget {
  const Midicalrecords({super.key});

  @override
  State<Midicalrecords> createState() => __MidicalrecordsState();
}

class __MidicalrecordsState extends State<Midicalrecords> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        body: Stack(
          children: [
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
                      color: const Color(0xffBAD7DF).withOpacity(0.3),
                      blurRadius: 300,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // App Bar
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                      const SizedBox(width: 80),
                      const Text(
                        'Midical Records',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins3',
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xffD9D9D9)),
                  // Body
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
