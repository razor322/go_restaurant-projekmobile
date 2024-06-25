import 'package:flutter/material.dart';
import 'package:go_restoran/screen/recipe/add_recipe_page.dart';
import 'package:go_restoran/screen/recipe/list_myrecipe_page.dart';
import 'package:go_restoran/screen/user/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilUser extends StatefulWidget {
  @override
  State<ProfilUser> createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUser> {
  String? id, username, email;

  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
    updateProfile();
  }

  void updateProfile() {
    getSession(); // Panggil kembali fungsi getSession untuk memperbarui data
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      email = pref.getString("email") ?? '';
      print('id $id');
      print('username  $username');
      print('email  $email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddRecipePage()));
          },
          // shape: ,
          backgroundColor: Colors.blue.shade100,
          child: Icon(Icons.add)),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Stack for profile picture and edit icon

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: Colors.red.shade400,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.0),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 80.0,
                        ),
                        // Button to change profile picture
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.camera_alt, color: Colors.black),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0),

                    // User information
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "$username",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                "$email",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Space between user information and buttons
                    SizedBox(height: 120.0),

                    Container(
                      width: 350, // Lebar tombol
                      height: 60, // Tinggi tombol

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SettingsPage()), // Log out userr
                          ); // Add your logout logic here
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.amber), // Background color
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Text color
                        ),
                        child: Text(
                          'Settings',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350, // Lebar tombol
                      height: 60, // Tinggi tombol

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ListMyRecipePage()), // Log out userr
                          ); // Add your logout logic here
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.amber), // Background color
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Text color
                        ),
                        child: Text(
                          'My Recipes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
