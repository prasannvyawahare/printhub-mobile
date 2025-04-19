import 'package:flutter/material.dart';
import '../common_widget/print_hub_gradient_button.dart';
import 'package:flutter_application_1/screens/otp_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration(seconds: 3),(){

    //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF0F9FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        shadowColor: Colors.black,

        title: Row(
          children: [
            Text(
              "PrintHub",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 20,
                fontFamily: 'poppins',
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
        color: const Color.fromARGB(255, 247, 243, 243),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to PrintHub",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 40,
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
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Enter your mobile number to continue",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Mobile Number",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              SizedBox(height: 14),
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
                                  SizedBox(width: 2),
                                  Expanded(
                                    child: TextField(
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
                              // SizedBox(height: 20),
                              // GradientButton(
                              //   text: "Get OTP",
                              //   onPressed: () {
                              //     // Your onPressed logic here
                              //   },
                              // ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?  ",
                                    style: TextStyle(fontFamily: 'poppins'),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Register",
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
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 15,
                        left: 15,
                        right: 15,
                        top: 15,
                      ),
                      child: GradientButton(
                        text: "Continue",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OtpVerificationScreen(),
                            ),
                          );
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
}
