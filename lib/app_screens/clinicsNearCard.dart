import 'package:flutter/material.dart';
import 'package:petscare/clinicScreens/mainClinicScreen.dart';

class Clinicsnearcard extends StatelessWidget {
  final String nameclinic;
  final String imageclinic;
  final String cliniclocation;
  final double rating;

  const Clinicsnearcard(
      {super.key,
      required this.nameclinic,
      required this.imageclinic,
      required this.cliniclocation,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Mainclinicscreen()),
          );
        },
        child: Container(
          width: screenWidth,
          decoration: BoxDecoration(
            color: Color(0xffEFF3F2),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: imageclinic.startsWith('http')
                      ? NetworkImage(imageclinic)
                      : AssetImage(imageclinic) as ImageProvider,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nameclinic,
                        style: TextStyle(
                          color: const Color(0xFF222222),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                          letterSpacing: 0.50,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xfff6f6f6)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color(0xffFFC107),
                                    size: 12,
                                  ),
                                  Text(
                                    rating.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'poppins3',
                                      fontWeight: FontWeight.w400,
                                      height: 2.40,
                                      letterSpacing: 0.50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(cliniclocation),
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
