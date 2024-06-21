import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class Summary extends StatefulWidget {
  final VoidCallback? iconOnPressed;
  final String summaryDescription;

  const Summary({
    Key? key,
    required this.iconOnPressed,
    required this.summaryDescription,
  }) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool hasDescription = widget.summaryDescription.isNotEmpty;

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.4, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (int index, bool isExpanded) {
          if (hasDescription) {
            setState(() {
              _isExpanded = !isExpanded;
            });
          }
        },
        children: [
          ExpansionPanel(
            hasIcon: false,
            backgroundColor: Colors.white,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return InkWell(
                onTap: () {
                  if (hasDescription) {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  }
                },
                child: Container(
                  height: 56, // Set a fixed height for the header
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.summarize_rounded, color: primaryColor),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          "Summary",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: hasDescription,
                        child: Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: greyColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: Icon(
                          hasDescription ? Icons.edit : Icons.add,
                          color: primaryColor,
                        ),
                        onPressed: widget.iconOnPressed,
                      ),
                    ],
                  ),
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                hasDescription
                    ? widget.summaryDescription
                    : 'No description available',
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            isExpanded: _isExpanded,
            canTapOnHeader: true,
          ),
        ],
      ),
    );
  }
}
