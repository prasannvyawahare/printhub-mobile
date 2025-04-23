import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ripple_wave/ripple_wave.dart';
import '../common_widget/print_hub_gradient_button.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:get/get_navigation/get_navigation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Welcome to PrintHub',
      'subtitle': 'Your One-Stop Print Service Solution',
      'icon': Icons.print,
      'footer': 'Loading...',
    },
    {
      'title': 'High Quality Printing',
      'subtitle':
          'Experience premium quality printing services with our state-of-the-art technology',
      'icon': Icons.check,
      'footer': 'Professional Print Quality',
    },
    {
      'title': 'Track Your Order',
      'subtitle': 'Monitor your print order status in real-time',
      'icon': Icons.local_shipping,
      'footer': 'Searching for orders...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double value = 1.0;
              if (_controller.position.haveDimensions) {
                value = _controller.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              }

              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(50 * (1 - value), 0),
                  child: OnboardingPage(
                    controller: _controller,
                    isLastPage: index == pages.length - 1,
                    title: pages[index]['title'],
                    subtitle: pages[index]['subtitle'],
                    icon: pages[index]['icon'],
                    footer: pages[index]['footer'],
                    showButton: index == pages.length - 1,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String footer;
  final bool showButton;
  final PageController? controller;
  final bool isLastPage;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.footer,
    this.showButton = false,
    this.controller,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 244, 247, 248),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                      color: Color(0xFF573FBC),
                      fontFamily: 'poppins',
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.1,
                        color: Color.fromARGB(255, 37, 37, 37),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: RippleWave(
                      color: Colors.deepPurple,
                      waveCount: 3,
                      repeat: true,
                      child: Container(
                        padding: const EdgeInsets.all(60),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFFAA88FF), Color(0xFF7666FF)],
                          ),
                        ),
                        child: Icon(icon, size: 64, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Text(
                    footer,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16.0, right: 16.0),
                child: isLastPage
                    ? showButton
                        ? GradientButton(
                            text: "Start Printing",
                            onPressed: () {
                              Get.offAll(LoginScreen(),
                              );
                            },
                          )
                        : const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          controller?.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFFAA88FF), Color(0xFF7666FF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
