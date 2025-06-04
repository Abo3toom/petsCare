import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petscare/clinicScreensAndAppointment/bookappointement.dart';

class Clinicprofile extends StatefulWidget {
  const Clinicprofile({super.key});

  @override
  State<Clinicprofile> createState() => _MainclinicscreenState();
}

class _MainclinicscreenState extends State<Clinicprofile> {
  final List<Map<String, dynamic>> services = [
    {"name": "Check Up", "imageUrl": "assets/images/asd1.svg"},
    {"name": "Vaccination", "imageUrl": "assets/images/asd2.svg"},
    {"name": "Grooming", "imageUrl": "assets/images/asd3.svg"},
    {"name": "Treatment", "imageUrl": "assets/images/asd4.svg"},
    {"name": "Surgery", "imageUrl": "assets/images/asd5.svg"},
    {"name": "Dental Care", "imageUrl": "assets/images/asd6.svg"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
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
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),

              // Clinic Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Column(
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
                        //
                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Services',
                            style: TextStyle(
                              color: const Color(0xFF222222),
                              fontSize: 16,
                              fontFamily: 'poppins1',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.96,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 12),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xffE1ECE9),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors
                                        .transparent, // No border when not selected
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      services[index][
                                          "imageUrl"], // Uses the SVG path from your services list
                                      width: 32,
                                      height: 32,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                services[index]["name"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff4A4A4A),
                                  fontSize: 12,
                                  fontFamily: 'Poppins3',
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
