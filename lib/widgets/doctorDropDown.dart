import 'package:flutter/material.dart';

class DoctorDropdown extends StatefulWidget {
  final List<String> doctors; // List of doctors passed to the widget
  final Function(String?) onDoctorSelected; // Callback to pass the selected doctor

  const DoctorDropdown({
    super.key,
    required this.doctors,
    required this.onDoctorSelected,
  });

  @override
  _DoctorDropdownState createState() => _DoctorDropdownState();
}

class _DoctorDropdownState extends State<DoctorDropdown> {
  String? _selectedDoctor; // Stores the selected doctor

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedDoctor,
      decoration: const InputDecoration(
        labelText: "Select Doctor",
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
          _selectedDoctor = newValue; // Update the selected doctor locally
        });
        widget.onDoctorSelected(newValue); // Pass the selected doctor back via the callback
      },
      hint: const Text("Select Doctor"),
    );
  }
}
