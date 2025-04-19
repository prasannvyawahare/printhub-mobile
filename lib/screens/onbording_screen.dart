import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ripple_wave/ripple_wave.dart';
import '../common_widget/print_hub_gradient_button.dart';
import 'package:flutter_application_1/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const [
          OnboardingPage(
            title: 'Welcome to PrintHub',
            subtitle: 'Your One-Stop Print Service Solution',
            icon: Icons.print,
            footer: 'Loading...',
          ),
          OnboardingPage(
            title: 'High Quality Printing',
            subtitle:
                'Experience premium quality printing services with our state-of-the-art technology',
            icon: Icons.check,
            footer: 'Professional Print Quality',
          ),
          OnboardingPage(
            title: 'Track Your Order',
            subtitle: 'Monitor your print order status in real-time',
            icon: Icons.local_shipping,
            footer: 'Searching for orders...',
            showButton: true,
          ),
        ],
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

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.footer,
    this.showButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
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
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    showButton
                        ? GradientButton(
                          text: "Start Printing",
                          onPressed: () {
                            GetStorage box = GetStorage();
                            box.write("onbording_screen_show", true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        )
                        : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
