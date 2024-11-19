import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class FilterExpandableWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final Map<String, bool>? options; // Nullable to allow for custom child widgets
  final Widget? child; // Added child parameter for custom widgets
  final ValueChanged<String>? onChanged; // Nullable for flexibility
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;

  const FilterExpandableWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.options,
    this.child,
    this.onChanged,
    required this.isExpanded,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  State<FilterExpandableWidget> createState() => _FilterExpandableWidgetState();
}

class _FilterExpandableWidgetState extends State<FilterExpandableWidget> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  void didUpdateWidget(FilterExpandableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      setState(() {
        _isExpanded = widget.isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.4, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ExpansionPanelList(
          elevation: 0,
          expandedHeaderPadding: EdgeInsets.zero,
          expansionCallback: (index, isExpanded) {
            setState(() {
              _isExpanded = !_isExpanded;
            });
            widget.onExpansionChanged(_isExpanded);
          },
          children: [
            ExpansionPanel(
              hasIcon: true,
              backgroundColor: Colors.white,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  leading: Icon(widget.icon, color: primaryColor),
                  title: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
              body: widget.child ??
                  Column(
                    children: widget.options?.keys.map((key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: widget.options![key],
                        onChanged: (value) {
                          widget.onChanged?.call(key);
                        },
                      );
                    }).toList() ??
                        [],
                  ),
              isExpanded: _isExpanded,
            ),
          ],
        ),
      ),
    );
  }
}
