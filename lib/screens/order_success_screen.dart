import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/bottom_navigation_bar.dart';
import 'package:flutter_application_1/screens/order_details_screen.dart';
import 'package:flutter_application_1/screens/order_tracking_screen.dart';
import 'package:get/get.dart';
import '../common_widget/print_hub_gradient_button.dart';
import '../common_widget/print_hub_app_bar.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFB),
      appBar: const PrintHubAppBar(showBackButton: true),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 16),
              const Text(
                'Order Placed Successfully!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your order has been confirmed',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                elevation: 6,

                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        InfoRow(title: 'Order Number', value: '#ORD-2024-0001'),
                        SizedBox(height: 12),
                        InfoRow(
                          title: 'Estimated Delivery',
                          value: 'March 15, 2024',
                        ),
                        SizedBox(height: 12),
                        InfoRow(
                          title: 'Delivery Address',
                          value: '123 Main Street, Apt 4B\nNew York, NY 10001',
                        ),
                        SizedBox(height: 12),
                        InfoRow(
                          title: 'Payment Method',
                          value: 'Credit Card ending in 1234',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GradientButton(
                text: 'Track Order',
                onPressed: () {
                  Get.to(OrderTrackingScreen());
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                   Get.to(OrderDetailsScreen());
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF6C63FF)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ), 
                  ),
                ),
                child: const Center(
                  child: Text(
                    'View Order Details',
                    style: TextStyle(
                      color: Color(0xFF6C63FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
         width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GradientButton(text: "Back to Home", onPressed: () {
            Get.to(BottomNavigationBarScreen());
          }),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }
}
