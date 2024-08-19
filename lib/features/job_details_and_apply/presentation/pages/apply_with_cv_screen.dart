import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_apply_bloc/job_apply_bloc.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/apply_with_cv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyWithCVScreen extends StatefulWidget {
  const ApplyWithCVScreen({super.key});

  @override
  State<ApplyWithCVScreen> createState() => _ApplyWithCVScreenState();
}

class _ApplyWithCVScreenState extends State<ApplyWithCVScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _motivationLetterController =
      TextEditingController();
  late String filepath;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return BlocConsumer<JobApplyBloc, JobApplyState>(
      listener: (context, state) {
        if (state is JobApplyFailure) {
          showSnackBar(context: context, message: state.message);
        } else if (state is JobApplySuccess) {
          showSnackBar(
            context: context,
            message: "Application submitted successfully!",
            backgroundColor: greenColor,
          );
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const GeneralAppBar(titleText: "Apply Job"),
          body: SafeArea(
            child: ApplyWithCVForm(
              formKey: _formKey,
              motivationLetterController: _motivationLetterController,
              onFileSelected: (String? filePath) {
                filepath = filePath!;
              },
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BigButton(
              text: "Submit",
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  BlocProvider.of<JobApplyBloc>(context).add(
                    SubmitForJobEvent(
                      jobId: args?['jobOfferId'],
                      cvUpload: filepath,
                      motivationLetter: _motivationLetterController.text,
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
