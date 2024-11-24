import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class ApplicantsCard extends StatefulWidget {
  final String name;
  final String jobTitle;
  final String profileImageUrl;
  final VoidCallback onSeeDetailsPressed;
  final VoidCallback sentMessage;

  const ApplicantsCard({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.profileImageUrl,
    required this.onSeeDetailsPressed,
    required this.sentMessage,
  });

  @override
  State<ApplicantsCard> createState() => _ApplicantsCardState();
}

class _ApplicantsCardState extends State<ApplicantsCard> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  int selectedStatusIndex = 0;

  @override
  void dispose() {
    _messageController.dispose();
    _statusController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 1, color: Colors.grey.shade400),
        ),
        elevation: 0,
        color: whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (widget.profileImageUrl != 'null')
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(widget.profileImageUrl),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.jobTitle,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onSeeDetailsPressed,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        side: BorderSide(color: primaryColor),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                      ),
                      child: Text(
                        'See Details',
                        style: TextStyle(color: primaryColor),
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
