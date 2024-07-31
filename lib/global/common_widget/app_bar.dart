import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final ImageProvider? logo;
  final IconData? rightIcon;
  final VoidCallback? rightIconOnPressed;
  final Color? rightIconColor;
  const GeneralAppBar({
    Key? key,
    this.titleText,
    this.logo,
    this.rightIcon,
    this.rightIconOnPressed,
    this.rightIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: logo != null
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(borderRadius:BorderRadius.circular(10.0) ,child: Image(image: logo!)),
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      title: Text(
        titleText ?? '',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: rightIcon != null
          ? [
              IconButton(
                icon: Icon(rightIcon,
                    color: rightIconColor != null
                        ? rightIconColor!
                        : Colors.black),
                onPressed: rightIconOnPressed,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
