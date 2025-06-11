import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petscare/app_screens/buttonAddPet.dart';
import 'package:petscare/app_screens/midicalRecords.dart';
import 'package:petscare/app_screens/mycustombutton.dart';
import 'package:petscare/app_screens/petavatar.dart';

class Petscreen extends StatefulWidget {
  const Petscreen({super.key});

  @override
  State<Petscreen> createState() => _PetscreenState();
}

class _PetscreenState extends State<Petscreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> pets = [
    {"name": "Ash", "imageUrl": "assets/images/Ellipse1.png"},
    {"name": "Eddie", "imageUrl": "assets/images/Ellipse3.png"},
    {"name": "Coco", "imageUrl": "assets/images/Ellipse2.png"},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF6F6F6),
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
                      color: Color(0xffBAD7DF).withOpacity(0.3),
                      blurRadius: 300,
                    ),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: SizedBox(
              height: screenHeight - screenHeight * 0.1809,
              child: Column(
                children: [
                  // START APP BAR
                  Text(
                    'My Pets',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins3',
                      letterSpacing: 1.20,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.0213),
                  SizedBox(
                    height: 1,
                    width: screenWidth,
                    child: Container(
                      color: Color(0xffD9D9D9),
                    ),
                  ),
                  // END APP BAR
                  // ###### - - - - - - #####
                  // START ADD PET
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: SizedBox(
                      height: screenHeight * 0.1078,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: pets.length + 1,
                        itemBuilder: (context, index) {
                          if (index < pets.length) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: PetAvatar(
                                name: pets[index]["name"]!,
                                imageUrl: pets[index]["imageUrl"]!,
                                isSelected: index == selectedIndex,
                              ),
                            );
                          } else {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Buttonaddpet(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    width: screenWidth,
                    child: Container(
                      color: Color(0xffD9D9D9),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                        color: const Color(0xFFE1ECE9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage:
                                  AssetImage(pets[selectedIndex]["imageUrl"]!),
                            ),
                            SizedBox(width: 8),
                            Text(
                              pets[selectedIndex]["name"]!,
                              style: TextStyle(
                                color: const Color(0xFF222222),
                                fontSize: 13,
                                fontFamily: 'poppins2',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.69,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.more_horiz,
                              color: Color(0xffA0A0A0),
                            )
                          ],
                        ),
                        SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.only(left: 60, bottom: 20),
                          child: GridView.count(
                            childAspectRatio: 5.5,
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/maleOrfemale.svg"),
                                  SizedBox(width: 8),
                                  Text(
                                    "male",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'poppins1',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.70,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/bd.svg"),
                                  SizedBox(width: 8),
                                  Text(
                                    "3 months old",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'poppins1',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.70,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/dna.svg"),
                                  SizedBox(width: 8),
                                  Text(
                                    "Golden Retriever",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'poppins1',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.70,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/lineicons.svg"),
                                  SizedBox(width: 8),
                                  Text(
                                    "4.5 kg",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'poppins1',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
