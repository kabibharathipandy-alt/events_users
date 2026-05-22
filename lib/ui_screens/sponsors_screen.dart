import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/color.dart';

class SponsorsScreen extends StatelessWidget {
  const SponsorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Text('Platinum Sponsors', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.textPrimary)),
          const SizedBox(height: 24),
          _buildSponsorGrid(context, 2),
          const SizedBox(height: 48),
          const Text('Gold Sponsors', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.textPrimary)),
          const SizedBox(height: 24),
          _buildSponsorGrid(context, 4),
        ],
      ),
    );
  }

  Widget _buildSponsorGrid(BuildContext context, int count) {
    final crossAxisCount = ResponsiveLayout.isDesktop(context) ? 4 : (ResponsiveLayout.isTablet(context) ? 3 : 2);
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          color: AppColor.white,
          child: const Center(
            child: Text('Logo', style: TextStyle(color: Colors.grey, fontSize: 24)),
          ),
        );
      },
    );
  }
}
