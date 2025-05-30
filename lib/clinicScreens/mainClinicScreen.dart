import 'package:flutter/material.dart';
import 'package:petscare/clinicScreens/bookappointement.dart';

class Mainclinicscreen extends StatefulWidget {
  const Mainclinicscreen({super.key});

  @override
  State<Mainclinicscreen> createState() => _MainclinicscreenState();
}

class _MainclinicscreenState extends State<Mainclinicscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Clinic Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Poppins3',
            fontWeight: FontWeight.w500,
            letterSpacing: 1.08,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/clicniphoto3.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),

                // Clinic Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Clinic Avatar and Name
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const CircleAvatar(
                      //       radius: 50,
                      //       backgroundImage: AssetImage(
                      //         'assets/images/photocli.jpg',
                      //       ),
                      //     ),
                      //     const SizedBox(height: 16),
                      //     Text(
                      //       'VetCave',
                      //       style: TextStyle(
                      //         color: const Color(0xFF222222),
                      //         fontSize: 18,
                      //         fontFamily: 'Poppins',
                      //         fontWeight: FontWeight.w600,
                      //         letterSpacing: 3.06,
                      //       ),
                      //     ),
                      //     const SizedBox(height: 8),
                      //   ],
                      // ),

                      const SizedBox(height: 100),

                      // Rating
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 24),
                            Icon(Icons.star, color: Colors.amber, size: 24),
                            Icon(Icons.star, color: Colors.amber, size: 24),
                            Icon(Icons.star, color: Colors.amber, size: 24),
                            Icon(Icons.star_outline,
                                color: Colors.amber, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              '4 Stars',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Address Section
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Address',
                          style: TextStyle(
                            color: const Color(0xFF222222),
                            fontSize: 16,
                            fontFamily: 'poppins1',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          '123 Veterinary Street, Pet City, PC 12345',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Working hours',
                          style: TextStyle(
                            color: const Color(0xFF222222),
                            fontSize: 16,
                            fontFamily: 'poppins1',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Open: 9 AM - Closed 8 PM',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(height: 250),

                      // Book Appointment Button
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Bookappointement()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff99DDCC),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 14),
                                elevation: 0,
                              ),
                              child: Text(
                                "Book Appointment",
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
              ],
            ),
          ),
          Positioned(
            top: 250,
            left: 42,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    'assets/images/photocli.jpg',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'VetCave',
                  style: TextStyle(
                    color: const Color(0xFF222222),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3.06,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
