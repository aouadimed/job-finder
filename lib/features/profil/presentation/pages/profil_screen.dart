import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/contact_inforamtion_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/summary_card.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  void goTosummaryScreen(BuildContext context) {
    Navigator.pushNamed(context, summaryScreen);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SummaryBloc>(),
      child: Scaffold(
        appBar: GeneralAppBar(
          titleText: "Profile",
          logo: AssetImage('assets/images/logo.webp'),
          rightIcon: Icons.settings_outlined,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          'https://scontent.ftun16-1.fna.fbcdn.net/v/t39.30808-6/296855862_1064595580855302_2283130187122707458_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=5f2048&_nc_ohc=CqgPSXHsB20Q7kNvgGiyZxs&_nc_ht=scontent.ftun16-1.fna&oh=00_AYDMxzhO2Av1JXoF6xBUVcc6g-8hO-OyCgwnHTbzeBloJw&oe=66706A35'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mohamed Aouadi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'UI/UX Designer at Paypal Inc.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.edit, color: primaryColor),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 0.5,),
              ),
              ContactInformationCard(),
              Summary(
                iconOnPressed: () {
                  goTosummaryScreen(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
