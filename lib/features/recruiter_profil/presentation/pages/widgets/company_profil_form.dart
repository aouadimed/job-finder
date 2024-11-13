import 'dart:io';
import 'package:cv_frontend/features/recruiter_profil/presentation/pages/widgets/country_selection_sheet.dart';
import 'package:cv_frontend/global/utils/country_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class CompanyProfilForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController companyNameController;
  final TextEditingController aboutCompanyController;
  final TextEditingController websiteController;
  final TextEditingController countryController;
  final List<TextEditingController> addressControllers;
  final File? logoFile;
  final String? logoUrl;
  final void Function(File?)? onLogoSelected;
  final bool isImageError;

  const CompanyProfilForm({
    Key? key,
    required this.formKey,
    required this.companyNameController,
    required this.aboutCompanyController,
    required this.websiteController,
    required this.countryController,
    required this.addressControllers,
    required this.logoFile,
    required this.logoUrl,
    required this.onLogoSelected,
    required this.isImageError,
  }) : super(key: key);

  @override
  State<CompanyProfilForm> createState() => _CompanyProfilFormState();
}

class _CompanyProfilFormState extends State<CompanyProfilForm> {
  late File? _logoFile;
  late String? _logoUrl;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _logoFile = widget.logoFile;
    _logoUrl = widget.logoUrl;
    _focusNodes = List.generate(6, (index) => FocusNode()); // Create focus nodes for each field
  }

  @override
  void didUpdateWidget(covariant CompanyProfilForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.logoFile != oldWidget.logoFile || widget.logoUrl != oldWidget.logoUrl) {
      setState(() {
        _logoFile = widget.logoFile;
        _logoUrl = widget.logoUrl;
      });
    }
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File image = File(pickedFile.path);
      setState(() {
        _logoFile = image;
        _logoUrl = null; // Clear the URL if a new image is selected
      });
      if (widget.onLogoSelected != null) {
        widget.onLogoSelected!(image);
      }
    }
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
                      border: widget.isImageError ? Border.all(color: redColor, width: 2.0) : null,
                    ),
                    child: _logoFile != null
                        ? ClipOval(
                            child: Image.file(
                              _logoFile!,
                              fit: BoxFit.cover,
                              width: 150.0,
                              height: 150.0,
                            ),
                          )
                        : (_logoUrl != null
                            ? ClipOval(
                                child: Image.network(
                                  _logoUrl!,
                                  fit: BoxFit.cover,
                                  width: 150.0,
                                  height: 150.0,
                                ),
                              )
                            : Icon(
                                Icons.business,
                                color: Colors.grey.shade500,
                                size: 100,
                              )),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: _getImageFromGallery,
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
              if (widget.isImageError)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Please select a logo',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 20),
              const Divider(thickness: 0.5),
              const SizedBox(height: 20),
              InputField(
                controller: widget.companyNameController,
                labelText: "Company Name",
                prefixIcon: null,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                focusNode: _focusNodes[0],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focusNodes[1]);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              InputField(
                controller: widget.websiteController,
                labelText: "Website",
                prefixIcon: null,
                textInputType: TextInputType.url,
                textInputAction: TextInputAction.next,
                focusNode: _focusNodes[1],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focusNodes[2]);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the website';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              InputField(
                controller: widget.countryController,
                labelText: "Select Country",
                prefixIcon: const Icon(Icons.public),
                suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                readOnly: true,
                focusNode: _focusNodes[2],
                onTap: () async {
                  await showModalBottomSheet<String>(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (BuildContext context) {
                      return CountrySelectionSheet(
                        allCountries: allCountries,
                        selectedCountry: widget.countryController.text,
                        onSelect: (String selectedCountry) {
                          setState(() {
                            widget.countryController.text = selectedCountry;
                          });
                        },
                      );
                    },
                  );
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focusNodes[3]);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Column(
                children: List.generate(widget.addressControllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputField(
                            controller: widget.addressControllers[index],
                            labelText: "Address ${index + 1}",
                            prefixIcon: null,
                            textInputType: TextInputType.text,
                            textInputAction: index == widget.addressControllers.length - 1
                                ? TextInputAction.done
                                : TextInputAction.next,
                            focusNode: _focusNodes[index + 4],
                            onFieldSubmitted: (_) {
                              if (index < widget.addressControllers.length - 1) {
                                FocusScope.of(context).requestFocus(_focusNodes[index + 5]);
                              } else {
                                FocusScope.of(context).unfocus();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address ${index + 1}';
                              }
                              return null;
                            },
                          ),
                        ),
                        if (widget.addressControllers.length > 1 || index > 0)
                          IconButton(
                            icon: Icon(Icons.remove_circle, color: redColor),
                            onPressed: () {
                              setState(() {
                                widget.addressControllers.removeAt(index);
                                _focusNodes.removeAt(index + 4);
                              });
                            },
                          ),
                      ],
                    ),
                  );
                }),
              ),
              IconButton(
                icon: Icon(Icons.add_circle, color: primaryColor),
                onPressed: () {
                  if (widget.addressControllers.isNotEmpty &&
                      widget.addressControllers.last.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please fill in the previous address first'),
                        backgroundColor: redColor,
                      ),
                    );
                  } else {
                    setState(() {
                      widget.addressControllers.add(TextEditingController());
                      _focusNodes.add(FocusNode());
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              InputField(
                controller: widget.aboutCompanyController,
                labelText: "About Company",
                prefixIcon: null,
                textInputType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                focusNode: _focusNodes.last,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter details about the company';
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
