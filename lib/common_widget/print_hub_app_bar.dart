import 'package:flutter/material.dart';

class PrintHubAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrintHubAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: const [
          Icon(Icons.print, color: Colors.purple),
          SizedBox(width: 8),
          Text(
            "PrintHub",
            style: TextStyle(color: Colors.purple),
          ),
        ],
      ),
      actions: [
        IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: (){},
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
