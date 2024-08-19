import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/emp_type_sheet.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class ApplicantsCard extends StatefulWidget {
  final String name;
  final String? jobTitle;
  final String profileImageUrl;
  final VoidCallback? onSeeResumePressed;
  final VoidCallback? onSeeDetailsPressed;
  final VoidCallback onMessageSent;
  final VoidCallback? onSeeMotivationLetterPressed;

  final bool hasResume;
  final bool hasMotivationLetter;
  final bool hasProfile;
  final ScrollController scrollController;
  final bool isExpanded;
  final VoidCallback onToggleExpansion;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ApplicantsCard({
    super.key,
    required this.name,
    this.jobTitle,
    required this.profileImageUrl,
    required this.onMessageSent,
    this.onSeeResumePressed,
    this.onSeeDetailsPressed,
    this.onSeeMotivationLetterPressed,
    this.hasResume = false,
    this.hasMotivationLetter = false,
    this.hasProfile = true,
    required this.scrollController,
    required this.isExpanded,
    required this.onToggleExpansion,
    required this.onAccept,
    required this.onReject,
  });

  @override
  State<ApplicantsCard> createState() => _ApplicantsCardState();
}

class _ApplicantsCardState extends State<ApplicantsCard> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  String _selectedStatus = 'Mark Status as';
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
    return Dismissible(
      key: widget.key!,
      background: _buildSwipeBackground(
          Alignment.centerLeft, Icons.check, "Accept", Colors.green),
      secondaryBackground: _buildSwipeBackground(
          Alignment.centerRight, Icons.clear, "Reject", Colors.red),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          widget.onAccept();
        } else if (direction == DismissDirection.endToStart) {
          widget.onReject();
        }
      },
      child: Padding(
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
                          if (widget.jobTitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              widget.jobTitle!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        widget.isExpanded ? Icons.expand_less : Icons.message,
                        color: primaryColor,
                      ),
                      onPressed: widget.onToggleExpansion,
                    ),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  children: [
                    if (widget.hasResume)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: widget.onSeeResumePressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                          ),
                          child: Text(
                            'See Resume',
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ),
                    if (widget.hasMotivationLetter) const SizedBox(width: 16),
                    if (widget.hasMotivationLetter)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: widget.onSeeMotivationLetterPressed,
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: BorderSide(color: primaryColor),
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                          ),
                          child: Text(
                            'Motivation Letter',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    if (widget.hasProfile)
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
                            'See Profile',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                  ],
                ),
                if (widget.isExpanded) ...[
                  const SizedBox(height: 16),
                  InputField(
                    controller: _statusController,
                    hint: _selectedStatus,
                    hintColor: darkColor,
                    textInputAction: TextInputAction.done,
                    onTap: () async {
                      String? selectedStatus =
                          await showModalBottomSheet<String>(
                        context: context,
                        elevation: 0,
                        builder: (BuildContext context) {
                          return SelectionSheet(
                            onSelect: (String value, int indexValue) {
                              setState(() {
                                selectedStatusIndex = indexValue;
                                _selectedStatus = value;
                              });

                              Navigator.pop(context, value);
                            },
                            selectedIndex: selectedStatusIndex,
                            list: const [
                              'Mark Status as',
                              'Reviewed',
                              'Accepted',
                              'Rejected'
                            ],
                          );
                        },
                      );
                      if (selectedStatus != null) {
                        setState(() {
                          _statusController.text = selectedStatus;
                        });
                      }
                    },
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    focusNode: _messageFocusNode,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      labelText: 'Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  BigButton(
                    text: "Send response",
                    onPressed: widget.onMessageSent,
                    textColor: primaryColor,
                    color: lightprimaryColor,
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground(
      Alignment alignment, IconData icon, String label, Color color) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
