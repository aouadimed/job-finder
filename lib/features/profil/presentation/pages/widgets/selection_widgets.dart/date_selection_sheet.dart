import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomPicker extends StatefulWidget {
  const CustomPicker({Key? key}) : super(key: key);

  @override
  State<CustomPicker> createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  final ValueNotifier<int> _selectedMonth = ValueNotifier(DateTime.now().month);
  final ValueNotifier<int> _selectedYear = ValueNotifier(DateTime.now().year);
  late final List<int> years;

  @override
  void initState() {
    super.initState();
    int currentYear = DateTime.now().year;
    years = List.generate(100, (index) => currentYear - index);
  }

  @override
  Widget build(BuildContext context) {
    double itemHeight = 50;
    int numberOfItemsToBeVisible = 3;
    double pickerHeight = itemHeight * numberOfItemsToBeVisible;

    var monthScrollController = FixedExtentScrollController(
      initialItem: _selectedMonth.value - 1,
    );
    var yearScrollController = FixedExtentScrollController(
      initialItem: years.indexOf(_selectedYear.value),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: 80,
          height: 8,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(
          height: pickerHeight + 20,
          child: Row(
            children: [
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: monthScrollController,
                  itemExtent: itemHeight,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    _selectedMonth.value = index + 1;
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return Center(
                        child: Text(
                          DateFormat.MMM().format(DateTime(2024, index + 1, 1)),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    },
                    childCount: 12,
                  ),
                ),
              ),
              VerticalDivider(width: 1, color: Colors.grey[300]),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: yearScrollController,
                  itemExtent: itemHeight,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    _selectedYear.value = years[index];
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return Center(
                        child: Text(
                          years[index].toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    },
                    childCount: years.length,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, {
                  'month': _selectedMonth.value,
                  'year': _selectedYear.value,
                });
              },
              child: Text(
                'Set',
                style: TextStyle(fontSize: 16, color: primaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
