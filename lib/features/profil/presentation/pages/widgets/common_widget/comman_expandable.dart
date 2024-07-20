import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class CommonExpandableList<T> extends StatefulWidget {
  final VoidCallback? iconOnPressed;
  final List<T> items;
  final String headerTitle;
  final Function(String)? editIconOnPressed;
  final Widget Function(T) itemBuilder;
  final IconData headerIcon;
  final bool isExpanded;
  final Function(bool) onExpansionChanged;
  final GlobalKey sectionKey;
  final IconData? icon;

  const CommonExpandableList({
    Key? key,
    required this.iconOnPressed,
    required this.items,
    required this.headerTitle,
    this.editIconOnPressed,
    required this.itemBuilder,
    required this.headerIcon,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.sectionKey,
    this.icon,
  }) : super(key: key);

  @override
  State<CommonExpandableList> createState() => _CommonExpandableListState<T>();
}

class _CommonExpandableListState<T> extends State<CommonExpandableList<T>> {
  @override
  void initState() {
    if (widget.items.isEmpty && widget.isExpanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onExpansionChanged(false);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasItems = widget.items.isNotEmpty;
    return Card(
      key: widget.sectionKey,
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
              widget.onExpansionChanged(!isExpanded);
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
                      widget.onExpansionChanged(!widget.isExpanded);
                    });
                  }
                },
                child: Container(
                  height: 56,
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
                          widget.isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: greyColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: Icon(
                          widget.icon ?? Icons.add,
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
            isExpanded: widget.isExpanded,
            canTapOnHeader: true,
          ),
        ],
      ),
    );
  }
}
