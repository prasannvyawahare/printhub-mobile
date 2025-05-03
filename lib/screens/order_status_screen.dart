import 'package:flutter/material.dart';
import 'package:flutter_application_1/common_widget/print_hub_app_bar.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'delivered':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFB),
      appBar: const  PrintHubAppBar(),
      body: ListView(
        children: [
          _buildOrderCard(
            orderId: "1234",
            status: "In Progress",
            title: "Document Print",
            subtitle: "50 pages",
            price: "₹1875.00",
            progress: 0.75,
          ),
          _buildOrderCard(
            orderId: "1235",
            status: "Pending",
            title: "Photo Print",
            subtitle: "10 photos",
            price: "₹1500.00",
            progress: 0.25,
          ),
          _buildOrderCard(
            orderId: "1236",
            status: "Completed",
            title: "ID Cards",
            subtitle: "100 pieces",
            price: "₹3000.00",
            progress: 1.0,
          ),
          _buildOrderCard(
            orderId: "1237",
            status: "Delivered",
            title: "Booklet",
            subtitle: "5 copies",
            price: "₹1250.00",
            progress: 1.0,
          ),
        ],
      ),
      
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String status,
    required String title,
    required String subtitle,
    required String price,
    required double progress,
  }) {
    final Color statusColor = getStatusColor(status);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order #$orderId',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(status,
                    style: TextStyle(
                        color: statusColor, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            // Image and Info
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: const Center(child: Text("Image")),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(
                            fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(price,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Progress Bar
            LinearProgressIndicator(
              value: progress,
              color: statusColor,
              backgroundColor: Colors.grey[300],
              minHeight: 6,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text('${(progress * 100).toInt()}%'),
            ),
          ],
        ),
      ),
    );
  }

  
}
