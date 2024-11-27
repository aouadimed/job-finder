import 'dart:io';
import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SimpleProfileForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstnameTextFieldController;
  final TextEditingController lastnameTextFieldController;
  final File? imageFile;
  final String? imageUrl;
  final void Function(File?)? onImageSelected;
  final void Function()? onImageDeleted;

  const SimpleProfileForm({
    Key? key,
    required this.formKey,
    required this.firstnameTextFieldController,
    required this.lastnameTextFieldController,
    required this.imageFile,
    required this.imageUrl,
    required this.onImageSelected,
    required this.onImageDeleted,
  }) : super(key: key);

  @override
  State<SimpleProfileForm> createState() => _SimpleProfileFormState();
}

class _SimpleProfileFormState extends State<SimpleProfileForm> {
  late File? _imageFile;
  late String? _imageUrl;

  final _firstnameFocusNode = FocusNode();
  final _lastnameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
    _imageUrl = widget.imageUrl;
  }

  @override
  void didUpdateWidget(covariant SimpleProfileForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageFile != oldWidget.imageFile ||
        widget.imageUrl != oldWidget.imageUrl) {
      setState(() {
        _imageFile = widget.imageFile;
        _imageUrl = widget.imageUrl;
      });
    }
  }

  @override
  void dispose() {
    _firstnameFocusNode.dispose();
    _lastnameFocusNode.dispose();
    super.dispose();
  }

  Future<void> _getImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      final File image = File(pickedFile.path);
                      setState(() {
                        _imageFile = image;
                        _imageUrl = null;
                      });
                      if (widget.onImageSelected != null) {
                        widget.onImageSelected!(image);
                      }
                    }
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      final File image = File(pickedFile.path);
                      setState(() {
                        _imageFile = image;
                        _imageUrl = null;
                      });
                      if (widget.onImageSelected != null) {
                        widget.onImageSelected!(image);
                      }
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: _imageFile != null
                        ? ClipOval(
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                              width: 150.0,
                              height: 150.0,
                            ),
                          )
                        : (_imageUrl != null && _imageUrl != "undefined"
                            ? ClipOval(
                                child: Image.network(
                                  _imageUrl!,
                                  fit: BoxFit.cover,
                                  width: 150.0,
                                  height: 150.0,
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: primaryColor.withOpacity(0.6),
                                child: Center(
                                  child: Text(
                                    "${widget.firstnameTextFieldController.text.isNotEmpty ? widget.firstnameTextFieldController.text[0].toUpperCase() : '?'}"
                                    " ${widget.lastnameTextFieldController.text.isNotEmpty ? widget.lastnameTextFieldController.text[0].toUpperCase() : '?'}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )),
                  ),
                  if (_imageFile != null || _imageUrl != null)
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _imageFile = null;
                            _imageUrl = null;
                          });
                          if (widget.onImageDeleted != null) {
                            widget.onImageDeleted!();
                          }
                        },
                        icon: (_imageFile != null ||
                                _imageUrl != null && _imageUrl != "undefined")
                            ? Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.red,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: _getImage,
                      icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: primaryColor,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(thickness: 0.5),
              const SizedBox(height: 20),
              InputField(
                controller: widget.firstnameTextFieldController,
                hint: "First name",
                prefixIcon: null,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                focusNode: _firstnameFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_lastnameFocusNode);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              InputField(
                controller: widget.lastnameTextFieldController,
                hint: "Last name",
                prefixIcon: null,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.done,
                focusNode: _lastnameFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
