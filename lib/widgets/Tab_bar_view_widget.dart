import 'package:flutter/material.dart';
import 'package:library_app/resourses/dimens.dart';

class TabBarViewWidget extends StatelessWidget {
  const TabBarViewWidget({
    Key? key,
    required this.tabController,
    required this.tabItems,
    required this.onTap,
  }) : super(key: key);

  final TabController tabController;
  final List<Tab> tabItems;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXXXL_LARGE,
      child: TabBar(
        onTap: (index) {
          onTap(index);
        },
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        splashBorderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        labelColor: Colors.black,
        tabs: tabItems,
      ),
    );
  }
}
