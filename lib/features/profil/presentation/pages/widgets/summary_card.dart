import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class Summary extends StatefulWidget {
  final VoidCallback? iconOnPressed;

  const Summary({Key? key, required this.iconOnPressed}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  bool _isExpanded = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch the summary when the widget is first built
    BlocProvider.of<SummaryBloc>(context).add(GetSummaryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.4, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
              if (_isExpanded && !_isLoading) {
                BlocProvider.of<SummaryBloc>(context).add(GetSummaryEvent());
              }
            },
            child: Container(
              height: 56, // Set a fixed height for the header
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.summarize_rounded, color: primaryColor),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      "Summary",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  BlocBuilder<SummaryBloc, SummaryState>(
                    builder: (context, state) {
                      // ignore: unused_local_variable
                      bool hasDescription = false;
                      if (state is GetSummarySuccess) {
                        hasDescription =
                            state.summaryModel.description != null &&
                                state.summaryModel.description!.isNotEmpty;
                      }

                      return Visibility(
                        visible:
                            hasDescription, 
                        child: Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: primaryColor,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  BlocBuilder<SummaryBloc, SummaryState>(
                    builder: (context, state) {
                      bool hasDescription = false;
                      if (state is GetSummarySuccess) {
                        hasDescription =
                            state.summaryModel.description != null &&
                                state.summaryModel.description!.isNotEmpty;
                      }
                      if (state is SummaryLoading) {
                        return CircularProgressIndicator(color: primaryColor);
                      } else if (state is GetSummarySuccess ||
                          state is SummaryFailure) {
                        _isLoading = false;
                        return IconButton(
                          icon: Icon(
                            hasDescription ? Icons.edit : Icons.add,
                            color: primaryColor,
                          ),
                          onPressed: widget.iconOnPressed,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            BlocBuilder<SummaryBloc, SummaryState>(
              builder: (context, state) {
                if (state is SummaryLoading) {
                  return Center(
                      child: CircularProgressIndicator(color: primaryColor));
                } else if (state is GetSummarySuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      state.summaryModel.description ??
                          'No description available',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  );
                } else if (state is SummaryFailure) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Failed to load summary: ${state.message}',
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'No description available',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
