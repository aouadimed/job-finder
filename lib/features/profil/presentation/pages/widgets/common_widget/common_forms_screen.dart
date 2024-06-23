import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';

class CommonFormsScreen extends StatelessWidget {
  final String title;
  final Widget form;
  final void Function()? onSave;
  final void Function()? onDelete;
  final bool isLoading;
  final bool isUpdate;

  const CommonFormsScreen({
    Key? key,
    required this.title,
    required this.form,
    this.onSave,
    this.onDelete,
    this.isLoading = false,
    this.isUpdate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        titleText: title,
        rightIcon: isUpdate ? Icons.delete_outline : null,
        rightIconColor: redColor,
        rightIconOnPressed: isUpdate ? onDelete : null,
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: primaryColor,
              ))
            : Column(
                children: [
                  Expanded(child: form),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const Divider(),
                        const SizedBox(height: 10),
                        BigButton(
                          text: 'Save',
                          onPressed: onSave,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}