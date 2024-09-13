import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_apply_bloc/job_apply_bloc.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyWithProfil extends StatelessWidget {
  final String jobOfferId;
  final String? text;
  const ApplyWithProfil({super.key, required this.jobOfferId, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BigButton(
          text: text ??"Submit",
          onPressed: () {
            BlocProvider.of<JobApplyBloc>(context).add(
              SubmitForJobEvent(jobId: jobOfferId, userProfile: true),
            );
          }),
    );
  }
}
