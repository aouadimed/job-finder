import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/global/common_widget/common_text_filed.dart';
import 'package:intl/intl.dart';

class ApplyWithCVForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController motivationLetterController;
  final Function(String? filePath) onFileSelected;

  const ApplyWithCVForm({
    super.key,
    required this.formKey,
    required this.motivationLetterController,
    required this.onFileSelected,
  });

  @override
  State<ApplyWithCVForm> createState() => _ApplyWithCVFormState();
}

class _ApplyWithCVFormState extends State<ApplyWithCVForm> {
  String? filePath;
  String? fileName;
  int? fileSize;
  bool uploadError = false;
  String errorMessage = '';

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      final file = result.files.single;
      if (file.extension != 'pdf') {
        setState(() {
          uploadError = true;
          errorMessage = 'Please select a PDF file.';
        });
        return;
      }
      setState(() {
        filePath = file.path;
        fileSize = file.size;
        fileName =
            'CV_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}.pdf';
        uploadError = false;
        widget.onFileSelected(filePath);
      });
    } else {
      setState(() {
        uploadError = true;
        errorMessage = 'Error picking file. Please try again.';
      });
    }
  }

  void removeFile() {
    setState(() {
      filePath = null;
      fileName = null;
      fileSize = null;
      uploadError = false;
      errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload CV/Resume',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: filePath == null ? pickFile : null,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: filePath != null
                        ? redColor.withOpacity(0.1)
                        : whiteColor,
                    border: Border.all(
                        color:
                            filePath != null ? Colors.transparent : greyColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: filePath != null
                        ? Row(
                            children: [
                              Icon(Icons.insert_drive_file_sharp,
                                  size: 45, color: redColor),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(fileName!,
                                        style: TextStyle(color: darkColor)),
                                    Text(
                                        '${(fileSize! / 1000).toStringAsFixed(0)} KB',
                                        style: TextStyle(color: greyColor)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close, color: redColor),
                                onPressed: removeFile,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Icon(Icons.upload_file_sharp,
                                  size: 40, color: primaryColor),
                              const SizedBox(height: 8),
                              Text('Browse Files',
                                  style: TextStyle(color: greyColor)),
                            ],
                          ),
                  ),
                ),
              ),
              if (uploadError)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child:
                      Text(errorMessage, style: const TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 16),
              CommanInputField(
                controller: widget.motivationLetterController,
                title: 'Motivation Letter (Optional)',
                hint: "Motivation letter...",
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
