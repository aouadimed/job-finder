import 'package:flutter/material.dart';

class ContactInformationCard extends StatefulWidget {
  const ContactInformationCard({Key? key}) : super(key: key);

  @override
  State<ContactInformationCard> createState() => _ContactInformationCardState();
}

class _ContactInformationCardState extends State<ContactInformationCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.4, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              height: 56, // Set a fixed height for the header
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      // Implement your edit functionality here
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(thickness: 0.5),
                ),
                ListTile(
                  leading: Icon(Icons.location_on, color: Colors.grey),
                  title: Text("New York, United States"),
                ),
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.grey),
                  title: Row(
                    children: [
                      Text("+1 111 467 378 399"),
                      SizedBox(width: 4),
                      Icon(Icons.check_circle, color: Colors.blue, size: 16),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.grey),
                  title: Row(
                    children: [
                      Text(
                        "andrew_ainsley@yourdomain.com",
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.check_circle, color: Colors.blue, size: 16),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}