import 'package:flutter/material.dart';
import '../widgets/color.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          color: AppColor.white,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text('Session ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('10:00 AM - 11:00 AM | Room A\nDiscussing the future of tech.'),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
