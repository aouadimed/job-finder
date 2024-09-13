import 'package:flutter/material.dart';

class ApplicationCard extends StatelessWidget {
  final String logo;
  final String jobTitle;
  final String companyName;
  final String status;

  const ApplicationCard({
    super.key,
    required this.logo,
    required this.jobTitle,
    required this.companyName,
    required this.status,
  });

  // Determines background color based on the application status
  Color? determineStatusColor(String status) {
    switch (status) {
      case "sent":
        return Colors.blue[100];
      case "accepted":
        return Colors.green[100];
      case "rejected":
        return Colors.red[100];
      case "pending":
        return Colors.orange[100];
      default:
        return Colors.grey[300];
    }
  }

  // Determines text color based on the application status
  Color? determineStatusTextColor(String status) {
    switch (status) {
      case "sent":
        return Colors.blue[900];
      case "accepted":
        return Colors.green[900];
      case "rejected":
        return Colors.red[900];
      case "pending":
        return Colors.orange[900];
      default:
        return Colors.grey[600];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 0.8, color: Colors.grey.shade400),
        ),
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 0.9,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(logo),
                    radius: 80,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    jobTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(companyName),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: determineStatusColor(status),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Application $status",
                      style: TextStyle(
                        color: determineStatusTextColor(status),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
