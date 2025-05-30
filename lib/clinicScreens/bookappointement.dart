import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petscare/api/api_service.dart';
import 'package:petscare/app_screens/petavatar.dart';
import 'package:petscare/clinicScreens/appointmentSuccess.dart';

class Bookappointement extends StatefulWidget {
  const Bookappointement({super.key});

  @override
  State<Bookappointement> createState() => _BookappointementState();
}

class _BookappointementState extends State<Bookappointement> {
  // Controllers for text fields
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Selected date and time
  DateTime? _selectedDateTime;

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    // First select date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    String formatTime(TimeOfDay time) {
      // Convert to 12-hour format
      final hour = time.hourOfPeriod; // handles AM/PM automatically
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }

    if (pickedDate != null) {
      // Then select time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          // Combine date and time
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          // Update text fields
          _dayController.text = pickedDate.day.toString();
          _monthController.text = pickedDate.month.toString();
          _timeController.text = formatTime(pickedTime);
        });
      }
    }
  }
// here api
//   Future<void> _saveToDatabase() async {
//   // Validate required fields
//   if (_selectedDateTime == null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Please select date and time first')),
//     );
//     return;
//   }

//   if (selectedIndex == null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Please select a pet first')),
//     );
//     return;
//   }

//   if (selectedIndex2 == null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Please select a service first')),
//     );
//     return;
//   }

//   try {
//     // Prepare appointment data
//     final appointmentData = {
//       'dateTime': _selectedDateTime!.toIso8601String(),
//       'petId': pets[selectedIndex!]['name'], // or use actual pet ID if available
//       'service': services[selectedIndex2!]['name'],
//       'status': 'Pending', // default status
//       // Add any other required fields
//     };

//     // Call your API service
//     final response = await ApiService.saveAppointment(appointmentData);

//     if (response.statusCode == 200) {
//       // Success - navigate to success screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const Appointmentsuccess()),
//       );
//     } else {
//       // Handle API error
//       final errorMessage = jsonDecode(response.body)['message'] ?? 'Failed to save appointment';
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(errorMessage)),
//       );
//     }
//   } catch (e) {
//     // Handle any exceptions
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error saving appointment: ${e.toString()}')),
//     );
//     debugPrint('Appointment save error: $e');
//   }
// }

  int selectedIndex = 0;
  final List<Map<String, String>> pets = [
    {"name": "Ash", "imageUrl": "assets/images/Ellipse1.png"},
    {"name": "Eddie", "imageUrl": "assets/images/Ellipse3.png"},
    {"name": "Coco", "imageUrl": "assets/images/Ellipse2.png"},
  ];
  int? selectedIndex2;

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Scaffold(
        backgroundColor: Color(0xffF6F6F6),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // START APP BAR
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new),
                        ),
                        SizedBox(width: 70),
                        Text(
                          'Book Appointment',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Poppins3',
                            letterSpacing: 1.20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.0125),
                    SizedBox(
                      height: 1,
                      width: screenWidth,
                      child: Container(
                        color: Color(0xffD9D9D9),
                      ),
                    ),
                    // END APP BAR
                    // ###### - - - - - - #####
                    // START
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
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'Select Date & Time',
                        style: TextStyle(
                          color: const Color(0xFF222222),
                          fontSize: 16,
                          fontFamily: 'poppins2',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.96,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Day Container
                          Container(
                            height: 60,
                            width: 80,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffE1ECE9)),
                            child: Column(
                              children: [
                                Text(
                                  'Day',
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,
                                    fontFamily: 'poppins3',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.72,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: TextFormField(
                                      controller: _dayController,
                                      readOnly: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: 'DD',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      onTap: () => _selectDateTime(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Month Container
                          Container(
                            height: 60,
                            width: 80,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffE1ECE9)),
                            child: Column(
                              children: [
                                Text(
                                  'Month',
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,
                                    fontFamily: 'poppins3',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.72,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: TextFormField(
                                      controller: _monthController,
                                      readOnly: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: 'MM',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      onTap: () => _selectDateTime(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Time Container
                          Container(
                            height: 60,
                            width: 100,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffE1ECE9)),
                            child: Column(
                              children: [
                                Text(
                                  'Time',
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 12,
                                    fontFamily: 'poppins3',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.72,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: TextFormField(
                                      controller: _timeController,
                                      readOnly: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: 'HH:MM',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      onTap: () => _selectDateTime(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'Select Services',
                        style: TextStyle(
                          color: const Color(0xFF222222),
                          fontSize: 16,
                          fontFamily: 'poppins2',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.96,
                        ),
                      ),
                    ),
                    // asdasd serviesss
                    // add code here
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex2 = index;
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE1ECE9),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selectedIndex2 == index
                                          ? Color(
                                              0xff99DDCC) // Selected border color
                                          : Colors
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
                                        colorFilter: ColorFilter.mode(
                                          selectedIndex2 == index
                                              ? const Color(0xff99DDCC)
                                              : const Color(0xff4A4A4A),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  services[index]["name"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: selectedIndex2 == index
                                        ? Color(0xff99DDCC)
                                        : Color(0xff4A4A4A),
                                    fontSize: 12,
                                    fontFamily: 'Poppins3',
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35, left: 25, right: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // _saveToDatabase;

//
//
//
//
//
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
