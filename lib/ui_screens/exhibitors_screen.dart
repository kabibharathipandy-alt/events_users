import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/color.dart';

class ExhibitorsScreen extends StatelessWidget {
  const ExhibitorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveLayout.isDesktop(context) ? 3 : (ResponsiveLayout.isTablet(context) ? 2 : 1);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          color: AppColor.white,
          child: Column(
            children: [
              Expanded(
                child: Container(color: Colors.grey.shade200, alignment: Alignment.center, child: const Text('Booth Banner')),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Exhibitor Company', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ],
          ),
        );
      },
    );
  }
}
