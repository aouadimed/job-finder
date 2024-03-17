import 'package:flutter/material.dart';

class DividerAuth extends StatelessWidget {
  final String? text;
  const DividerAuth({super.key,this.text});

  @override
  Widget build(BuildContext context) {
    return  Row(
            mainAxisSize: MainAxisSize.min,
            children: [
         const      Expanded(
                child: Divider(
                  color: Colors.grey, // Adjust line color
                  thickness: 0.4, // Adjust line thickness
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0), // Adjust padding between text and lines
                child: Text(
                text ??  "or continue with",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 87, 87, 87),
                      fontWeight: FontWeight.w500),
                ),
              ),
        const      Expanded(
                child: Divider(
                  color: Colors.grey, // Adjust line color
                  thickness: 0.4, // Adjust line thickness
                ),
              ),
            ],
          );
  }
}