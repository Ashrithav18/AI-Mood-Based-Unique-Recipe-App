import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'shared_preference_helper.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
  String? email;
  String? profileImagePath;
  String? coverImagePath;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _errorMessage = "No user logged in";
          _isLoading = false;
        });
        return;
      }

      setState(() {
        name = user.displayName ?? 'No name';
        email = user.email ?? 'No email';
      });

      // Firestore
      _loadFirestoreData(user.uid);

      // SharedPreferences
      _loadImagesFromPreferences();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Error loading profile: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _loadFirestoreData(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        if (data != null) {
          setState(() {
            name = data['name'] ?? name;
            email = data['email'] ?? email;
          });
        }
      }
    } catch (e) {
      debugPrint("Error loading Firestore data: $e");
    }
  }

  Future<void> _loadImagesFromPreferences() async {
    try {
      final savedProfilePath = await SharedPreferenceHelper().getUserImage();
      final savedCoverPath = await SharedPreferenceHelper().getUserCoverImage();

      if (savedProfilePath != null && await File(savedProfilePath).exists()) {
        setState(() => profileImagePath = savedProfilePath);
      }

      if (savedCoverPath != null && await File(savedCoverPath).exists()) {
        setState(() => coverImagePath = savedCoverPath);
      }
    } catch (e) {
      debugPrint("Error loading images: $e");
    }
  }

  Future<void> _pickImage(bool isProfile) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        if (isProfile) {
          await SharedPreferenceHelper().saveUserImage(pickedFile.path);
          setState(() => profileImagePath = pickedFile.path);
        } else {
          await SharedPreferenceHelper().saveUserCoverImage(pickedFile.path);
          setState(() => coverImagePath = pickedFile.path);
        }
      }
    } catch (e) {
      setState(() => _errorMessage = "Failed to pick image: $e");
    }
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () => _pickImage(true),
      child: CircleAvatar(
        radius: 60,
        backgroundImage:
            profileImagePath != null ? FileImage(File(profileImagePath!)) : null,
        child: profileImagePath == null
            ? Icon(Icons.person, size: 60, color: Colors.white)
            : null,
        backgroundColor: Colors.grey,
      ),
    );
  }

  Widget _buildCoverImage() {
    return GestureDetector(
      onTap: () => _pickImage(false),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          image: coverImagePath != null
              ? DecorationImage(
                  image: FileImage(File(coverImagePath!)), fit: BoxFit.cover)
              : null,
        ),
        child: coverImagePath == null
            ? Icon(Icons.image, size: 80, color: Colors.white70)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading profile..."),
                ],
              ),
            )
          : (_errorMessage != null)
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Cover + Profile
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          _buildCoverImage(),
                          Positioned(
                            bottom: -50,
                            child: _buildProfileImage(),
                          ),
                        ],
                      ),

                      SizedBox(height: 60),

                      // User info
                      Text(
                        name ?? 'No name',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        email ?? 'No email',
                        style: TextStyle(color: Colors.grey[700]),
                      ),

                      SizedBox(height: 20),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Edit Profile logic
                            },
                            icon: Icon(Icons.edit),
                            label: Text("Edit Profile"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          SizedBox(width: 10),
                          OutlinedButton.icon(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.logout),
                            label: Text("Logout"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      Divider(),

                      // Example sections like social media
                      ListTile(
                        leading: Icon(Icons.photo),
                        title: Text("Photos"),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.group),
                        title: Text("Friends"),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text("Settings"),
                        onTap: () {},
                      ),
                    ],
                  ),
               ),
);
}
}


