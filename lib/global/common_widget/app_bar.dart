import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final ImageProvider? logo;
  final IconData? rightIcon;
  final Widget? rightIconWidget;
  final VoidCallback? rightIconOnPressed;
  final Color? rightIconColor;
  final List<Widget>? actions;
  final bool? closeicon;
  final bool? haveReturn;
  const GeneralAppBar({
    Key? key,
    this.titleText,
    this.logo,
    this.rightIcon,
    this.rightIconWidget,
    this.rightIconOnPressed,
    this.rightIconColor,
    this.actions,
    this.closeicon = false,
    this.haveReturn = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      forceMaterialTransparency: true,
      elevation: 0,
      leading: _buildLeadingIcon(context),
      title: Text(
        titleText ?? '',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: (actions != null)
          ? actions
          : [
              if (rightIconWidget != null)
                GestureDetector(
                  onTap: rightIconOnPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: rightIconWidget!,
                  ),
                )
              else if (rightIcon != null)
                IconButton(
                  icon: Icon(
                    rightIcon,
                    color: rightIconColor ?? Colors.black,
                  ),
                  onPressed: rightIconOnPressed,
                )
            ],
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    if (logo != null) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(image: logo!),
        ),
      );
    } else if (haveReturn == true) {
      return IconButton(
        icon: Icon(
          closeicon == true ? Icons.close : Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      return Container();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
