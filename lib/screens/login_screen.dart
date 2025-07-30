import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../common_widget/print_hub_gradient_button.dart';
import 'package:flutter_application_1/screens/otp_verification_screen.dart';

import '../controllers/google_sign_in_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInController = Get.put(GoogleSignInController());
    return Scaffold(
      backgroundColor: Color.fromARGB(238, 255, 255, 255),
      appBar: AppBar(
       backgroundColor: Colors.white,
       elevation: 0,
        title: Row(
          children: [
          // Icon(Icons.print, color: Colors.purple),
          const SizedBox(width: 10),
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
              padding: const EdgeInsets.only(bottom: 140),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to PrintHub",
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
                                "Login",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              // SizedBox(height: 8),
                              // Text(
                              //   "Enter your mobile number to continue",
                              //   style: TextStyle(
                              //     fontSize: 12,
                              //     fontWeight: FontWeight.bold,
                              //     fontFamily: 'poppins',
                              //   ),
                              // ),
                              // SizedBox(height: 12),
                              // Text(
                              //   "Mobile Number",
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     fontFamily: 'poppins',
                              //   ),
                              // ),
                              // SizedBox(height: 14),
                              // Row(
                              //   children: [
                              //     Container(
                              //       padding: EdgeInsets.symmetric(
                              //         horizontal: 12,
                              //       ),
                              //       height: 55,
                              //       decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.grey),
                              //         borderRadius: BorderRadius.circular(8),
                              //       ),
                              //       child: Center(child: Text("+91")),
                              //     ),
                              //     SizedBox(width: 2),
                              //     Expanded(
                              //       child: TextField(
                              //         keyboardType: TextInputType.phone,
                              //         decoration: InputDecoration(
                              //           hintText: "Enter mobile number",
                              //           border: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(
                              //               8,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    // onTap: () {
                                    //   //  googleSignInController
                                    //  // .signInWithGoogle();
                                    //   showModalBottomSheet(
                                    //     context: context,
                                    //     backgroundColor:
                                    //     Colors.transparent, // Make the background transparent
                                    //     builder: (BuildContext context) {
                                    //       return Container(
                                    //         color: Colors.transparent,
                                    //         child: Scaffold(
                                    //           backgroundColor: Colors.transparent,
                                    //           bottomNavigationBar: Padding(
                                    //             padding: const EdgeInsets.only(
                                    //                 left: 16, right: 16, bottom: 18),
                                    //             child: Container(
                                    //               height: 324.h,
                                    //               width: 339.w,
                                    //               decoration: BoxDecoration(
                                    //                 borderRadius: BorderRadius.circular(16),
                                    //                 color: Colors.white,
                                    //               ),
                                    //               child: Column(
                                    //                 children: [
                                    //                   39.verticalSpace,
                                    //                   SvgPicture.asset(
                                    //                     "assets/svg/logo_google_sign_in.svg",
                                    //                     height: 34.h,
                                    //                     width: 103.w,
                                    //                   ),
                                    //                   20.verticalSpace,
                                    //                   Row(
                                    //                     children: [
                                    //                       24.horizontalSpace,
                                    //                       Text(
                                    //                         "Continue with Google",
                                    //                         style: TextStyle(
                                    //                             color: Colors.black,
                                    //                             fontSize: 14,
                                    //                             fontWeight: FontWeight.w500),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                   12.verticalSpace,
                                    //                   Row(
                                    //                     children: [
                                    //                       24.horizontalSpace,
                                    //                       Text(
                                    //                         "You’ll be redirected to Google for a secure and\nfaster login. Your name and email will be shared\nwith Triva app.",
                                    //                         style: TextStyle(
                                    //                             color: const Color.fromRGBO(
                                    //                                 98, 100, 101, 1),
                                    //                             fontSize: 12,
                                    //                             fontWeight: FontWeight.w400,
                                    //                             letterSpacing: 1.5),
                                    //                         textAlign: TextAlign.start,
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                   62.verticalSpace,
                                    //                   Padding(
                                    //                     padding: const EdgeInsets.only(
                                    //                         left: 20, right: 20),
                                    //                     child: Row(
                                    //                       mainAxisAlignment:
                                    //                       MainAxisAlignment.center,
                                    //                       children: [
                                    //                         GestureDetector(
                                    //                     onTap: googleSignInController.isLoading.value
                                    //                         ? null
                                    //                         : () {
                                    //                   googleSignInController.signInWithGoogle();
                                    //                   },
                                    //                           child: Container(
                                    //                             height: 60.h,
                                    //                             width: 145.w,
                                    //                             decoration: BoxDecoration(
                                    //                                 borderRadius:
                                    //                                 BorderRadius.circular(12),
                                    //                                 color: Colors.white,
                                    //                                 border: Border.all(
                                    //                                     color: Colors.black,
                                    //                                     width: 1)),
                                    //                             child: Center(
                                    //                               child: Text(
                                    //                                 "Cancel",
                                    //                                 style: TextStyle(
                                    //                                     color: const Color.fromRGBO(
                                    //                                         58, 58, 60, 1),
                                    //                                     fontSize: 16,
                                    //                                     fontWeight:
                                    //                                     FontWeight.w500),
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                         ),
                                    //                         10.horizontalSpace,
                                    //                         Obx(
                                    //                               () => GestureDetector(
                                    //                             onTap: googleSignInController
                                    //                                 .isLoading.value
                                    //                                 ? null
                                    //                                 : () {
                                    //                               googleSignInController
                                    //                                   .signInWithGoogle();
                                    //                             },
                                    //                             child: Container(
                                    //                               height: 60.h,
                                    //                               width: 145.w,
                                    //                               decoration: BoxDecoration(
                                    //                                 borderRadius:
                                    //                                 BorderRadius.circular(12),
                                    //                                 color: googleSignInController
                                    //                                     .isLoading.value
                                    //                                     ? Colors.grey
                                    //                                     : Colors.green,
                                    //                               ),
                                    //                               child: Center(
                                    //                                 child: googleSignInController
                                    //                                     .isLoading.value
                                    //                                     ? const CircularProgressIndicator(
                                    //                                     color: Colors.green)
                                    //                                     : Text(
                                    //                                   "Continue",
                                    //                                   style:
                                    //                                   TextStyle(
                                    //                                       color: Colors
                                    //                                           .white,
                                    //                                       fontSize: 16,
                                    //                                       fontWeight:
                                    //                                       FontWeight
                                    //                                           .w500),
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     },
                                    //   );
                                    // },
                                    onTap: () {
                                      googleSignInController.signInWithGoogle();
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 44,
                                      // width: 140.w,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                        Border.all(color: const Color(0xffABECEB), width: 0.5),
                                      ),
                                      child: Row(
                                        children: [
                                          //SvgPicture.asset('assets/images/img_logo.svg'),
                                         const SizedBox(width: 5),
                                          Text(
                                            'Login via google',
                                            style: TextStyle(
                                                color: const Color(0xff202020),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // if (Platform.isIOS) ...[
                                  //   const SizedBox(width: 12),
                                  //   InkWell(
                                  //     borderRadius: BorderRadius.circular(10),
                                  //     onTap: () {
                                  //       showModalBottomSheet(
                                  //         context: context,
                                  //         backgroundColor:
                                  //         Colors.transparent, // Make the background transparent
                                  //         builder: (BuildContext context) {
                                  //           return Container(
                                  //             color: Colors.transparent,
                                  //             child: Scaffold(
                                  //               backgroundColor: Colors.transparent,
                                  //               bottomNavigationBar: Padding(
                                  //                 padding: const EdgeInsets.only(
                                  //                     left: 16, right: 16, bottom: 18),
                                  //                 child: Container(
                                  //                   height: 324.h,
                                  //                   width: 339.w,
                                  //                   decoration: BoxDecoration(
                                  //                     borderRadius: BorderRadius.circular(16),
                                  //                     color: Colors.white,
                                  //                   ),
                                  //                   child: Column(
                                  //                     children: [
                                  //                       39.verticalSpace,
                                  //                       SvgPicture.asset(
                                  //                         "assets/svg/logo_google_sign_in.svg",
                                  //                         height: 34.h,
                                  //                         width: 103.w,
                                  //                       ),
                                  //                       20.verticalSpace,
                                  //                       Row(
                                  //                         children: [
                                  //                           24.horizontalSpace,
                                  //                           Text(
                                  //                             "Continue with Apple",
                                  //                             style: TextStyle(
                                  //                                 color: Colors.black,
                                  //                                 fontSize: 14,
                                  //                                 fontWeight: FontWeight.w500),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                       12.verticalSpace,
                                  //                       Row(
                                  //                         children: [
                                  //                           24.horizontalSpace,
                                  //                           Text(
                                  //                             "You’ll be redirected to Apple for a secure and\nfaster login. Your name and email will be shared\nwith Triva app.",
                                  //                             style: TextStyle(
                                  //                                 color: const Color.fromRGBO(
                                  //                                     98, 100, 101, 1),
                                  //                                 fontSize: 12,
                                  //                                 fontWeight: FontWeight.w400,
                                  //                                 letterSpacing: 1.5),
                                  //                             textAlign: TextAlign.start,
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                       62.verticalSpace,
                                  //                       Padding(
                                  //                         padding: const EdgeInsets.only(
                                  //                             left: 20, right: 20),
                                  //                         child: Row(
                                  //                           mainAxisAlignment:
                                  //                           MainAxisAlignment.center,
                                  //                           children: [
                                  //                             GestureDetector(
                                  //                               onTap: () {
                                  //                                 Get.back();
                                  //                                 googleSignInController
                                  //                                     .isLoading.value = false;
                                  //                               },
                                  //                               child: Container(
                                  //                                 height: 60.h,
                                  //                                 width: 145.w,
                                  //                                 decoration: BoxDecoration(
                                  //                                     borderRadius:
                                  //                                     BorderRadius.circular(12),
                                  //                                     color: Colors.white,
                                  //                                     border: Border.all(
                                  //                                         color: Colors.black,
                                  //                                         width: 1)),
                                  //                                 child: Center(
                                  //                                   child: Text(
                                  //                                     "Cancel",
                                  //                                     style: AppTextStyle.inter(
                                  //                                         color:
                                  //                                         const Color.fromRGBO(
                                  //                                             58, 58, 60, 1),
                                  //                                         fontSize: 16,
                                  //                                         fontWeight:
                                  //                                         FontWeight.w500),
                                  //                                   ),
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                             10.horizontalSpace,
                                  //                             Obx(
                                  //                                   () => GestureDetector(
                                  //                                 onTap: googleSignInController
                                  //                                     .isLoading.value
                                  //                                     ? null
                                  //                                     : () {
                                  //                                   googleSignInController
                                  //                                       .signInWithApple();
                                  //                                 },
                                  //                                 child: Container(
                                  //                                   height: 60.h,
                                  //                                   width: 145.w,
                                  //                                   decoration: BoxDecoration(
                                  //                                     borderRadius:
                                  //                                     BorderRadius.circular(12),
                                  //                                     color: googleSignInController
                                  //                                         .isLoading.value
                                  //                                         ? Colors.grey
                                  //                                         : ColorConstant
                                  //                                         .appGreenColor,
                                  //                                   ),
                                  //                                   child: Center(
                                  //                                     child: googleSignInController
                                  //                                         .isLoading.value
                                  //                                         ? const CircularProgressIndicator(
                                  //                                         color: ColorConstant
                                  //                                             .appGreenColor)
                                  //                                         : Text(
                                  //                                       "Continue",
                                  //                                       style: AppTextStyle
                                  //                                           .inter(
                                  //                                           color: Colors
                                  //                                               .white,
                                  //                                           fontSize: 16,
                                  //                                           fontWeight:
                                  //                                           FontWeight
                                  //                                               .w500),
                                  //                                     ),
                                  //                                   ),
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                           ],
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           );
                                  //         },
                                  //       );
                                  //     },
                                  //     child: Container(
                                  //       height: 44.h,
                                  //       // width: 140.w,
                                  //       padding: const EdgeInsets.all(12),
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(10),
                                  //         border: Border.all(
                                  //             color: const Color(0xffABECEB), width: 0.5),
                                  //       ),
                                  //       child: Row(
                                  //         children: [
                                  //           SvgPicture.asset('assets/svg/apple_logo.svg'),
                                  //           5.horizontalSpace,
                                  //           Text(
                                  //             'Login via apple',
                                  //             style: AppTextStyle.inter(
                                  //                 color: const Color(0xff202020),
                                  //                 fontSize: 12.sp,
                                  //                 fontWeight: FontWeight.w500),
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ]
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
                                    onTap: () {
                                      Get.offAll(RegisterScreen());
                                    },
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
                          Get.offAll(OtpVerificationScreen(),
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
