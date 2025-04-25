import 'package:flutter/material.dart';
import 'package:flutter_application_1/common_widget/print_hub_app_bar.dart';
import 'package:flutter_application_1/common_widget/print_hub_gradient_button.dart';
import 'package:flutter_application_1/screens/bottom_navigation_bar.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFB),
      appBar: const PrintHubAppBar(showBackButton: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.local_print_shop, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Order Details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Order Number',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '#ORD-2024-0001',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Divider(height: 32),

                    const Text(
                      'Order Status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.local_shipping, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'In Transit',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    const Divider(height: 32),

                    const Text(
                      'Items',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          // fit: FlexFit.tight,
                          flex: 1,
                          child: Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey.shade300,
                            child: const Center(child: Text('80 × 80')),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Flexible(
                          // fit: FlexFit.tight,
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'A4 Color Print',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Double-sided, 100 pages',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$25.00',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),

                    const Text(
                      'Delivery Address',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '123 Main Street, Apt 4B, New York, NY 10001',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(height: 32),

                    const Text(
                      'Payment Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Credit Card ending in 1234',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text('Subtotal'), Text('\$25.00')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text('Delivery Fee'), Text('\$5.00')],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$30.00',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(height: 32),

                    const Text(
                      'Estimated Delivery',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'March 15, 2024',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GradientButton(text: "Back To Home", onPressed: () {
            Get.to(BottomNavigationBarScreen());
          }),
        ),
      ),
    );
  }
}
