import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseOptions extends StatefulWidget {
  const FirebaseOptions({super.key});

  @override
  State<FirebaseOptions> createState() => _State();
}

class _State extends State<FirebaseOptions> {
  int? value = 0;
  String? name;
  double? key;

  @override
  void initState() {
    final Map<String, dynamic> firebaseOptions = {
      "apiKey": "",
      "appId": "",
      "messagingSenderId": "",
      "projectId": "",
      "storageBucket": "",
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Firebase Options'),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Firebase Options',
            ),
          ),
        ],
      ),
    );
  }
}
