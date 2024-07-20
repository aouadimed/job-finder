import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_forms_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/forms/contact_info_form.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/contact_info_bloc/contact_info_bloc.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressTextFieldController = TextEditingController();
  final _phoneNumberTextFieldController = TextEditingController();
  final _emailTextFieldController = TextEditingController();
  late String _userCountry = "";

  @override
  void initState() {
    super.initState();
    context.read<ContactInfoBloc>().add(GetContactInfoEvent());
  }

  @override
  void dispose() {
    _addressTextFieldController.dispose();
    _phoneNumberTextFieldController.dispose();
    _emailTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactInfoBloc, ContactInfoState>(
      listener: (context, state) {
        if (state is GetContactInfoSuccess) {
          setState(() {
            _userCountry = state.contactInfoModel.country!;
            _addressTextFieldController.text =
                state.contactInfoModel.address ?? '';
            _phoneNumberTextFieldController.text =
                state.contactInfoModel.phone ?? '';
            _emailTextFieldController.text = state.contactInfoModel.email ?? '';
          });
        } else if (state is ContactInfoFailure) {
          showSnackBar(
            context: context,
            message: state.message,
            backgroundColor: redColor,
          );
        } else if (state is UpdateContactInfoSuccess) {
          showSnackBar(
            context: context,
            message: "Contact information updated successfully",
            backgroundColor: greenColor,
          );
        }
      },
      child: BlocBuilder<ContactInfoBloc, ContactInfoState>(
        builder: (context, state) {
          return CommonFormsScreen(
            isLoading: state is ContactInfoLoading,
            title: "Contact Information",
            form: ContactInfoForm(
              formKey: _formKey,
              addressTextFieldController: _addressTextFieldController,
              phoneNumberTextFieldController: _phoneNumberTextFieldController,
              emailTextFieldController: _emailTextFieldController,
              userCountry: _userCountry,
            ),
            onSave: () {
                if (_formKey.currentState!.validate()) {
              BlocProvider.of<ContactInfoBloc>(context).add(
                UpdateContactInfoEvent(
                    address: _addressTextFieldController.text,
                    phone: _phoneNumberTextFieldController.text,
                    email: _emailTextFieldController.text),
              );
                }
            },
          );
        },
      ),
    );
  }
}
