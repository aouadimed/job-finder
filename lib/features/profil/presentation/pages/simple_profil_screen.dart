import 'dart:io';
import 'package:cv_frontend/features/profil/presentation/bloc/profil_header_bloc/profil_header_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_forms_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/forms/simple_profil_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

class SimpleProfilScreen extends StatefulWidget {
  final File? imageFile;
  final String? imageUrl;
  const SimpleProfilScreen({super.key, this.imageFile, this.imageUrl});

  @override
  State<SimpleProfilScreen> createState() => _SimpleProfilScreenState();
}

class _SimpleProfilScreenState extends State<SimpleProfilScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstnameTextFieldController;
  late TextEditingController _lastnameTextFieldController;
  File? _selectedImageFile;
  String? _selectedImageUrl;
  String? _initialFirstname;
  String? _initialLastname;
  String? _initialImageUrl;

  @override
  void initState() {
    super.initState();
    _selectedImageFile = widget.imageFile;
    _selectedImageUrl = widget.imageUrl;
    _initialImageUrl = widget.imageUrl;
    _firstnameTextFieldController = TextEditingController();
    _lastnameTextFieldController = TextEditingController();
    // Initialize initial values
    _initialFirstname = _firstnameTextFieldController.text;
    _initialLastname = _lastnameTextFieldController.text;
  }

  @override
  void dispose() {
    _lastnameTextFieldController.dispose();
    _firstnameTextFieldController.dispose();
    super.dispose();
  }

  void _revertChanges() {
    setState(() {
      _selectedImageFile = widget.imageFile;
      _selectedImageUrl = _initialImageUrl;
      _firstnameTextFieldController.text = _initialFirstname ?? '';
      _lastnameTextFieldController.text = _initialLastname ?? '';
    });
  }

  Future<void> _showSaveConfirmationDialog(BuildContext context, VoidCallback onSave) async {
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
      },
      onCancelBtnTap: () {
        Navigator.pop(context);
        _revertChanges();
      },
    );
  }

  void _reloadProfileData() {
    context.read<ProfilHeaderBloc>().add(GetProfilHeaderEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfilHeaderBloc, ProfilHeaderState>(
      listener: (context, state) {
        if (state is GetProfilHeaderSuccess) {
          setState(() {
            _firstnameTextFieldController.text = state.profileHeader.firstName;
            _lastnameTextFieldController.text = state.profileHeader.lastName;
            _selectedImageUrl = state.profileHeader.profilImg.isNotEmpty ? state.profileHeader.profilImg : null;
            _initialImageUrl = state.profileHeader.profilImg.isNotEmpty ? state.profileHeader.profilImg : null;
            _selectedImageFile = null; // Reset the file if a URL is available
            // Update initial values
            _initialFirstname = state.profileHeader.firstName;
            _initialLastname = state.profileHeader.lastName;
          });
        }
      },
      child: BlocBuilder<ProfilHeaderBloc, ProfilHeaderState>(
        builder: (context, state) {
          return CommonFormsScreen(
            isLoading: state is ProfilHeaderLoading,
            onSave: () {
              if (_formKey.currentState!.validate()) {
                bool isFirstnameChanged = _firstnameTextFieldController.text != _initialFirstname;
                bool isLastnameChanged = _lastnameTextFieldController.text != _initialLastname;
                bool isImageChanged = _selectedImageFile != null;
                bool isImageDeleted = _selectedImageFile == null && _selectedImageUrl == null && _initialImageUrl != null;

                if (isFirstnameChanged || isLastnameChanged || isImageChanged || isImageDeleted) {
                  _showSaveConfirmationDialog(context, () {
                    if (isFirstnameChanged || isLastnameChanged) {
                      print('Updating text fields: Firstname or Lastname changed');
                      // Call your backend update function for text fields
                    }
                    if (isImageChanged) {
                      print('Updating photo');
                      // Call your backend update function for photo
                    }
                    if (isImageDeleted) {
                      print('Deleting photo');
                      // Call your backend delete function for photo
                    }
                    _reloadProfileData();
                  });
                } else {
                  print('No changes detected');
                }
              }
            },
            title: 'Profile',
            form: SimpleProfileForm(
              formKey: _formKey,
              firstnameTextFieldController: _firstnameTextFieldController,
              lastnameTextFieldController: _lastnameTextFieldController,
              imageFile: _selectedImageFile,
              imageUrl: _selectedImageUrl,
              onImageSelected: (File? image) {
                setState(() {
                  _selectedImageFile = image;
                  _selectedImageUrl = null;
                });
              },
              onImageDeleted: () {
                setState(() {
                  _selectedImageFile = null;
                  _selectedImageUrl = null;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
