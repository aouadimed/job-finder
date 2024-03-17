import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';

class SelectRole extends StatelessWidget {
  const SelectRole({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.symmetric(
          horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), 
        borderRadius: BorderRadius.circular(30.0), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0), 
        child: Column(
          children: [
            Container(
              width: 80.0,
              height: 80.0, 
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(121, 143, 255, 0.286)
                , // Blue color for the circle
              ),
              child: const Icon(Icons.work_rounded,
                  color: Colors.white), 
            ),
            const SizedBox(
                height: 10.0), 
            const Text(
              'Find a Job',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Other Text',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
