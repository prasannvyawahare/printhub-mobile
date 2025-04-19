import 'package:flutter/material.dart';
import '../common_widget/print_hub_gradient_button.dart';

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
                      "OTP Verification",
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
                          // Your onPressed logic here
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
