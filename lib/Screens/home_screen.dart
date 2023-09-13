import 'package:blocapi/Screens/product_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ProductScreen();
            }));
          },
          child: const Text(
            "Get Products",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
