import 'dart:io';
import 'package:cv_frontend/features/recruiter_applications/data/models/company_model.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/company_bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_forms_screen.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/company_profil_form.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:quickalert/quickalert.dart';

class CompanyProfilScreen extends StatefulWidget {
  final File? logoFile;
  final String? logoUrl;

  const CompanyProfilScreen({Key? key, this.logoFile, this.logoUrl})
      : super(key: key);

  @override
  State<CompanyProfilScreen> createState() => _CompanyProfilScreenState();
}

class _CompanyProfilScreenState extends State<CompanyProfilScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _companyNameController;
  late TextEditingController _aboutCompanyController;
  late TextEditingController _websiteController;
  late TextEditingController _countryController;
  late List<TextEditingController> _addressControllers;

  File? _selectedLogoFile;
  String? _selectedLogoUrl;
  File? _initialLogoFile;
  String? _initialLogoUrl;
  String? _initialCompanyName;
  String? _initialAboutCompany;
  String? _initialWebsite;
  String? _initialCountry;
  List<String> _initialAddresses = [];
  bool _isImageError = false;

  @override
  void initState() {
    super.initState();
    _selectedLogoFile = widget.logoFile;
    _selectedLogoUrl = widget.logoUrl;
    _initialLogoFile = widget.logoFile;
    _initialLogoUrl = widget.logoUrl;

    _companyNameController = TextEditingController();
    _aboutCompanyController = TextEditingController();
    _websiteController = TextEditingController();
    _countryController = TextEditingController();
    _addressControllers = [TextEditingController()];
    _refresh();
  }

  void _refresh() {
    BlocProvider.of<CompanyBloc>(context).add(GetCompaniesEvent());
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _aboutCompanyController.dispose();
    _websiteController.dispose();
    _countryController.dispose();
    for (var controller in _addressControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _revertChanges() {
    setState(() {
      _selectedLogoFile = _initialLogoFile;
      _selectedLogoUrl = _initialLogoUrl;
      _companyNameController.text = _initialCompanyName ?? '';
      _aboutCompanyController.text = _initialAboutCompany ?? '';
      _websiteController.text = _initialWebsite ?? '';
      _countryController.text = _initialCountry ?? '';
      for (var i = 0; i < _addressControllers.length; i++) {
        _addressControllers[i].text = _initialAddresses.length > i ? _initialAddresses[i] : '';
      }
    });
  }

  Future<void> _showSaveConfirmationDialog(
      BuildContext context, VoidCallback onSave) async {
    if (_isDataChanged()) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: 'Confirm Save',
        text: 'Are you sure you want to save changes?',
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        onConfirmBtnTap: () {
          Navigator.pop(context);
          onSave();
          _refresh();
        },
        onCancelBtnTap: () {
          Navigator.pop(context);
          _revertChanges();
        },
      );
    } else {
      showSnackBar(
        context: context,
        message: "No changes made to save.",
        backgroundColor: Colors.yellow[700],
      );
    }
  }

  bool _isDataChanged() {
    return _selectedLogoFile != _initialLogoFile ||
        _selectedLogoUrl != _initialLogoUrl ||
        _companyNameController.text != _initialCompanyName ||
        _aboutCompanyController.text != _initialAboutCompany ||
        _websiteController.text != _initialWebsite ||
        _countryController.text != _initialCountry ||
        _addressControllers.any((controller) => controller.text.isNotEmpty && !_initialAddresses.contains(controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyBloc, CompanyState>(
      listener: (context, state) {
        if (state is CompanyFailure) {
          showSnackBar(context: context, message: state.message);
        } else if (state is CompanySuccess) {
          showSnackBar(
              context: context,
              message: "Saved Successfully",
              backgroundColor: greenColor);
        } else if (state is CompaniesLoaded) {
          final company = state.companies;
          _initialCompanyName = company.companyName;
          _initialAboutCompany = company.aboutCompany;
          _initialWebsite = company.website;
          _initialCountry = company.country;
          _initialAddresses = company.addresses!.map((e) => e.address!).toList();

          _companyNameController.text = company.companyName ?? '';
          _aboutCompanyController.text = company.aboutCompany ?? '';
          _websiteController.text = company.website ?? '';
          _countryController.text = company.country ?? '';

          _addressControllers.clear();
          for (var address in company.addresses!) {
            _addressControllers
                .add(TextEditingController(text: address.address));
          }

          _selectedLogoUrl = company.logoName;
          _initialLogoUrl = company.logoName;
        }
      },
      child: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          return CommonFormsScreen(
            isLoading: state is CompanyLoading,
            onSave: () {
              if (_selectedLogoFile == null && _selectedLogoUrl == null) {
                setState(() {
                  _isImageError = true;
                });
              }
              if (_formKey.currentState!.validate()) {
                List<Address> addresses = _addressControllers.map((controller) {
                  return Address(address: controller.text);
                }).toList();

                CompanyProfileModel companyProfileModel = CompanyProfileModel(
                    companyName: _companyNameController.text,
                    aboutCompany: _aboutCompanyController.text,
                    website: _websiteController.text,
                    country: _countryController.text,
                    addresses: addresses,
                    logoName: _selectedLogoFile?.path);

                _showSaveConfirmationDialog(context, () {
                  BlocProvider.of<CompanyBloc>(context).add(
                    AddCompanyEvent(companyProfileModel: companyProfileModel),
                  );
                });
              }
            },
            title: 'Company Profile',
            form: CompanyProfilForm(
              formKey: _formKey,
              companyNameController: _companyNameController,
              aboutCompanyController: _aboutCompanyController,
              websiteController: _websiteController,
              countryController: _countryController,
              addressControllers: _addressControllers,
              logoFile: _selectedLogoFile,
              logoUrl: _selectedLogoUrl,
              onLogoSelected: (File? image) {
                setState(() {
                  _selectedLogoFile = image;
                  _selectedLogoUrl = null;
                  _isImageError = false;
                });
              },
              isImageError: _isImageError,
            ),
          );
        },
      ),
    );
  }
}
