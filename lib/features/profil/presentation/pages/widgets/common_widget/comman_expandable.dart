import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class CommonExpandableList<T> extends StatefulWidget {
  final VoidCallback? iconOnPressed;
  final List<T> items;
  final String headerTitle;
  final Function(String) editIconOnPressed;
  final Widget Function(T) itemBuilder;
  final IconData headerIcon;

  const CommonExpandableList({
    Key? key,
    required this.iconOnPressed,
    required this.items,
    required this.headerTitle,
    required this.editIconOnPressed,
    required this.itemBuilder,
    required this.headerIcon,
  }) : super(key: key);

  @override
  State<CommonExpandableList> createState() => _CommonExpandableListState<T>();
}

class _CommonExpandableListState<T> extends State<CommonExpandableList<T>> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool hasItems = widget.items.isNotEmpty;
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
          if (hasItems) {
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
                  if (hasItems) {
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
                      Icon(widget.headerIcon, color: primaryColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.headerTitle,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: hasItems,
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
                          Icons.add,
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
              child: Column(
                children: widget.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: widget.itemBuilder(item),
                  );
                }).toList(),
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
