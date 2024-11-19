import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_detail_bloc/job_detail_bloc.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/job_details_screen.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/categorie_selection_model.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/profil_percentage_model.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/profil_percentage_bloc/profil_percentage_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/save_job_bloc/save_job_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/filter_page.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/searsh_screen.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/category_selecion.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/category_selection_skeleton.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/job_card_skeleton.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/persentage_profil.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/persentage_profil_skeleton.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/global/utils/location_type_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/job_card.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  late ScrollController _scrollController;
  late ScrollController _categoryScrollController;
  double _savedScrollPosition = 0.0;

  List<CategorySelectionModel> categorySelectionModel = [];
  CompletionPercentage completionPercentage =
      CompletionPercentage(completionPercentage: 100, errors: [], message: '');
  List<JobOffer> jobCardModel = [];
  String? _selectedCategoryId;

  int _currentPage = 1;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _categoryScrollController = ScrollController();
    _selectedCategoryId = '';

    _fetchJobOffers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore &&
          _currentPage < totalPages) {
        _fetchMoreJobOffers();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _categoryScrollController.dispose();
    super.dispose();
  }

  Future<void> _navigateToSearchScreen(String? categoryId) async {
    _savedScrollPosition = _scrollController.position.pixels;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => sl<CategoryBloc>()..add(GetCategoryEvent()),
          child: SearchScreen(
            autofocus: false,
            iconColor: primaryColor,
            selectedCategoryId: categoryId,
          ),
        ),
      ),
    );
    setState(() {
      _selectedCategoryId = null;
    });
    _scrollController.jumpTo(_savedScrollPosition);
    _categoryScrollController.jumpTo(0.0);
  }

  void _fetchJobOffers() {
    setState(() {
      _isLoading = true;
      _currentPage = 1;
      jobCardModel.clear();
    });

    BlocProvider.of<HomeBloc>(context)
        .add(GetRecentJobOffer(page: _currentPage));
  }

  void _fetchMoreJobOffers() {
    if (_currentPage < totalPages && !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });

      BlocProvider.of<HomeBloc>(context)
          .add(GetRecentJobOffer(page: _currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        logo: AssetImage("assets/images/logo.webp"),
        titleText: 'Job Finder',
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Hero(
                    tag: 'searchBar',
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InputField(
                          controller: _searchController,
                          readOnly: true,
                          hint: "Search",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => 
                                   FilterScreen(),
                                ),
                              );
                            },
                            child: const Icon(Icons.menu, color: Colors.grey),
                          ),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          textInputType: TextInputType.text,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => sl<CategoryBloc>()
                                    ..add(GetCategoryEvent()),
                                  child: const SearchScreen(
                                    autofocus: true,
                                    iconColor: Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  BlocConsumer<ProfilPercentageBloc, ProfilPercentageState>(
                    listener: (context, state) {
                      if (state is ProfilPercentageFailure) {
                        showSnackBar(context: context, message: state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is ProfilPercentageLoading) {
                        return const ProfileCompletionSkeleton();
                      } else if (state is ProfilPercentageSuccess) {
                        completionPercentage = state.completionPercentage;
                      }

                      return ProfileCompletionWidget(
                        completionPercentage:
                            completionPercentage.completionPercentage,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Recommendation",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {},
                          child: Text(
                            "See All",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 350,
                          child: JobCard(
                            companyName: 'Google LLC',
                            jobTitle: 'UI/UX Designer',
                            location: 'California, United States',
                            items: const ['Full Time', 'hybrid'],
                            companyLogoUrl:
                                'https://logo.clearbit.com/google.com',
                            onSave: () {
                              print('Job saved');
                              // Implement your save logic here
                            },
                            onTap: () {},
                            isSaved: false,
                          ),
                        ),
                        SizedBox(
                          width: 350,
                          child: JobCard(
                            companyName: 'Google LLC',
                            jobTitle: 'UI/UX Designer',
                            location: 'California, United States',
                            items: ['Full Time', 'hybrid'],
                            companyLogoUrl:
                                'https://logo.clearbit.com/google.com',
                            onSave: () {
                              print('Job saved');
                              // Implement your save logic here
                            },
                            onTap: () {},
                            isSaved: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 100.0,
                maxHeight: 100.0,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Recent Jobs",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => {},
                              child: Text(
                                "See All",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        BlocConsumer<CategoryBloc, CategoryState>(
                          listener: (context, state) {
                            if (state is CategoryFailure) {
                              showSnackBar(
                                  context: context, message: state.message);
                            }
                          },
                          builder: (context, state) {
                            if (state is CategoryLoading) {
                              return const ChipWidgetCategorySelectionSkeleton();
                            } else if (state is JobCategorySuccess) {
                              categorySelectionModel =
                                  state.categorySelectionModel;
                            }

                            return Hero(
                              tag: 'category-${_selectedCategoryId ?? 'none'}',
                              child: SingleChildScrollView(
                                controller: _categoryScrollController,
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: ChipWidgetCategorySelection(
                                      items: categorySelectionModel,
                                      onSelected: (String? categoryId) {
                                        setState(() {
                                          _selectedCategoryId = categoryId;
                                        });
                                        _navigateToSearchScreen(categoryId);
                                      },
                                      selectedCategoryId: _selectedCategoryId,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeFailure) {
                  showSnackBar(context: context, message: state.message);
                } else if (state is GetJobOfferSuccess) {
                  setState(() {
                    final newJobOffers = state.jobCardModel.jobOffers!;
                    for (var offer in newJobOffers) {
                      if (!jobCardModel.any(
                          (existingOffer) => existingOffer.id == offer.id)) {
                        jobCardModel.add(offer);
                      }
                    }
                    totalPages = state.jobCardModel.totalPages!;
                    _isLoading = false;
                    _isLoadingMore = false;
                  });
                }
              },
              builder: (context, state) {
                if (_isLoading && _currentPage == 1) {
                  return const SliverToBoxAdapter(
                    child: Center(child: JobCardSkeleton()),
                  );
                } else if (jobCardModel.isNotEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == jobCardModel.length - 1 &&
                            _isLoadingMore) {
                          return const Center(child: JobCardSkeleton());
                        }
                        final jobOffer = jobCardModel[index];
                        List<String> items = [
                          jobOffer.employmentTypeIndex != null
                              ? employmentTypes[jobOffer.employmentTypeIndex!]
                              : 'Unknown Employment Type',
                          jobOffer.locationTypeIndex != null
                              ? locationTypes[jobOffer.locationTypeIndex!]
                              : 'Unknown Location Type',
                        ];

                        return BlocProvider(
                          create: (context) => sl<SavedJobBloc>()
                            ..add(CheckSavedJobEvent(id: jobOffer.id!)),
                          child: BlocConsumer<SavedJobBloc, SavedJobState>(
                            listener: (context, state) {
                              if (state is SavedJobFailure) {
                                showSnackBar(
                                    context: context, message: state.message);
                              }
                            },
                            builder: (context, state) {
                              bool isSaved = false;
                              if (state is SavedJobCheckSuccess) {
                                isSaved = state.isSaved;
                              } else if (state is SavedJobSaveSuccess) {
                                isSaved = state.isSaved;
                              }

                              return JobCard(
                                companyName: jobOffer.companyName!,
                                jobTitle: jobOffer.subcategoryName!,
                                location: jobOffer.companyCountry!,
                                items: items,
                                companyLogoUrl: jobOffer.logoName!,
                                onSave: () {
                                  if (isSaved) {
                                    context.read<SavedJobBloc>().add(
                                        RemoveSavedJobEvent(id: jobOffer.id!));
                                  } else {
                                    context.read<SavedJobBloc>().add(
                                        SaveJobOfferEvent(id: jobOffer.id!));
                                  }
                                },
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => sl<JobDetailBloc>()
                                          ..add(GetJobDetailEvent(
                                              id: jobOffer.id!)),
                                        child: const JobDetailsScreen(),
                                      ),
                                    ),
                                  ).then(
                                    (_) {
                                      if (context.mounted) {
                                        BlocProvider.of<SavedJobBloc>(context)
                                            .add(CheckSavedJobEvent(
                                                id: jobOffer.id!));
                                      }
                                    },
                                  );
                                },
                                isSaved: isSaved,
                                isLoading: state is SavedJobLoading,
                              );
                            },
                          ),
                        );
                      },
                      childCount: jobCardModel.length,
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('No job offers available.')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
