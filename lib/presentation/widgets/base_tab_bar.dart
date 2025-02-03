import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';

class BaseTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;
  final Function(int) onTabSelect;
  final String selectedTab;
  final TabController controller;

  const BaseTabBar(
      this.tabs, this.onTabSelect, this.selectedTab, this.controller,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:
                    BorderSide(color: Color(0xFFE6E6E6), width: Dimen.size1))),
        child: TabBar(
            controller: controller,
            onTap: onTabSelect,
            indicator: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Dimen.size12)),
              gradient: LinearGradient(
                  colors: [AppColor.lightBlue, AppColor.darkBlue],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.only(
                left: Dimen.size16,
                right: Dimen.size16,
                top: Dimen.size7,
                bottom: Dimen.size9),
            padding: EdgeInsets.zero,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: AppColor.basicDarkGrey,
            labelStyle: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                fontSize: Dimen.size14,
                color: AppColor.basicDarkGrey),
            tabs:
                tabs.map((e) => Tab(text: e, height: Dimen.size52)).toList()));
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
