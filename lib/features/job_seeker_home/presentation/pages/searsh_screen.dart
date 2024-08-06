import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/categorie_selection_model.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';

class SearchScreen extends StatefulWidget {
  final bool autofocus;
  final Color iconColor;
  final String? selectedCategoryId;

  const SearchScreen({
    Key? key,
    required this.autofocus,
    required this.iconColor,
    this.selectedCategoryId,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  late TextEditingController _searchController;
  late AnimationController _secondMoveController;
  late Animation<double> _secondMoveAnimation;
  final GlobalKey _fromKey = GlobalKey();
  final GlobalKey _menuIconKey = GlobalKey();
  List<CategorySelectionModel> categorySelectionModel = [];
  Offset? _fromPosition;
  Offset? _menuIconPosition;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

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
  }

  @override
  void dispose() {
    _searchController.dispose();
    _secondMoveController.dispose();
    super.dispose();
  }

  Offset getPositionByKey(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return Offset.zero;
    } else {
      return renderBox.localToGlobal(Offset.zero);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(),
      body: SafeArea(
        child: BlocListener<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryFailure) {
              showSnackBar(context: context, message: state.message);
            } else if (state is JobCategorySuccess) {
              setState(() {
                categorySelectionModel = state.categorySelectionModel;
              });
            }
          },
          child: BlocBuilder<CategoryBloc, CategoryState>(
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
                              suffixIcon: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Icon(Icons.menu, key: UniqueKey(), color: widget.iconColor),
                              ),
                              hint: "Search",
                              prefixIcon: const Icon(Icons.search, color: Colors.grey),
                              textInputType: TextInputType.text,
                            ),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'category-${widget.selectedCategoryId ?? 'none'}',
                        flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                          if (_fromPosition == null || _menuIconPosition == null) return Container();

                          final double x = flightDirection == HeroFlightDirection.push
                              ? _menuIconPosition!.dx - _fromPosition!.dx
                              : _fromPosition!.dx - _menuIconPosition!.dx;
                          final double y = flightDirection == HeroFlightDirection.push
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
                      // Additional content for category results, etc.
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
