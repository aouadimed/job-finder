import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String receiverImage;
  final String receiverName;
  final String lastMessage;
  final String lastConversationDate;
  final String? numberOfNotReadMessages;
  final VoidCallback onTap;

  const ChatCard({
    Key? key,
    required this.receiverImage,
    required this.receiverName,
    required this.lastMessage,
    required this.lastConversationDate,
    this.numberOfNotReadMessages,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: receiverImage != "undefined"
                    ? NetworkImage(receiverImage)
                    : null,
                backgroundColor: receiverImage == "undefined"
                    ? primaryColor.withOpacity(0.8)
                    : Colors.transparent,
                child: receiverImage == "undefined"
                    ? Center(
                        child: Text(
                          "${receiverName[0].toUpperCase()} ${receiverName[1].toUpperCase()}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      receiverName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      lastMessage,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    lastConversationDate,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
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
