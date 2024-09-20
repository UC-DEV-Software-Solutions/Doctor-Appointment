import 'package:firebase_testing/constants/colours.dart';
import 'package:firebase_testing/screens/doctor/addingDoctor.dart';
import 'package:flutter/material.dart';

import '../appointmentList.dart';

class Extracollection extends StatefulWidget {
  const Extracollection({super.key});

  @override
  State<Extracollection> createState() => _ExtracollectionState();
}

class _ExtracollectionState extends State<Extracollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: mainWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Doctor CRUD",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text("Add Doctor"),
              leading: const Icon(Icons.add),
              onTap: () {
                showDialog(
                      context: context,
                      builder: (context) => const Addingdoctor(),
                    );
              },
            ),
            ListTile(
              title: const Text("Edit Doctor"),
              leading: const Icon(Icons.edit),
              onTap: () {
                // Handle option 1 tap
              },
            ),
            ListTile(
              title: const Text("Delete & Reset"),
              leading: const Icon(Icons.delete),
              onTap: () {
                // Handle option 2 tap

                // showDialog(
                //   context: context,
                //   builder: (context) => DeleteAllConfirmation(),
                // );
              },
            ),
            const Divider(),
            const Text(
              "Appointments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text("Appointment List"),
              leading: const Icon(Icons.font_download),
              onTap: () {
                // Handle font size tap
                showDialog(
                  context: context,
                  builder: (context) => const AppointmentList(),
                );
              },
            ),

            const Divider(),
            ListTile(
              title: const Text("Font Size"),
              leading: const Icon(Icons.font_download),
              onTap: () {
                // Handle font size tap
                // showDialog(
                //   context: context,
                //   builder: (context) => FontSizeChanger(),
                // );
              },
            ),
            ListTile(
              title: const Text("Dark Mode"),
              leading: const Icon(Icons.light),
              trailing: Switch(
                value: false, // Replace with your logic for dark mode
                onChanged: (value) {
                  // Handle dark mode switch
                },
              ),
            ),
            ListTile(
              title: const Text("Font Size"),
              leading: const Icon(Icons.font_download),
              onTap: () {
                // Handle font size tap
                // showDialog(
                //   context: context,
                //   builder: (context) => FontSizeChanger(),
                // );
              },
            ),
            const Divider(),
            const Text(
              "Application",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text("Like Expense Tracker"),
              leading: const Icon(Icons.thumb_up_sharp),
              // trailing: Switch(
              //   value: false, // Replace with your logic for dark mode
              //   onChanged: (value) {
              //     // Handle dark mode switch
              //   },
              // ),
            ),
            ListTile(
              title: const Text("Feedback"),
              leading: const Icon(Icons.mail),
              onTap: () {
                // Handle font size tap
              },
            ),
            ListTile(
              title: const Text("Developers"),
              leading: const Icon(Icons.developer_board),
              onTap: () {
                // Handle font size tap
              },
            ),
          ],
        ),
      ),
    );
  }
}