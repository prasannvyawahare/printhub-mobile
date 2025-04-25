import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PrintHubAppBar extends StatelessWidget implements PreferredSizeWidget {
   final bool showBackButton;
  final String? title;

  const PrintHubAppBar({
    super.key,
    this.showBackButton = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () => Get.back(),
            )
          : null,
      titleSpacing: 20, 
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
          icon: const Icon(Icons.shopping_cart, color: Colors.black),
          onPressed: () {},
        ),
        const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar.jpg'), // Placeholder
        ),
        const SizedBox(width: 12),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
