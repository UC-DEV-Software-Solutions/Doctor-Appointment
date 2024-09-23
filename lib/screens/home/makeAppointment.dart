import 'package:firebase_testing/widgets/doctorDropDown.dart';
import 'package:flutter/material.dart';
import '../../constants/colours.dart';
import '../../models/UserModel.dart';
import '../../services/appointment.dart';
import '../../services/auth.dart';
import '../../services/doctorDetails.dart';
import '../../widgets/paymentSelectionDialog.dart';
import '../../widgets/statusBanner.dart';
import '../../widgets/textField.dart';

class Makeappointment extends StatefulWidget {
  @override
  State<Makeappointment> createState() => _MakeappointmentState();
}

class _MakeappointmentState extends State<Makeappointment> {
  List<String> _doctors = [];

  Future<UserModel>? _userData;

  String? _selectedDoctor;
  DateTime _selectedDate = DateTime.now();

  // Controllers for TextFields
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  // Fetch doctors from Firestore and update the dropdown
  Future<void> _fetchDoctors() async {
    try {
      DoctorDetailsService doctorService = DoctorDetailsService();
      final doctorList = await doctorService.getDoctors().first;
      setState(() {
        _doctors = doctorList.map((doc) => doc.dName).toList();
        if (_doctors.isNotEmpty) {
          _selectedDoctor = _doctors.first;
        }
      });
    } catch (error) {
      print("Error fetching doctors: $error");
    }
  }

  // Callback function to handle doctor selection
  void _handleDoctorSelection(String? selectedDoctor) {
    setState(() {
      _selectedDoctor = selectedDoctor;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
    _userData = AuthServices().getCurrentUser();
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PaymentSelectionDialog(
          onPaymentOptionSelected: (selectedOption) {
            print("Selected Payment Method: $selectedOption");
          },
        );
      },
    );
  }

  String? statusMessage;
  bool isSuccess = true;

  // Method to handle form validation and appointment creation
  Future<void> _makeAppointment(BuildContext context, String uId) async {

    // Clear previous messages
    setState(() {
      statusMessage = null;
    });

    // Check if any of the fields are empty
    if (_patientNameController.text.isEmpty) {
      setState(() {
        statusMessage = "Please enter the patient's name.";
        isSuccess = false;
      });
      return;
    }

    if (_phoneNumberController.text.isEmpty) {
      setState(() {
        statusMessage = "Please enter the patient's phone number.";
        isSuccess = false;
      });
      return;
    }

    if (_ageController.text.isEmpty) {
      setState(() {
        statusMessage = "Please enter the patient's age.";
        isSuccess = false;
      });
      return;
    }

    try {
      // Create appointment
      await AppointmentService().addAppointment(
        _patientNameController.text,
        _phoneNumberController.text,
        int.parse(_ageController.text),
        _selectedDoctor!,
        _reasonController.text,
        _selectedDate,
        uId,
      );

      // Clear fields after submission
      _patientNameController.clear();
      _phoneNumberController.clear();
      _ageController.clear();
      _reasonController.clear();

      setState(() {
        statusMessage = "Appointment booked successfully!";
        isSuccess = true;
      });

      // // Show payment dialog after making the appointment
      // _showPaymentDialog(context);
    } catch (error) {
      print('Failed to make appointment: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to make an appointment. Please try again.')),
      );
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    _patientNameController.dispose();
    _phoneNumberController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        backgroundColor: mainWhite,
        title: const Text('Make Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onDateChanged: (DateTime selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                },
              ),
              const SizedBox(height: 10),
              DoctorDropdown(
                doctors: _doctors,
                onDoctorSelected: _handleDoctorSelection,
              ),
              const SizedBox(height: 20),
              Text(
                _selectedDoctor == null
                    ? "No doctor selected"
                    : "Selected Doctor: $_selectedDoctor",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Patient Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Form(
                child: Column(
                  children: [
                    // Show the status message if available
                    if (statusMessage != null)
                      StatusBanner(
                        message: statusMessage,
                        isSuccess: isSuccess,
                      ),
                    SizedBox(height: 7,),
                    TextInputField(
                      controller: _patientNameController,
                      hintText: "Full Name *",
                      inputKeyboardType: TextInputType.text,
                      isPassword: false,
                    ),
                    const SizedBox(height: 20),
                    TextInputField(
                      controller: _phoneNumberController,
                      hintText: "Phone Number *",
                      inputKeyboardType: TextInputType.number,
                      isPassword: false,
                    ),
                    const SizedBox(height: 20),
                    TextInputField(
                      controller: _ageController,
                      hintText: "Age *",
                      inputKeyboardType: TextInputType.number,
                      isPassword: false,
                    ),
                    const SizedBox(height: 20),
                    TextInputField(
                      controller: _reasonController,
                      hintText: "Symptoms/Reason for Appointment",
                      inputKeyboardType: TextInputType.text,
                      isPassword: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              FutureBuilder<UserModel>(
                future: _userData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Text("Error fetching user data");
                  }

                  final user = snapshot.data!;
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                        foregroundColor: MaterialStatePropertyAll(bgBlack),
                      ),
                      onPressed: () => _makeAppointment(context, user.uid),
                      child: const Text('Make Appointment'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Today Appointments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // FutureBuilder<UserModel>(
              //   future: _userData,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //     if (snapshot.hasError || !snapshot.hasData) {
              //       return const Text("Error fetching user data");
              //     }
              //
              //     final user = snapshot.data!;
              //     return StreamBuilder<List<AppointmentModel>>(
              //       stream: AppointmentService().getAppointmentsWhere(
              //         field: 'uId',
              //         isEqualTo: user.uid,
              //       ),
              //       builder: (context, snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return const Center(child: CircularProgressIndicator());
              //         } else if (snapshot.hasError) {
              //           return const Center(child: Text("Error Loading Appointments"));
              //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //           return const Center(child: Text("No Previous Appointments"));
              //         } else {
              //           final List<AppointmentModel> appointments = snapshot.data!;
              //           return PreviousAppointments(previousAppointments: appointments,isAdmin: false,);
              //         }
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}