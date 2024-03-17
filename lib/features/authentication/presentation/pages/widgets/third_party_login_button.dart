import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final String? path;
  final Function()? onTap;
  const Btn({Key? key, required this.path, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 0.9,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage(
                path ??
                    "assets/images/logo.webp", // Providing a default value in case path is null
              ),
              height: 20, // Set the height of the image to make it smaller
              width: 20, // Set the width of the image to make it smaller
            ),
          ),
        ),
      ),
    );
  }
}
