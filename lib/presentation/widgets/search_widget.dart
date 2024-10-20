import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';

import '../theme/dimen.dart';
import '../theme/theme_colors.dart';

class SearchWidget<T extends BaseSearchViewModel> extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchWidget(this.onSearch, this.prefixCallback,
      {this.isSmallPad = false,
      this.sized = true,
      this.needTopPadding = true,
      this.actions = const [],
      this.navigateUpCallback,
      this.needBottomEdge = false,
      this.backArg,
      this.needBackButton = true,
      super.key});
  final bool needBackButton;
  final dynamic backArg;
  final Function(String?) onSearch;
  final List<Widget> actions;
  final bool sized;
  final bool needBottomEdge;
  final bool isSmallPad;
  final bool needTopPadding;

  final Function() prefixCallback;
  final Function()? navigateUpCallback;

  @override
  Widget build(BuildContext context) {
    var vm = context.read<T>();
    var searchEnabled = context.watch<T>().searchEnabled;

    var clearEnabled = context.watch<T>().clearEnabled;
    return searchEnabled
        ? AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0,
            elevation: 0,
            shape: needBottomEdge
                ? const Border(
                    bottom: BorderSide(
                        color: AppColor.appBarSeparator, width: Dimen.size1))
                : null,
            leadingWidth: Dimen.size40,
            leading: needBackButton
                ? CupertinoButton(
                    padding: const EdgeInsets.only(left: Dimen.size16),
                    child:
                        const Icon(Icons.arrow_back, color: AppColor.primary),
                    onPressed: () {
                      vm.setSearchEnabled();
                      vm.searchController.clear();
                      onSearch(vm.searchController.text);
                    })
                : null,
            actions: [
              CupertinoButton(
                  padding: const EdgeInsets.only(right: Dimen.size16),
                  onPressed: !clearEnabled
                      ? () {
                          vm.setSearchEnabled();
                        }
                      : () {
                          if(vm.searchController.text.isEmpty && !needBackButton) vm.setSearchEnabled();
                          vm.searchController.clear();
                          onSearch(vm.searchController.text);
                        },
                  child: !clearEnabled
                      ? const Icon(Icons.search, color: AppColor.primary)
                      : const Icon(Icons.close,
                          color: AppColor.primary, size: 18))
            ],
            title: Padding(
                padding: const EdgeInsets.only(right: Dimen.size16),
                child: CupertinoTextField(
                    focusNode: vm.node,
                    showCursor: searchEnabled,
                    autofocus: false,
                    placeholder: "Введите текст",
                    padding:
                        const EdgeInsets.symmetric(horizontal: Dimen.size12),
                    decoration: const BoxDecoration(color: Colors.transparent),
                    controller: vm.searchController,
                    onChanged: (s) {
                      onSearch(s);
                      vm.updateClearEnabled();
                    })))
        : AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: needBottomEdge
                ? const Border(
                    bottom: BorderSide(
                        color: Color(0xFFE6E6E6), width: Dimen.size1))
                : null,
            actions: [
              ...actions,
              CupertinoButton(
                  padding: const EdgeInsets.only(right: Dimen.size16),
                  child: const Icon(Icons.search, color: AppColor.primary),
                  onPressed: () {
                    vm.setSearchEnabled();
                  })
            ],
            leadingWidth: Dimen.size40,
            leading: needBackButton
                ? CupertinoButton(
                    padding: const EdgeInsets.only(left: Dimen.size16),
                    onPressed: navigateUpCallback ??
                        () => context.navigateUp(arg: backArg),
                    child:
                        const Icon(Icons.arrow_back, color: AppColor.primary))
                : null,
            title: titleWidget(context));
  }

  Widget? titleWidget(BuildContext context) {
    var atLineSubTitle = context.watch<T>().atLineSubTitle;
    var subTitle = context.watch<T>().subTitle;
    var title = context.watch<T>().title;
    if (title.isEmpty && subTitle == null) {
      return null;
    }
    if (subTitle == null) {
      if (atLineSubTitle != null) {
        return Row(children: [
          Text(title,
              style: GoogleFonts.notoSans(
                  color: Colors.black,
                  fontSize: Dimen.size20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15)),
          const SizedBox(width: Dimen.size6),
          Text(atLineSubTitle,
              style: GoogleFonts.notoSans(
                  color: AppColor.basicDarkGrey, fontSize: Dimen.size20))
        ]);
      }
      return title.isNotEmpty
          ? Text(title,
              style: GoogleFonts.notoSans(
                  color: Colors.black,
                  fontSize: Dimen.size20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15))
          : const SizedBox();
    } else {
      return Column(children: [
        Row(children: [
          if (atLineSubTitle == null)
            Expanded(
                child: Text(title,
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: Dimen.size20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15))),
          if (atLineSubTitle != null)
            Expanded(
                child: Row(children: [
              Text(title,
                  style: GoogleFonts.notoSans(
                      color: Colors.black,
                      fontSize: Dimen.size20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15)),
              const SizedBox(width: Dimen.size6),
              Text(atLineSubTitle,
                  style: GoogleFonts.notoSans(color: AppColor.basicDarkGrey))
            ]))
        ]),
        Row(children: [
          Expanded(
              child: Text(subTitle,
                  style: GoogleFonts.notoSans(
                      color: AppColor.basicDarkGrey, fontSize: 13)))
        ])
      ]);
    }
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
