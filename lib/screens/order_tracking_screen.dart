import 'package:flutter/material.dart';
import 'package:flutter_application_1/common_widget/print_hub_app_bar.dart';
import 'package:flutter_application_1/common_widget/print_hub_gradient_button.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Static but structured dynamic data
    final List<OrderStepData> orderSteps = [
      OrderStepData(
        icon: Icons.check_circle,
        iconColor: Colors.green,
        title: 'Order Confirmed',
        subtitle: 'March 14, 2024 9:00 AM',
      ),
      OrderStepData(
        icon: Icons.local_print_shop_outlined,
        iconColor: Colors.indigo,
        title: 'Package Processing',
        subtitle: 'March 14, 2024 2:30 PM',
      ),
      OrderStepData(
        icon: Icons.local_shipping_outlined,
        iconColor: Colors.blueGrey,
        title: 'In Transit',
        subtitle: 'Estimated: March 15, 2024',
      ),
      OrderStepData(
        icon: Icons.home,
        iconColor: Colors.black,
        title: 'Delivery',
        subtitle: 'Expected: March 15, 2024',
      ),
    ];

    final String deliveryAddress =
        '123 Main Street, Apt 4B, New York, NY 10001';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFB),
      appBar: const PrintHubAppBar(showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.local_shipping, size: 40),
            const SizedBox(height: 8),
            const Text(
              'Track Your Order',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Number',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('#ORD-2024-0001', style: TextStyle(color: Colors.grey[800])),
            const SizedBox(height: 24),

            // Order Status Timeline (dynamic)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                children:
                    orderSteps
                        .map(
                          (step) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                              left: 20,
                              top: 10,
                            ),
                            child: OrderStep(
                              icon: step.icon,
                              iconColor: step.iconColor,
                              title: step.title,
                              subtitle: step.subtitle,
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Delivery Address (dynamic)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Delivery Address',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deliveryAddress,
                    style: TextStyle(color: Colors.grey[800]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
         width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GradientButton(
            text: "Contact Support",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Support coming soon!")),
              );
            },
          ),
        ),
      ),
    );
  }
}

class OrderStep extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const OrderStep({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          fit: FlexFit.tight,
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: Colors.grey[800])),
            ],
          ),
        ),
      ],
    );
  }
}

// Data model class
class OrderStepData {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  OrderStepData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
}
