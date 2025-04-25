import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/bottom_navigation_bar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../common_widget/print_hub_gradient_button.dart';
import 'package:get/get_navigation/get_navigation.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  int _timerSeconds = 30;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
        _startTimer();
      } else {
        setState(() {
          _isResendEnabled = true;
        });
      }
    });
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 50,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width:1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [],
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 3) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(239, 255, 255, 255),
      appBar: AppBar(
       backgroundColor: Colors.white,
       elevation: 0,
        title: Row(
          children: [
          // Icon(Icons.print, color: Colors.purple),
          
          Image.asset('assets/images/print_hub_logo.png', height: 25, width: 25,),
          const SizedBox(width: 8),
          Text("PrintHub", style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold,)),
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
              padding: const EdgeInsets.only(bottom: 120),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "OTP Verification",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.indigo,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                        decoration: TextDecoration.none,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 50),
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
                                "Enter OTP",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "We have enter verification code to",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  4,
                                  (index) => _buildOtpField(index),
                                ),
                              ),
                              // SizedBox(height: 20),
                              // GradientButton(
                              //   text: "Verify OTP",
                              //   onPressed: () {
                              //     // Your onPressed logic here
                              //   },
                              // ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Didn't receive the code? ",
                                    style: TextStyle(fontFamily: 'poppins'),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Resend",
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'poppins',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                _isResendEnabled
                                    ? 'You can now resend.'
                                    : 'Resend code in $_timerSeconds s',
                                style: TextStyle(color: Colors.grey),
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
                        text: " Verify & Continue",
                        onPressed: () {
                           GetStorage box = GetStorage();
                          box.write("otp_verification_screen_show", true);
                          Get.offAll(BottomNavigationBarScreen());
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
