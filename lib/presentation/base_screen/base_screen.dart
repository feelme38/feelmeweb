import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:feelmeweb/core/enum/loading_state.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/presentation/alert/alert_widget.dart';
import 'package:feelmeweb/presentation/widgets/loading_overlay.dart';

import '../alert/alert.dart';
import '../base_vm/base_view_model.dart';
import '../theme/dimen.dart';
import '../theme/theme_colors.dart';

class BaseScreen<T extends BaseViewModel> extends StatelessWidget {
  final bool needBackButton;
  final Widget? child;
  final List<Widget> actions;
  final dynamic backArg;
  final Color? backgroundColor;
  final bool needExtraSpaceTitle;
  final bool needAppBar;
  final Function()? onBack;
  final bool needResize;
  final bool needBottomEdge;
  final bool safeBottom;
  final Color? subBackgroundColor;
  final Color appbarColor;
  final PreferredSizeWidget? appBar;
  final FloatingActionButton? floatingActionButton;

  const BaseScreen(
      {this.needBackButton = true,
      this.backgroundColor = Colors.white,
      this.needExtraSpaceTitle = true,
      this.actions = const [],
      this.needResize = false,
      this.needBottomEdge = true,
      this.safeBottom = false,
      this.appbarColor = Colors.white,
      this.child,
      this.subBackgroundColor,
      this.onBack,
      this.appBar,
      this.needAppBar = true,
      this.backArg,
      this.floatingActionButton,
      super.key});

  @override
  Widget build(BuildContext context) {
    return subBackgroundColor == null
        ? scaffold(context, false)
        : Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [backgroundColor!, subBackgroundColor!])),
            child: scaffold(context, true));
  }

  Widget scaffold(BuildContext context, bool transparentBack) {
    var alerts = context.watch<T>().alerts;
    final topAlerts =
        alerts.where((alert) => alert.position == AlertPosition.top);
    var hasConnection = context.select((T v) => v.hasInternetConnection);
    final bottomAlerts =
        alerts.where((alert) => alert.position == AlertPosition.bottom);
    final connectionAlerts =
        alerts.where((alert) => alert.position == AlertPosition.connection);
    var topInset = MediaQuery.of(context).viewPadding.top;

    return AbsorbPointer(
        absorbing: context.watch<T>().currentLoadingState.isLoading,
        child: LoadingOverlay(
          isLoading: context.watch<T>().currentLoadingState.isLoading,
          child: Scaffold(
              backgroundColor:
                  transparentBack ? Colors.transparent : backgroundColor,
              resizeToAvoidBottomInset: needResize,
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              appBar: needAppBar
                  ? appBar ??
                      AppBar(
                          leadingWidth:
                              needExtraSpaceTitle ? null : Dimen.size0,
                          backgroundColor: appbarColor,
                          elevation: 0,
                          shape: needBottomEdge
                              ? const Border(
                                  bottom: BorderSide(
                                      color: AppColor.appBarSeparator,
                                      width: Dimen.size1))
                              : null,
                          actions: [...actions],
                          leading: needBackButton
                              ? CupertinoButton(
                                  padding:
                                      const EdgeInsets.only(left: Dimen.size16),
                                  onPressed: onBack ??
                                      () => context.navigateUp(arg: backArg),
                                  child: const Icon(Icons.arrow_back,
                                      color: AppColor.primary))
                              : const SizedBox(),
                          title: titleWidget(context))
                  : null,
              body: SafeArea(
                bottom: safeBottom,
                child: Stack(children: [
                  child != null ? child! : const SizedBox(),
                  if (topAlerts.isNotEmpty)
                    Positioned(
                        top: Dimen.size60,
                        left: Dimen.size20,
                        right: Dimen.size20,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: topAlerts.map(toBaseAlert).toList())),
                  AnimatedPositioned(
                      top: connectionAlerts.isNotEmpty ? Dimen.size0 : -55,
                      left: Dimen.size20,
                      right: Dimen.size20,
                      duration: const Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                          opacity: connectionAlerts.isNotEmpty ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: Column(children: [
                            BaseAlert('No connection found',
                                hideAfterSec: 10,
                                isConnectionAlert: true,
                                style: AlertStyle.connection,
                                onSubmit: () => context.read<T>().clearAlerts())
                          ])))
                ]),
              )),
        ));
  }

  Widget titleWidget(BuildContext context) {
    var title = context.watch<T>().title;
    var subTitle = context.watch<T>().subTitle;
    var atLineSubTitle = context.watch<T>().atLineSubTitle;

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
              fontWeight: FontWeight.w500,
              fontSize: Dimen.size20,
              letterSpacing: 0.15))
          : const SizedBox();
    } else {
      return Column(children: [
        Row(children: [
          Expanded(
              child: Text(title,
                  style: GoogleFonts.notoSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: Dimen.size20,
                      letterSpacing: 0.15)))
        ]),
        Row(children: [
          Expanded(
              child: Text(subTitle,
                  style: GoogleFonts.notoSans(
                      color: AppColor.basicDarkGrey, fontSize: Dimen.size14)))
        ])
      ]);
    }
  }
}
