import 'package:flutter/material.dart';

class DoctorDropdown extends StatefulWidget {
  final List<String> doctors; // List of doctors passed to the widget
  final Function(String?) onDoctorSelected; // Callback to pass the selected doctor
  final String? selectedDoctor;

  const DoctorDropdown({
    Key? key,
    required this.doctors,
    required this.onDoctorSelected,
    this.selectedDoctor,
  }) : super(key: key);

  @override
  _DoctorDropdownState createState() => _DoctorDropdownState();
}

class _DoctorDropdownState extends State<DoctorDropdown> {
  String? selectedDoctor;

  @override
  void initState() {
    super.initState();
    // Initialize with the passed selectedDoctor from the parent widget
    selectedDoctor = widget.selectedDoctor;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedDoctor ?? (widget.doctors.isNotEmpty ? widget.doctors[0] : null),
      decoration: const InputDecoration(
        labelText: "Select Your Doctor",
        border: OutlineInputBorder(),
      ),
      items: widget.doctors.map((doctor) {
        return DropdownMenuItem<String>(
          value: doctor,
          child: Text(doctor),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedDoctor = newValue; // Update the selected doctor locally
        });
        widget.onDoctorSelected(newValue); // Pass the selected doctor back via the callback
      },
      hint: const Text("Select Doctor"),
    );
  }
}
