import 'package:flutter/material.dart';

class GenearalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;

  const GenearalAppBar({Key? key, this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black), 
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        titleText ?? '', 
        style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500), 
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
