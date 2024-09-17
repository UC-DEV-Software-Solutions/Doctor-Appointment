import 'package:flutter/material.dart';

class PreviousAppointments extends StatelessWidget {
  final List<String> previousAppointments;

  const PreviousAppointments({super.key, required this.previousAppointments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Allows ListView inside a ScrollView or small container
      itemCount: previousAppointments.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(previousAppointments[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }
}
