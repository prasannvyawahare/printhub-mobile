// import 'package:triva/constant/colorConstant.dart';
// import 'package:triva/controllers/dash_board_screen_controller.dart';
// import 'package:triva/utils/app_fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// import 'google_sign_in_controller.dart';
//
// class GoogleSignInScreen extends GetView<GoogleSignInController> {
//   final dashBoardScreenController = Get.find<DashBoardScreenController>();
//   final googleSignInController = Get.put(GoogleSignInController());
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         dashBoardScreenController.toggleVisibility();
//         dashBoardScreenController.toggleRotation();
//         Get.forceAppUpdate();
//         // Get.offAll(DashBoardScreen());
//         return false; // Prevent back navigation
//       },
//       child: Container(
//         color:Colors.white,
//         child: Scaffold(
//           backgroundColor: Color.fromRGBO(23, 52, 48, 0.3),
//           bottomNavigationBar: Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16, bottom: 18),
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
//                         style: AppTextStyle.inter(
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
//                         "You’ll be redirected to Google for a secure and\nfaster bloc. Your name and email will be shared\nwith Triva app.",
//                         style: AppTextStyle.inter(
//                             color: Color.fromRGBO(98, 100, 101, 1),
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             lineSpacing: 1.5),
//                         textAlign: TextAlign.start,
//                       ),
//                     ],
//                   ),
//                   62.verticalSpace,
//                   Padding(
//                     padding: const EdgeInsets.only(left: 24, right: 24),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                            Get.back();                        },
//                           child: Container(
//                             height: 60.h,
//                             width: 145.w,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: Colors.white,
//                                 border: Border.all(color: Colors.black, width: 1)),
//                             child: Center(
//                               child: Text(
//                                 "Cancel",
//                                 style: AppTextStyle.inter(
//                                     color: const Color.fromRGBO(58, 58, 60, 1),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                           ),
//                         ),
//                         10.horizontalSpace,
//                         Obx(
//                               () => GestureDetector(
//                             onTap: googleSignInController.isLoading.value
//                                 ? null
//                                 : () {
//                               googleSignInController.signInWithGoogle();
//                             },
//                             child: Container(
//                               height: 60.h,
//                               width: 145.w,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: googleSignInController.isLoading.value
//                                     ? Colors.grey
//                                     : ColorConstant.appGreenColor,
//                               ),
//                               child: Center(
//                                 child: googleSignInController.isLoading.value
//                                     ? const CircularProgressIndicator(
//                                   color: ColorConstant.appGreenColor
//                                 )
//                                     : Text(
//                                   "Continue",
//                                   style: AppTextStyle.inter(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500),
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
//       ),
//     );
//   }
// }
