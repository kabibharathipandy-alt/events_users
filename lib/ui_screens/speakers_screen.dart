import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/color.dart';

class SpeakersScreen extends StatelessWidget {
  const SpeakersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveLayout.isDesktop(context) ? 4 : (ResponsiveLayout.isTablet(context) ? 3 : 2);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Card(
          color: AppColor.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(radius: 40, backgroundColor: Colors.grey),
              const SizedBox(height: 16),
              Text('Speaker ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              const Text('CEO, Tech Corp', style: TextStyle(color: AppColor.textSecondary)),
            ],
          ),
        );
      },
    );
  }
}
