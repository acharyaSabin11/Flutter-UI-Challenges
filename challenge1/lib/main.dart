import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:challenge1/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "CHALLENGE 1",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "-Performed By: Sabin Acharya",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Tap on the menu button to see the animation",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.all(10),
              child: MenuAnimationDemo(),
            ),
          ],
        ),
      ),
    );
  }
}
