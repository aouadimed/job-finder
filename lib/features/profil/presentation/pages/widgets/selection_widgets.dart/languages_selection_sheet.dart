import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:flutter/material.dart';

class LanguageSelectionSheet extends StatefulWidget {
  final void Function(String, int) onSelect;
  final List<String> list;
  final int selectedIndex;

  const LanguageSelectionSheet({
    Key? key,
    required this.onSelect,
    required this.list,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<LanguageSelectionSheet> createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredLanguages = [];

  @override
  void initState() {
    super.initState();
    _filteredLanguages = widget.list;
    _searchController.addListener(() {
      setState(() {
        _filteredLanguages = widget.list
            .where((language) => language
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        titleText: "Select Language",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputField(
                controller: _searchController,
                hint: "Search",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                textInputType: TextInputType.text,
                autofocus: true,
              ),
             const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredLanguages.length,
                  itemBuilder: (context, index) {
                    final language = _filteredLanguages[index];
                    final originalIndex = widget.list.indexOf(language);
                    return ListTile(
                      title: Text(
                        language,
                        style: TextStyle(
                          fontWeight: originalIndex == widget.selectedIndex
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: originalIndex == widget.selectedIndex
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        ),
                      ),
                      leading: originalIndex == widget.selectedIndex
                          ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                          : null,
                      onTap: () {
                        widget.onSelect(language, originalIndex);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
