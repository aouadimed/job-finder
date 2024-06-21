import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _summaryTextFieldController;

  @override
  void initState() {
    _summaryTextFieldController = TextEditingController();
    super.initState();
    _loadSummary(context);
  }

  @override
  void dispose() {
    _summaryTextFieldController.dispose();
    super.dispose();
  }

  Future<void> _loadSummary(BuildContext context) async {
    BlocProvider.of<SummaryBloc>(context).add(GetSummaryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SummaryBloc, SummaryState>(
      listener: (context, state) {
        if (state is GetSummarySuccess) {
          _summaryTextFieldController.text =
              state.summaryModel.description ?? '';
        } else if (state is SummaryFailure) {
          showSnackBar(context: context, message: state.message);
        } else if (state is CreateOrUpdateSummarySuccess) {
          showSnackBar(
            context: context,
            message: "Summary saved successfully",
            backgroundColor: greenColor,
          );
          _loadSummary(context);
        }
      },
      child: BlocBuilder<SummaryBloc, SummaryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const GeneralAppBar(titleText: "Summary"),
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Summary (Max 500 characters)',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _summaryTextFieldController,
                              maxLines: 15,
                              maxLength: 500,
                              decoration: InputDecoration(
                                hintText: 'Enter your summary here',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                filled: true,
                                fillColor: Colors.grey[200],
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Summary cannot be empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Divider(thickness: 0.5),
                          BigButton(
                            text: 'Save',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<SummaryBloc>(context).add(
                                  CreateOrUpdateSummaryEvent(
                                      description:
                                          _summaryTextFieldController.text),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state is SummaryLoading)
                    Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
