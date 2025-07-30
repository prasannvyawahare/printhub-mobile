import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static FirebaseMessaging? _firebaseMessaging;

  static FirebaseMessaging get firebaseMessaging => FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    FirebaseService._firebaseMessaging = FirebaseMessaging.instance;
    //await FirebaseService.initializeLocalNotifications();
    //LocalNotificationService.initialize();

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        Future.delayed(const Duration(seconds: 3), () {
          openMessageNavigation(message: message!);
        });
      }
    });
    await FirebaseService.onMessage();
    await FirebaseService.onAppOpenMessage();
    await FirebaseService.onBackgroundMsg();
  }

  Future<String?> getDeviceToken() async {
    final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken == null) {
      return await FirebaseMessaging.instance.getToken();
    }
    return "";
  }

  // static final FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initializeLocalNotifications() async {
    // InitializationSettings initSettings = const InitializationSettings(
    //     android: AndroidInitializationSettings("ic_launcher"),
    //     iOS: DarwinInitializationSettings());
    //
    // await localNotificationsPlugin.initialize(initSettings,
    //     onDidReceiveNotificationResponse: onTapNotification);
    // await FirebaseService.firebaseMessaging
    //     .setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
  }

  // static NotificationDetails platformChannelSpecifics = const NotificationDetails(
  //   iOS: DarwinNotificationDetails(sound: "reminderalarm.wav"),
  //   android: AndroidNotificationDetails(
  //     "high_importance_channel",
  //     "High Importance Notifications",
  //     priority: Priority.max,
  //     importance: Importance.max,
  //   ),
  // );
  //
  // static Future<void> onTapNotification(NotificationResponse? response) async {
  //   if (response == null) {
  //     return;
  //   } else {
  //     openAppMessageNavigation(responsePayload: response.payload);
  //   }
  // }

  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      String mapd = json.encode(message.data);
      // await FirebaseService.localNotificationsPlugin
      //     .show(
      //   id,
      //   message.notification!.title,
      //   message.notification!.body,
      //   FirebaseService.platformChannelSpecifics,
      //   payload: mapd,
      // )
      //     .then((value) {
      //   print("done");
      // }).catchError((err) {
      //   print("done$err");
      // });
    });
  }

  static Future<void> onAppOpenMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      //print(message);
      openMessageNavigation(message: message);
    });
  }

  static Future<void> onBackgroundMsg() async {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    openMessageNavigation(message: message);
  }

  Future<String?> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {}).onError((err) {});
  }

  static String? fsmName;

  // static Future<String> getName() async {
  //   return await SessionManager().get(SessionDataKey().displayName);
  // }

  static Future<void> openMessageNavigation({required RemoteMessage message}) async {
    // fsmName = await getName();

    Map<String, dynamic> payload = message.data;
    //print(message);
    var category = payload['category'];
    var type = payload['type'];
    var userType = payload['user_type'];
    var inType = payload['to_usertype'];
    Map<String, dynamic>? details = {};
    if (payload['details'] != null) {
      details = jsonDecode(payload['details']);
    } else {
      details = {};
    }

    if (userType == "Service Technician") {
      if (category == "Details") {
        if (type == "Job") {
          // Get.to(() => TeamJobDetailsScreen(
          //       jobId: payload['booking_id'],
          //       jobNo: payload['booking_id'],
          //     ));
        } else {
          // Get.to(() => TeamInvoiceDetailsScreen(invoiceNo: payload['booking_id']));
        }
      } else if (category == "Notification" && type == "Transfer Amount") {
        // Get.to(() => PaymentCollectionScreen());
      } else if (category == "Rating") {
        // Get.to(() => const TeamDashBoard());
      } else if (category == "Chat") {
        if (inType == "TEAM") {
          if (details != null) {
            // String roomId = chatRoomId(payload['from_id'], payload['to_id']);
            // print(roomId);
            print("\n\n\n$details\n\n\n");
            // Get.to(
            //   () => TeamPersonalChatScreen(
            //     chatRoomId: roomId,
            //     userMap: details!,
            //   ),
            // );
          } else {
            // Get.to(ChatListScreen());
          }
          // Get.to(() => TeamAdminChatScreen(
          //       adminId: payload['from_id'].toString(),
          //     ));
        } else if (inType == "GROUP") {
          String groupId = "${payload['to_id']}GROUP";

          // Get.to(
          //   () => TeamGroupChatRoom(
          //     groupName: "Team Group",
          //     // You may want to fetch the actual group name
          //     groupChatId: groupId,
          //     adminId: payload['to_id'],
          //   ),
          // );
          // Get.to(() => TeamGroupChatScreen());
        }
      } else {
        // Get.to(() => const TeamDashBoard());
      }
    } else if (userType == "Service Partner") {
      if (category == "Details") {
        if (type == "Quote") {
          // Get.to(() => QuoteDetailsScreen(
          //       quoteId: payload['booking_id'],
          //       isFromCreate: false,
          //       userId: payload['fsm_id'],
          //       jobNo: "",
          //       quoteNo: payload['booking_id'],
          //       invoiceNo: payload['booking_id'],
          //       fsmName: fsmName ?? "",
          //     ));
        } else if (type == "Job") {
          // Get.to(() => JobDetailsScreen(
          //       jobId: payload['booking_id'],
          //       invoiceNo: payload['booking_id'],
          //       isFromCreate: false,
          //       jobNo: payload['booking_id'],
          //     ));
        } else {
          // Get.to(() => InvoiceDetailsScreen(
          //       invoiceId: payload['booking_id'],
          //       invoiceNo: payload['booking_id'],
          //       isFromCreate: false,
          //       userId: payload['fsm_id'],
          //     ));
        }
      } else if (category == "Attendance") {
        // Get.to(() => MyAttendanceScreen(id: payload['member_id']));
      } else if (category == "Notification" && type == "Transfer Amount") {
        // Get.to(() => const PaymentScreen());
      } else if (category == "Chat") {
        if (inType == "FSM") {
          if (details != null) {
            // String roomId = chatRoomId(payload['to_id'], payload['from_id']);
            // print(roomId);
            print("\n\n\n$details\n\n\n");
            // Get.to(
            //   () => PersonalChatScreen(
            //     chatRoomId: roomId,
            //     userMap: details!,
            //     pearType: "Team",
            //     teamId: payload['from_id'],
            //   ),
            // );
          } else {
            // Get.to(ChatListScreen());
          }
        } else if (inType == "GROUP") {
          // Get.to(() => GroupChatScreen());
          String groupId = "${payload['to_id']}GROUP";

          // Get.to(
          //   () => GroupChatRoom(
          //     groupName: "Team Group",
          //     // You may want to fetch the actual group name
          //     groupChatId: groupId,
          //     adminId: payload['to_id'],
          //   ),
          // );
        } else {
          // Get.to(() => const DashBoard());
        }
      } else {
        // Get.to(() => const DashBoard());
      }
    }
  }

  static void openAppMessageNavigation({required String? responsePayload}) {
    if (responsePayload == null) return;

    Map payload = jsonDecode(responsePayload);
    print(payload);
    var category = payload['category'];
    var type = payload['type'];
    var userType = payload['user_type'];
    var inType = payload['to_usertype'];

    Map<String, dynamic>? details = {};

    if (payload['details'] != null) {
      details = jsonDecode(payload['details']);
    } else {
      details = {};
    }

    if (userType == "Service Technician") {
      if (category == "Details") {
        if (type == "Job") {
          // Get.to(() => TeamJobDetailsScreen(
          //       jobId: payload['booking_id'],
          //       jobNo: '',
          //     ));
        } else {
          // Get.to(() => TeamInvoiceDetailsScreen(invoiceNo: payload['booking_id']));
        }
      } else if (category == "Rating") {
        // Get.to(() => const TeamDashBoard());
      } else if (category == "Chat") {
        if (inType == "TEAM") {
          if (details != null) {
            // String roomId = chatRoomId(payload['from_id'], payload['to_id']);
            // print(roomId);
            print("\n\n\n$details\n\n\n");
            // Get.to(
            //   () => TeamPersonalChatScreen(
            //     chatRoomId: roomId,
            //     userMap: details!,
            //   ),
            // );
          } else {
            // Get.to(ChatListScreen());
          }
          // Get.to(() => TeamAdminChatScreen(
          //       adminId: payload['from_id'].toString(),
          //     ));
        } else if (inType == "GROUP") {
          String groupId = "${payload['to_id']}GROUP";
          // Get.to(
          //   () => TeamGroupChatRoom(
          //     groupName: "Team Group",
          //     // You may want to fetch the actual group name
          //     groupChatId: groupId,
          //     adminId: payload['to_id'],
          //   ),
          // );
          // Get.to(() => TeamGroupChatScreen());
        }
      } else {
        // Get.to(() => const TeamDashBoard());
      }
    } else if (userType == "Service Partner") {
      if (category == "Details") {
        if (type == "Quote") {
          // Get.to(() => QuoteDetailsScreen(
          //       quoteId: payload['booking_id'],
          //       isFromCreate: false,
          //       userId: payload['fsm_id'],
          //       jobNo: "",
          //       invoiceNo: "",
          //       quoteNo: payload['booking_id'],
          //       fsmName: fsmName ?? "",
          //     ));
        } else if (type == "Job") {
          // Get.to(() => JobDetailsScreen(jobId: payload['booking_id'], invoiceNo: "", isFromCreate: false, jobNo: payload['booking_id']));
        } else {
          // Get.to(() => InvoiceDetailsScreen(
          //       invoiceId: payload['booking_id'],
          //       invoiceNo: payload['booking_id'],
          //       isFromCreate: false,
          //       userId: payload['fsm_id'],
          //     ));
        }
      } else if (category == "Attendance") {
        // Get.to(() => MyAttendanceScreen(id: payload['member_id']));
      } else if (category == "Chat") {
        if (inType == "FSM") {
          if (details != null) {
            // String roomId = chatRoomId(payload['to_id'], payload['from_id']);
            // print(roomId);
            print("\n\n\n$details\n\n\n");
            // Get.to(
            //   () => PersonalChatScreen(
            //     chatRoomId: roomId,
            //     pearType: "Team",
            //     userMap: details!,
            //     teamId: payload['from_id'],
            //   ),
            // );
          } else {
            // Get.to(ChatListScreen());
          }
        } else if (inType == "GROUP") {
          // Get.to(() => GroupChatScreen());
          String groupId = "${payload['to_id']}GROUP";
          // Get.to(
          //   () => GroupChatRoom(
          //     groupName: "Team Group",
          //     // You may want to fetch the actual group name
          //     groupChatId: groupId,
          //     adminId: payload['to_id'],
          //   ),
          // );
        } else {
          // Get.to(() => const DashBoard());
        }
      } else {
        // Get.to(() => const DashBoard());
      }
    }
  }
}
