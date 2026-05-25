import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/color.dart';

class MainRegisterScreen extends StatefulWidget {
  const MainRegisterScreen({super.key});

  @override
  State<MainRegisterScreen> createState() => _MainRegisterScreenState();
}

class _MainRegisterScreenState extends State<MainRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dobController = TextEditingController();
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();

  // State Variables
  String _selectedCountryCode = '+91';
  String? _selectedGender;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful!')),
      );
      // context.go('/');
    } else {
      // Form has errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the form before submitting.')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Basic Details'),
                  const SizedBox(height: 16),
                  _buildProfilePhotoPicker(),
                  const SizedBox(height: 24),
                  _buildTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    icon: Icons.person,
                    validator: (val) => val == null || val.length < 3 ? 'Enter a valid full name (min 3 chars)' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Username',
                    icon: Icons.alternate_email,
                    validator: (val) => val == null || val.isEmpty ? 'Username is required' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email ID',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Email is required';
                      final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!regex.hasMatch(val)) return 'Enter a valid email address';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMobileNumberField(),
                  const SizedBox(height: 16),
                  _buildPasswordField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: _obscurePassword,
                    onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
                    validator: (val) => val == null || val.length < 6 ? 'Password must be at least 6 characters' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    obscureText: _obscureConfirmPassword,
                    onToggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Confirm your password';
                      if (val != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),

                  const SizedBox(height: 48),
                  _buildSectionTitle('Personal Details'),
                  const SizedBox(height: 24),
                  
                  _buildTextField(
                    controller: _dobController,
                    label: 'Date of Birth',
                    icon: Icons.calendar_today,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (val) => val == null || val.isEmpty ? 'Date of Birth is required' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      prefixIcon: const Icon(Icons.people),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    value: _selectedGender,
                    items: const [
                      DropdownMenuItem(value: 'Male', child: Text('Male')),
                      DropdownMenuItem(value: 'Female', child: Text('Female')),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (val) => setState(() => _selectedGender = val),
                    validator: (val) => val == null ? 'Please select your gender' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _bioController,
                    label: 'Bio / About Me',
                    icon: Icons.info_outline,
                    maxLines: 3,
                    validator: (val) => val == null || val.isEmpty ? 'Bio is required' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _locationController,
                    label: 'Location / Address',
                    icon: Icons.location_on,
                    validator: (val) => val == null || val.isEmpty ? 'Location is required' : null,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _cityController,
                          label: 'City',
                          icon: Icons.location_city,
                          validator: (val) => val == null || val.isEmpty ? 'City required' : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: _pincodeController,
                          label: 'Pincode',
                          icon: Icons.pin_drop,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Required';
                            if (val.length < 5) return 'Invalid pincode';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('SUBMIT', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.primary)),
        const SizedBox(height: 8),
        Container(height: 2, width: 60, color: AppColor.secondary),
      ],
    );
  }

  Widget _buildProfilePhotoPicker() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.person, size: 50, color: Colors.grey),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColor.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileNumberField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: DropdownButtonFormField<String>(
            value: _selectedCountryCode,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            items: const [
              DropdownMenuItem(value: '+91', child: Text('+91')),
              DropdownMenuItem(value: '+1', child: Text('+1')),
              DropdownMenuItem(value: '+44', child: Text('+44')),
              DropdownMenuItem(value: '+61', child: Text('+61')),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _selectedCountryCode = val);
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildTextField(
            controller: _mobileController,
            label: 'Mobile Number',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Mobile number is required';
              if (val.length < 10) return 'Enter a valid 10-digit number';
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: onToggleVisibility,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: validator,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: validator,
    );
  }
}
