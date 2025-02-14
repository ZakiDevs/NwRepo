import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _selectedImage;

  Future<void> _pickImageFromCamera() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() => _selectedImage = File(pickedFile.path));
      }
    } catch (e) {
      // Handle error
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0e9b24), Color(0xFF27ae60)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child:
                    Image.asset("assets/logo.png", height: 50), // Add your logo
              ),

              const Spacer(),

              // Drone Button
              GestureDetector(
                onTap: _pickImageFromCamera,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Image.asset("assets/drone_icon.png",
                          width: 120), // Drone image
                    ),
                    const SizedBox(height: 10),
                    const Text("Tap to Scan",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Show selected image (if any)
              _selectedImage != null
                  ? Image.file(_selectedImage!, height: 200)
                  : const SizedBox(),

              const Spacer(),

              // Bottom Navigation
              BottomNavigationBar(
                backgroundColor: Colors.black.withOpacity(0.2),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.flight, color: Colors.white),
                      label: "Drive"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.image, color: Colors.white),
                      label: "Media"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.warning, color: Colors.white),
                      label: "Alerts"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.location_on, color: Colors.white),
                      label: "Location"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
