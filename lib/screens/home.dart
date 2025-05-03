import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_details_screen.dart';
import 'package:flutter_application_1/screens/order_status_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import '../common_widget/print_hub_gradient_button.dart';
import '../common_widget/print_hub_app_bar.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFB),
      appBar: const PrintHubAppBar(),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 157, 83, 170),
                    const Color.fromARGB(255, 7, 107, 189),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Get 20% off on your first color print order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'poppins',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            GridView.count(
              controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                featureTile(
                  "Quick Print",
                  "Print your documents in minutes",
                  Icons.flash_on,
                  Colors.amber,
                ),
                featureTile(
                  "Fast Delivery",
                  "Same day delivery available",
                  Icons.local_shipping,
                  Colors.green,
                ),
                featureTile(
                  "Secure Printing",
                  "Your files are safe with us",
                  Icons.lock,
                  Colors.blue,
                ),
                featureTile(
                  "High Quality",
                  "Premium quality prints",
                  Icons.star,
                  Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
               decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 0.6),
          ],
        ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Our Services",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
              
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          serviceTile("Document Print", "From Rs 0.10/page", Icons.description, Colors.blue,),
                          serviceTile("Photo Print", "From Rs 2.00/photo", Icons.photo, Colors.purple,),
                          serviceTile("Banner Print", "From Rs 15.00/ft", Icons.rectangle_outlined, Colors.green,),
                        ],
                      ),
                    ),
                    Divider(height: 32,),
                    const SizedBox(height: 8),
                    GridView.count(
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        tile(
                          "Xerox Print",
                          "From Rs 0.05/page",
                          Icons.copy,
                          Colors.blue.shade500,
                        ),
                        tile(
                          "Color Print",
                          "From Rs 0.25/page",
                          Icons.color_lens,
                          Colors.pink.shade500,
                        ),
                        tile(
                          "Laser Print",
                          "From Rs 0.15/page",
                          Icons.print,
                          Colors.purple.shade500,
                        ),
                        tile(
                          "Jumbo Print",
                          "From Rs 2.00/sq.ft",
                          Icons.crop_free,
                          Colors.green.shade500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 16),
            // Text(
            //   "Popular Services",
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'poppins',
            //   ),
            // ),
            // SizedBox(height: 0),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       Card(
            //         margin: const EdgeInsets.symmetric(
            //           horizontal: 5,
            //           vertical: 12,
            //         ),
            //         color: Colors.white,
            //         elevation: 6,
            //         child: serviceTile("Document Print", "From Rs 0.10/page"),
            //       ),
            //       Card(
            //         margin: const EdgeInsets.symmetric(
            //           horizontal: 5,
            //           vertical: 12,
            //         ),
            //         color: Colors.white,
            //         elevation: 6,
            //         child: serviceTile("Photo Print", "From Rs 2.00/photo"),
            //       ),
            //       Card(
            //         margin: const EdgeInsets.symmetric(
            //           horizontal: 5,
            //           vertical: 12,
            //         ),
            //         color: Colors.white,
            //         elevation: 6,
            //         child: serviceTile("Banner Print", "From Rs 15.00/ft"),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 8),
            // GridView.count(
            //   controller: ScrollController(keepScrollOffset: false),
            //   shrinkWrap: true,
            //   crossAxisCount: 2,
            //   childAspectRatio: 1.7,
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            //   children: [
            //     tile(
            //       "Xerox Print",
            //       "From Rs 0.05/page",
            //       Icons.copy,
            //       Colors.blue.shade500,
            //     ),
            //     tile(
            //       "Color Print",
            //       "From Rs 0.25/page",
            //       Icons.color_lens,
            //       Colors.pink.shade500,
            //     ),
            //     tile(
            //       "Laser Print",
            //       "From Rs 0.15/page",
            //       Icons.print,
            //       Colors.purple.shade500,
            //     ),
            //     tile(
            //       "Jumbo Print",
            //       "From Rs 2.00/sq.ft",
            //       Icons.crop_free,
            //       Colors.green.shade500,
            //     ),
            //   ],
            // ),
            // SizedBox(height: 8),
            // Card(
            //   color: Colors.white,
            //   elevation: 5,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: SizedBox(
            //       width: 366.0,

            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "Quick Price Calculator",
            //             style: TextStyle(
            //               fontSize: 16,
            //               fontWeight: FontWeight.bold,
            //               fontFamily: 'poppins',
            //             ),
            //           ),
            //           SizedBox(height: 8),
            //           Text(
            //             "Print Type",
            //             style: TextStyle(
            //               fontSize: 14,
            //               fontWeight: FontWeight.w500,
            //               fontFamily: 'poppins',
            //             ),
            //           ),
            //           SizedBox(height: 8),
            //           DropdownButtonFormField(
            //             decoration: InputDecoration(
            //               fillColor: Colors.white,
            //               border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(10.0),
            //               ),
            //             ),
            //             borderRadius: BorderRadius.circular(10),
            //             focusColor: Colors.white,
            //             items:
            //                 ["Document Print", "Photo Print", "Banner Print"]
            //                     .map(
            //                       (e) => DropdownMenuItem(
            //                         value: e,
            //                         child: Text(e),
            //                       ),
            //                     )
            //                     .toList(),
            //             hint: Text("Select print type"),
            //             onChanged: (value) {},
            //           ),
            //           SizedBox(height: 8),
            //           Text(
            //             "Quantity",
            //             style: TextStyle(
            //               fontSize: 14,
            //               fontWeight: FontWeight.w500,
            //               fontFamily: 'poppins',
            //             ),
            //           ),
            //           SizedBox(height: 8),
            //           TextField(
            //             decoration: InputDecoration(
            //               border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(10.0),
            //               ),
            //               hintText: 'Enter number of pages',
            //             ),
            //           ),
            //           SizedBox(height:20),
            //           Center(
            //             child: GradientButton(
            //               text: "Get Quick Price",
            //               onPressed: () {
            //                 // Your onPressed logic here
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 366.0,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Active Orders",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppins',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(OrderStatusScreen());
                                },
                                child: Text('View All'),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget featureTile(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          // SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 3),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget serviceTile(String title, String price, IconData icon, Color color,) {
    return GestureDetector(
      onTap: () => Get.to(HomeDetailsScreen()),
      child: Container(
        width: 130,
        height: 100,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 0.6),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontFamily: 'poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tile(String title, String subtitle, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => Get.to(HomeDetailsScreen()),
      child: Container(
        width: 160,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // ignore: deprecated_member_use
          color: color.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ignore: deprecated_member_use
            Icon(icon, color: color.withOpacity(0.8), size: 27),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3),
            Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
