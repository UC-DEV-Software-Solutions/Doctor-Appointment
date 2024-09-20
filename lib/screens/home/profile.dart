import 'package:firebase_testing/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_testing/models/UserModel.dart';

import '../../services/auth.dart';
import '../extra/extraCollection.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserModel> _userData; // To store the future user data

  @override
  void initState() {
    super.initState();
    _userData = AuthServices().getCurrentUser(); // Fetch user data on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Replace mainWhite with a valid color
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Extracollection()), // Navigate to another screen
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: FutureBuilder<UserModel>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          // } else if (snapshot.hasError) {
          //   return const Center(child: Text('Error loading profile data'));
          } else if (snapshot.hasData) {
            UserModel? user = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Profile Picture
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user?.profilePic ?? 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1631&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // User Name
                    Text(
                      user?.userName ?? 'Username',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // User Email
                    Text(
                      user?.email ?? 'Email',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Edit Profile Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // to edit profile page
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50), // Full-width button
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Logout Button
                    OutlinedButton.icon(
                      onPressed: () async {
                        await AuthServices().signOut(); // Perform logout
                        // Go back to previous screen
                        // Navigate to SignIn page after successful logout
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Wrapper(), // Replace with your SignIn page widget
                          ),
                        );
                      },

                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50), // Full-width button
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          else {
            return const Center(child: Text('No profile data available'));
          }
        },
      ),
    );
  }
}


//   Scaffold(
//   backgroundColor: mainWhite,
//   appBar: AppBar(
//   title: const Text('Profile'),
//   // backgroundColor: Colors.blueAccent,
//   elevation: 0,
//   actions: [
//   IconButton(
//   onPressed: () {
//   Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => const Extracollection()),
//   );
//   },
//   icon: const Icon(Icons.settings),
//   ),
//   ],
//   ),
//   body: SingleChildScrollView(
//   child: Padding(
//   padding: const EdgeInsets.all(16.0),
//   child: Column(
//   children: [
//   // Profile Picture
//   Center(
//   child: CircleAvatar(
//   radius: 60,
//   backgroundImage: NetworkImage(
//   'https://via.placeholder.com/150'), // Replace with actual image URL
//   ),
//   ),
//   const SizedBox(height: 20),
//
//   // User Name
//   const Text(
//   'John Doe', // Replace with dynamic user data
//   style: TextStyle(
//   fontSize: 24,
//   fontWeight: FontWeight.bold,
//   ),
//   ),
//   const SizedBox(height: 8),
//
//   // User Email
//   const Text(
//   'johndoe@example.com', // Replace with dynamic user data
//   style: TextStyle(
//   fontSize: 16,
//   color: Colors.grey,
//   ),
//   ),
//   const SizedBox(height: 20),
//
//   // Edit Profile Button
//   ElevatedButton.icon(
//   onPressed: () {
//   // Navigate to edit profile page
//   },
//   icon: const Icon(Icons.edit),
//   label: const Text('Edit Profile'),
//   style: ElevatedButton.styleFrom(
//   minimumSize: const Size(double.infinity, 50), // Full width button
//   ),
//   ),
//   const SizedBox(height: 10),
//
//   // Logout Button
//   OutlinedButton.icon(
//   onPressed: () {
//   // Perform logout action
//   },
//   icon: const Icon(Icons.logout),
//   label: const Text('Logout'),
//   style: OutlinedButton.styleFrom(
//   minimumSize: const Size(double.infinity, 50), // Full width button
//   ),
//   ),
//   ],
//   ),
//   ),
//   ),
//   );
// }
// }
