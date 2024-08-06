import 'package:flutter/material.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/apply_with_cv.dart';

class ApplyWithCVScreen extends StatefulWidget {
  const ApplyWithCVScreen({super.key});

  @override
  State<ApplyWithCVScreen> createState() => _ApplyWithCVScreenState();
}

class _ApplyWithCVScreenState extends State<ApplyWithCVScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _motivationLetterController = TextEditingController();

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    print(args?['jobOfferId']);

    return Scaffold(
      appBar: GeneralAppBar(titleText: "Apply Job"),
      body: Stack(
        children: [
          ApplyWithCVForm(
            formKey: _formKey,
            fullNameController: _fullNameController,
            emailController: _emailController,
            motivationLetterController: _motivationLetterController,
          ),
          if (_isSubmitting)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BigButton(
          text: "Submit",
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              setState(() {
                _isSubmitting = true;
              });
              // Perform submission logic
              await Future.delayed(Duration(seconds: 2)); // Simulate submission delay
              setState(() {
                _isSubmitting = false;
              });
              print('Form is valid, submit data');
            }
          },
        ),
      ),
    );
  }
}
