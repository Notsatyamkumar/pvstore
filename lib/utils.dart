import 'package:flutter/material.dart';

Widget pvStyleButton(
  String text, {
  Color? color,
  Color? textColor,
  VoidCallback? onPressed,
  double? width = 200.0,
  IconData icon = Icons.check,
}) {
  return GestureDetector(
    onTap: onPressed, // Your button's action
    child: Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 186, 0), // rgb(255, 186, 0)
            Color.fromARGB(255, 255, 108, 0), // rgb(255, 108, 0)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 10), // Add an icon here
          Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

PreferredSize pvAppBar({required String title}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 186, 0), // rgb(255, 186, 0)
            Color.fromARGB(255, 255, 108, 0), // rgb(255, 108, 0)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AppBar(
        title: Text(title),
        backgroundColor:
            Colors.transparent, // Make AppBar background transparent
        elevation: 0, // Remove shadow
      ),
    ),
  );
}

PreferredSize pvAppBarW({required String title}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Container(
      color: Colors.white,
      child: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.jpg', // Path to the logo
              height: 40, // Adjust the height as needed
            ),
            const SizedBox(width: 10), // Add spacing between logo and title
            Text(title),
          ],
        ),
        backgroundColor:
            Colors.transparent, // Make AppBar background transparent
        elevation: 0, // Remove shadow
      ),
    ),
  );
}
