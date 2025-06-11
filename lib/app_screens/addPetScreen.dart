import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petscare/app_screens/customDropdownField.dart';
import 'package:petscare/app_screens/gender_selector_button.dart';
import 'package:petscare/loginpages/custom_textformfield.dart';

class Addpetscreen extends StatefulWidget {
  const Addpetscreen({super.key});

  @override
  State<Addpetscreen> createState() => _AddpetscreenState();
}

class _AddpetscreenState extends State<Addpetscreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selectedSpecies;
  String? selectedBreed;
  String? selectedGender;
  bool isLoading = false;

  final List<String> speciesList = ['Dog', 'Cat', 'Bird'];
  final List<String> breedList = ['Breed 1', 'Breed 2', 'Breed 3'];

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    weightController.dispose();
    super.dispose();
  }

  String _parseErrorMessage(http.Response response) {
    try {
      final json = jsonDecode(response.body);
      return json['message'] ?? json['error'] ?? response.body;
    } catch (e) {
      return response.body;
    }
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      dobController.text = '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              child: SizedBox(
                height: screenHeight,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // APP BAR
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                          const SizedBox(width: 110),
                          const Text(
                            'My Pets',
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
                          color: const Color(0xffD9D9D9),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // PET AVATAR PLACEHOLDER
                      Container(
                        width: screenWidth * 0.1944,
                        height: screenHeight * 0.0898,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xffA0A0A0),
                        ),
                        child: Center(
                          child: Stack(
                            children: [
                              Icon(
                                Icons.person,
                                size: screenWidth * 0.1944,
                                color: Colors.white,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                              const Positioned(
                                bottom: 4,
                                right: 4,
                                child: Icon(
                                  Icons.add,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // FORM FIELDS
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              const Text(
                                "Pet's Name",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'poppins1',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.12,
                                ),
                              ),
                              CustomTextFormField(
                                hintText: "Enter pet's name",
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                validator: (value) => value?.isEmpty ?? true
                                    ? 'Please enter pet name'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Pet's Date of Birth",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'poppins1',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.12,
                                ),
                              ),
                              CustomTextFormField(
                                hintText: "Enter date",
                                controller: dobController,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value?.isEmpty ?? true)
                                    return 'Please enter birth date';
                                  if (!RegExp(r'^\d{2}/\d{2}/\d{4}$')
                                      .hasMatch(value!)) {
                                    return 'Use dd/mm/yyyy format';
                                  }

                                  // Add date validity check
                                  try {
                                    final parts = value.split('/');
                                    final day = int.parse(parts[0]);
                                    final month = int.parse(parts[1]);
                                    final year = int.parse(parts[2]);

                                    final date = DateTime(year, month, day);
                                    if (date.year != year ||
                                        date.month != month ||
                                        date.day != day) {
                                      return 'Enter a valid date';
                                    }
                                  } catch (e) {
                                    return 'Invalid date';
                                  }

                                  return null;
                                },
                                onTap:
                                    _selectDate, // Use the method you defined
                              ),
                              const SizedBox(height: 16),
                              const Text("Pet's Species"),
                              const SizedBox(height: 8),
                              CustomDropdownField<String>(
                                hintText: "Select species",
                                value: selectedSpecies,
                                items: speciesList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => selectedSpecies = val),
                                validator: (value) => value == null
                                    ? 'Please select species'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              const Text("Pet's Breed"),
                              const SizedBox(height: 8),
                              CustomDropdownField<String>(
                                hintText: "Select breed",
                                value: selectedBreed,
                                items: breedList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => selectedBreed = val),
                                validator: (value) => value == null
                                    ? 'Please select breed'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Pet's Weight",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'poppins1',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.12,
                                ),
                              ),
                              CustomTextFormField(
                                hintText: "Enter weight",
                                controller: weightController,
                                keyboardType: TextInputType.number,
                                validator: (value) => value?.isEmpty ?? true
                                    ? 'Please enter weight'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Pet's Gender",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'poppins1',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  GenderSelectorButton(
                                    gender: "Male",
                                    selectedGender: selectedGender ?? "",
                                    icon: Icons.male,
                                    onTap: () =>
                                        setState(() => selectedGender = "Male"),
                                  ),
                                  const SizedBox(width: 10),
                                  GenderSelectorButton(
                                    gender: "Female",
                                    selectedGender: selectedGender ?? "",
                                    icon: Icons.female,
                                    onTap: () => setState(
                                        () => selectedGender = "Female"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),

                      // SAVE BUTTON
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 16),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff000000).withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                ),
                                BoxShadow(
                                  color: const Color(0xff99DDCC).withOpacity(1),
                                  offset: Offset.zero,
                                  blurRadius: 20,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(43),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff99DDCC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 43),
                              ),
                              onPressed: () {},
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'poppins1',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 2.72,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
