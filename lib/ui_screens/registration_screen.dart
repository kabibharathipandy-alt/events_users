import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/color.dart';
import 'package:go_router/go_router.dart';

class RegistrationScreen extends StatefulWidget {
  final String eventId;
  const RegistrationScreen({super.key, required this.eventId});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isAttending = true;
  String _referral = 'Yes';
  String? _howDidYouKnow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary, // Green from screenshot
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IAP CHENNAI : An Investor Education & Awareness Initiative',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 12, color: Colors.black),
                SizedBox(width: 4),
                Text('May 30, 2026', style: TextStyle(fontSize: 12)),
                SizedBox(width: 16),
                Icon(Icons.location_on, size: 12, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  'Chennai, Tamil Nadu - India',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildBreadcrumbs(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child:
                  ResponsiveLayout.isMobile(context) ||
                      ResponsiveLayout.isTablet(context)
                  ? Column(
                      children: [
                        _buildOrderSummary(),
                        const SizedBox(height: 24),
                        _buildForm(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildForm()),
                        const SizedBox(width: 32),
                        Expanded(flex: 1, child: _buildOrderSummary()),
                      ],
                    ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: const Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 16),
          SizedBox(width: 8),
          Text(
            'Register Here',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 8),
          Icon(Icons.chevron_right, color: Colors.grey, size: 16),
          SizedBox(width: 8),
          Icon(Icons.check_circle, color: Colors.black, size: 16),
          SizedBox(width: 8),
          Text(
            'Share details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Icon(Icons.chevron_right, color: Colors.grey, size: 16),
          SizedBox(width: 8),
          Icon(Icons.circle_outlined, color: Colors.grey, size: 16),
          SizedBox(width: 8),
          Text('Complete Registration', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Purchaser and attendee information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isAttending,
                    onChanged: (val) =>
                        setState(() => _isAttending = val ?? false),
                  ),
                  const Text('I am attending'),
                ],
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            children: [
              Expanded(
                child: _buildTextField('First name *', 'Enter your first name'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField('Last name', 'Enter your last name'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Email *', 'Enter your email address'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mobile *',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border(
                                right: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Text('🇮🇳 +91'),
                                Icon(Icons.arrow_drop_down, size: 16),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter your mobile number',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField('District *', ''),
          const SizedBox(height: 24),
          const Text(
            'How did you come to know about our event? *',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _howDidYouKnow,
                items: ['Social Media', 'Friend', 'Website']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _howDidYouKnow = val),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Would like to refer your friends about this event? *',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Radio(
                value: 'Yes',
                groupValue: _referral,
                onChanged: (val) => setState(() => _referral = val.toString()),
              ),
              const Text('Yes'),
              const SizedBox(width: 16),
              Radio(
                value: 'No',
                groupValue: _referral,
                onChanged: (val) => setState(() => _referral = val.toString()),
              ),
              const Text('No'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Yes, we can use these details for registration. Next time, when the user applies again, the form can be auto-filled directly. The user only needs to check the details and click the Submit button, without filling the entire form again.',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _isAttending,
                    onChanged: (val) =>
                        setState(() => _isAttending = val ?? false),
                  ),
                  const Text('Yes'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      color: const Color(0xFFF0F2F5),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your order',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 32),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Registration details',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                'Particulars',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Divider(height: 32),
          const Text(
            'IAP CHENNAI',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('x 1'),
              Text(
                'Investor Education Initiative',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Divider(height: 32),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total\n1 ticket'),
              Text(
                'Investor Education Initiative',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '*No cancellation policy: Order cancellation not allowed.',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          // Complete registration
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: const Text(
          'CONTINUE',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
