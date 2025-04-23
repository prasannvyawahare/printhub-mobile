import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/otp_verification_screen.dart';
import 'package:get/get.dart';
import '../common_widget/print_hub_gradient_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(238, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset(
              'assets/images/print_hub_logo.png',
              height: 25,
              width: 25,
            ),
            const SizedBox(width: 8),
            Text(
              "PrintHub",
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 250, 247, 247),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 140),
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                          decoration: TextDecoration.none,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'poppins',
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Fill in the details below to get started",
                                  style: TextStyle(
                                    // fontSize: 12,
                                    // color: Colors.grey,
                                    //  fontWeight: FontWeight.bold,
                                    fontFamily: 'poppins',
                                  ),
                                ),
                                SizedBox(height: 14),
                                _buildLabel("Full Name"),
                                SizedBox(height: 6),
                                _buildTextField(
                                  _nameController,
                                  "Enter your name",
                                ),
                                SizedBox(height: 14),
                                _buildLabel("Mobile Number"),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      height: 55,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(child: Text("+91")),
                                    ),
                                    SizedBox(width: 3),
                                    Expanded(
                                      child: TextField(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          hintText: "Enter mobile number",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14),
                                _buildLabel("Email"),
                                SizedBox(height: 6),
                                _buildTextField(
                                  _emailController,
                                  "Enter your email",
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: TextStyle(fontFamily: 'poppins'),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.offAll(LoginScreen());
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'poppins',
                                        ),
                                      ),
                                    ),
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
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      child: GradientButton(
                        text: "Register",
                        onPressed: () {
                          // Add your registration logic here
                          String name = _nameController.text.trim();
                          String phone = _phoneController.text.trim();
                          String email = _emailController.text.trim();

                          if (name.isEmpty ||
                              phone.length != 10 ||
                              email.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Please fill all fields correctly.",
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          // Navigate or show success message
                          Get.snackbar(
                            "Success",
                            "Registered Successfully!",
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                          Get.to(OtpVerificationScreen());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
