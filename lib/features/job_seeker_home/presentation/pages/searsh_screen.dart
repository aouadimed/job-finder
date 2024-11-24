import 'dart:async';

import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_detail_bloc/job_detail_bloc.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/job_details_screen.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/filter_job_offer_use_case.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/save_job_bloc/save_job_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/searsh_page_bloc/search_page_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/filter_page.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/job_card.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/job_card_skeleton.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/global/utils/location_type_data.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/categorie_selection_model.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';

class SearchScreen extends StatefulWidget {
  final bool autofocus;
  final Color iconColor;
  final String? selectedCategoryId;
  final FilterJobOfferParams? params;
  final bool? fromFilterScreen;
  final bool? forSearch;

  const SearchScreen({
    Key? key,
    required this.autofocus,
    required this.iconColor,
    this.selectedCategoryId,
    this.params,
    this.fromFilterScreen = false,
    this.forSearch = false,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TextEditingController _searchController;
  late AnimationController _secondMoveController;
  late Animation<double> _secondMoveAnimation;
  final GlobalKey _fromKey = GlobalKey();
  final GlobalKey _menuIconKey = GlobalKey();
  List<CategorySelectionModel> categorySelectionModel = [];
  Offset? _fromPosition;
  Offset? _menuIconPosition;
  List<JobOffer> jobOffers = [];
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMorePages = true;
  late ScrollController _scrollController;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();

    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchTextChanged);

    _secondMoveController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _secondMoveAnimation = CurvedAnimation(
      parent: _secondMoveController,
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _fromPosition = getPositionByKey(_fromKey);
        _menuIconPosition = getPositionByKey(_menuIconKey);
      });
      _secondMoveController.forward();
    });
    if (widget.forSearch == true) {
      _triggerSearch();
      _triggerSearchNofilter();
    } else {
      _triggerSearch();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _secondMoveController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Offset getPositionByKey(GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return Offset.zero;
    } else {
      return renderBox.localToGlobal(Offset.zero);
    }
  }

  void _triggerSearch() {
    context.read<SearchPageBloc>().add(
          FilterJobOfferEvent(
            params: FilterJobOfferParams(
              page: _currentPage,
              location: widget.params!.location,
              workTypeIndexes: widget.params!.workTypeIndexes,
              jobLevel: widget.params!.jobLevel,
              employmentTypeIndexes: widget.params!.employmentTypeIndexes,
              experience: widget.params!.experience,
              education: widget.params!.education,
              jobFunctionIds: widget.params!.jobFunctionIds,
              searchQuery: _searchController.text.trim(),
            ),
          ),
        );
  }

  void _triggerSearchNofilter() {
    context.read<SearchPageBloc>().add(
          FilterJobOfferEvent(
            params: FilterJobOfferParams(
              page: _currentPage,
              location: '',
              workTypeIndexes: const [],
              jobLevel: const [],
              employmentTypeIndexes: const [],
              experience: const [],
              education: const [],
              jobFunctionIds: const [],
              searchQuery: _searchController.text.trim(),
            ),
          ),
        );
  }

  Widget buildContainerImage({double size = 70}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor,
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9 &&
        !_isLoadingMore &&
        _hasMorePages) {
      _loadMore();
    }
  }

  void _onSearchTextChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        _currentPage = 1;
        jobOffers.clear();
      });
      _triggerSearch();
    });
  }

  void _loadMore() {
    setState(() {
      _isLoadingMore = true;
    });

    _currentPage++;
    context.read<SearchPageBloc>().add(
          FilterJobOfferEvent(
            params: FilterJobOfferParams(
              page: _currentPage,
              location: widget.params!.location,
              workTypeIndexes: widget.params!.workTypeIndexes,
              jobLevel: widget.params!.jobLevel,
              employmentTypeIndexes: widget.params!.employmentTypeIndexes,
              experience: widget.params!.experience,
              education: widget.params!.education,
              jobFunctionIds: widget.params!.jobFunctionIds,
              searchQuery: _searchController.text.trim(),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        titleText: 'Job Offers',
      ),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<SearchPageBloc, SearchPageState>(
                listener: (context, state) {
              if (state is SearchPageFailure) {
                showSnackBar(context: context, message: state.message);
              } else if (state is FilterJobOfferSuccess) {
                setState(() {
                  jobOffers.addAll(state.jobCardModel.jobOffers!);
                  _isLoadingMore = false;
                  _hasMorePages = _currentPage < state.jobCardModel.totalPages!;
                });
              }
            }),
          ],
          child: BlocBuilder<SearchPageBloc, SearchPageState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Hero(
                        tag: 'searchBar',
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InputField(
                              key: _fromKey,
                              controller: _searchController,
                              autofocus: widget.autofocus,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  if (widget.fromFilterScreen == false) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) =>
                                              sl<CategoryBloc>()
                                                ..add(GetCategoryEvent()),
                                          child: const FilterScreen(),
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) =>
                                              sl<CategoryBloc>()
                                                ..add(GetCategoryEvent()),
                                          child: FilterScreen(
                                            params: widget.params,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: Icon(Icons.menu,
                                      key: UniqueKey(),
                                      color: widget.iconColor),
                                ),
                              ),
                              hint: "Search",
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.grey),
                              textInputType: TextInputType.text,
                            ),
                          ),
                        ),
                      ),
                      Hero(
                        tag:
                            'category-//${widget.selectedCategoryId ?? 'none'}',
                        flightShuttleBuilder: (flightContext, animation,
                            flightDirection, fromHeroContext, toHeroContext) {
                          if (_fromPosition == null ||
                              _menuIconPosition == null) return Container();

                          final double x =
                              flightDirection == HeroFlightDirection.push
                                  ? _menuIconPosition!.dx - _fromPosition!.dx
                                  : _fromPosition!.dx - _menuIconPosition!.dx;
                          final double y =
                              flightDirection == HeroFlightDirection.push
                                  ? _menuIconPosition!.dy - _fromPosition!.dy
                                  : _fromPosition!.dy - _menuIconPosition!.dy;

                          return AnimatedBuilder(
                            animation: _secondMoveAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  x * _secondMoveAnimation.value,
                                  y * _secondMoveAnimation.value,
                                ),
                                child: Center(
                                  heightFactor: .9,
                                  child: buildContainerImage(size: 70),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          key: UniqueKey(),
                          color: Colors.transparent,
                        ),
                      ),
                      if (state is SearchPageLoading && _currentPage == 1)
                        Expanded(
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) =>
                                const JobCardSkeleton(),
                          ),
                        ),
                      Expanded(
                        child: jobOffers.isEmpty && state is! SearchPageLoading
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 100,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "No job offers match",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Try adjusting your filters or search terms to find more opportunities.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[500],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount:
                                    jobOffers.length + (_isLoadingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index >= jobOffers.length) {
                                    return const JobCardSkeleton();
                                  }
                                  final job = jobOffers[index];
                                  return BlocProvider(
                                    create: (context) => sl<SavedJobBloc>()
                                      ..add(CheckSavedJobEvent(id: job.id!)),
                                    child: BlocConsumer<SavedJobBloc,
                                        SavedJobState>(
                                      listener: (context, state) {
                                        if (state is SavedJobFailure) {
                                          showSnackBar(
                                              context: context,
                                              message: state.message);
                                        }
                                      },
                                      builder: (context, state) {
                                        bool isSaved = false;
                                        if (state is SavedJobCheckSuccess) {
                                          isSaved = state.isSaved;
                                        } else if (state
                                            is SavedJobSaveSuccess) {
                                          isSaved = state.isSaved;
                                        }

                                        return JobCard(
                                          companyName: job.companyName!,
                                          jobTitle: job.subcategoryName!,
                                          location: job.companyCountry!,
                                          items: [
                                            job.employmentTypeIndex != null
                                                ? employmentTypes[
                                                    job.employmentTypeIndex!]
                                                : 'Unknown Employment Type',
                                            job.locationTypeIndex != null
                                                ? locationTypes[
                                                    job.locationTypeIndex!]
                                                : 'Unknown Location Type',
                                          ],
                                          companyLogoUrl: job.logoName!,
                                          onSave: () {
                                            if (isSaved) {
                                              context.read<SavedJobBloc>().add(
                                                  RemoveSavedJobEvent(
                                                      id: job.id!));
                                            } else {
                                              context.read<SavedJobBloc>().add(
                                                  SaveJobOfferEvent(
                                                      id: job.id!));
                                            }
                                          },
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                  create: (context) =>
                                                      sl<JobDetailBloc>()
                                                        ..add(GetJobDetailEvent(
                                                            id: job.id!)),
                                                  child:
                                                      const JobDetailsScreen(),
                                                ),
                                              ),
                                            ).then(
                                              (_) {
                                                if (context.mounted) {
                                                  BlocProvider.of<SavedJobBloc>(
                                                          context)
                                                      .add(CheckSavedJobEvent(
                                                          id: job.id!));
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
                              ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
