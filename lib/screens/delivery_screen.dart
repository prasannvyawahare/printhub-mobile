import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/order_success_screen.dart';
import 'package:get/get.dart';
import '../common_widget/print_hub_gradient_button.dart';
import '../common_widget/print_hub_app_bar.dart';


class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  String? _selectedDeliveryOption;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrintHubAppBar(showBackButton: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildDeliveryOptions(),
              const SizedBox(height: 20),
              if (_selectedDeliveryOption == "Deliver to My Location") _buildDeliveryDetailsForm(),
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GradientButton(
          text: "Place Order",
          onPressed: () {
           if (_selectedDeliveryOption == "Deliver to My Location") {
            if (_formKey.currentState?.validate() != true) return;
          }
          Get.to(OrderSuccessScreen());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Order placed for $_selectedDeliveryOption!")),
          );
        },
          
        ),
    ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Card(
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Delivery Option", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
            _buildRadioTile("Pickup from Shop", Icons.store, Colors.green),
           
            _buildRadioTile("Deliver to My Location", Icons.local_shipping, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioTile(String title, IconData icon, Color iconColor) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDeliveryOption = title;
        });
      },
      child: Row(
        children: [
          Radio<String>(
            value: title,
            groupValue: _selectedDeliveryOption,
            onChanged: (value) {
              setState(() {
                _selectedDeliveryOption = value;
              });
            },
          ),
          Icon(icon, size: 24, color: iconColor),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetailsForm() {
    return Card(
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Delivery Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 16),
            const Text("Full Name", style: TextStyle(fontWeight: FontWeight.w500)),
            _buildValidatedTextField(_fullNameController, "Full Name", "Enter your full name"),
            const SizedBox(height: 10),
            const Text("Email Address", style: TextStyle(fontWeight: FontWeight.w500)),
            _buildValidatedTextField(_emailController, "Email Address", "Enter your email", email: true),
            const SizedBox(height: 10),
            const Text("Phone Number", style: TextStyle(fontWeight: FontWeight.w500)),
            _buildValidatedTextField(_phoneController, "Phone Number", "Enter your phone number"),
            const SizedBox(height: 10),
            const Text("Delivery Address", style: TextStyle(fontWeight: FontWeight.w500)),
            _buildValidatedTextField(_addressController, "Delivery Address", "Enter your complete address",  maxLines: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildValidatedTextField(TextEditingController controller, String label, String hint, {int maxLines = 1, bool email = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          if (email && !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
            return 'Enter a valid email address';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  
}
