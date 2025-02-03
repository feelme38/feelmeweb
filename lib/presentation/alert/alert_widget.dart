
import 'package:flutter/material.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import '../theme/dimen.dart';
import '../theme/theme_colors.dart';
import 'alert.dart';

BaseAlert toBaseAlert(Alert alert) => BaseAlert(alert.message,
    style: alert.style,
    hideAfterSec: alert.hideAfterSec,
    showTimeoutProgress: alert.showTimeoutProgress,
    submitText: alert.submitText,
    onSubmit: alert.onSubmit,
    isConnectionAlert: alert.position == AlertPosition.connection);

class BaseAlert extends StatefulWidget {
  const BaseAlert(this.message,
      {this.style = AlertStyle.regular,
      this.hideAfterSec = 5,
      this.showTimeoutProgress = false,
      this.submitText,
      this.isConnectionAlert = false,
      this.onSubmit,
      Key? key})
      : super(key: key);

  final String message;
  final AlertStyle style;
  final int hideAfterSec;
  final bool showTimeoutProgress;
  final String? submitText;
  final Function? onSubmit;
  final bool isConnectionAlert;

  @override
  State<BaseAlert> createState() => _BaseAlertState();
}

class _BaseAlertState extends State<BaseAlert> with TickerProviderStateMixin {
  late AnimationController controller;
  double startDXPoint = 0;
  double startDYPoint = 0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.hideAfterSec),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color getBackgroundByStyle(AlertStyle style) {
    switch (style) {
      case AlertStyle.danger:
        return AppColor.reject;
      case AlertStyle.success:
        return AppColor.success;
      case AlertStyle.regular:
      case AlertStyle.connection:
        return AppColor.connectionRedBack;
      default:
        return Colors.white;
    }
  }

  Color getContentColorByStyle(AlertStyle style) {
    if (widget.isConnectionAlert) return Colors.black;
    switch (style) {
      case AlertStyle.danger:
        return Colors.white;
      case AlertStyle.connection:
      case AlertStyle.success:
        return Colors.black;
      case AlertStyle.regular:
      default:
        return AppColor.primary;
    }
  }

  Color getColorByStyle(AlertStyle style) {
    if (widget.isConnectionAlert) return Colors.black;
    switch (style) {
      case AlertStyle.danger:
        return Colors.white;
      case AlertStyle.success:
        return AppColor.success;
      case AlertStyle.regular:
        return AppColor.primary;
      case AlertStyle.connection:
        return Colors.black;
      default:
        return AppColor.primary;
    }
  }

  Widget getIconByStyle(AlertStyle style) {
    final color = getColorByStyle(style);
    switch (style) {
      case AlertStyle.danger:
        return const Icon(Icons.warning_rounded, color: Colors.white);
      case AlertStyle.success:
        return Icon(Icons.check_circle_rounded, color: color);
      case AlertStyle.regular:
      default:
        return Icon(Icons.info_rounded, color: color);
    }
  }

  void _onVerticalDragStartHandler(DragUpdateDetails details) {
    startDXPoint = details.globalPosition.dx.floorToDouble();
    startDYPoint = details.globalPosition.dy.floorToDouble();
    if (startDYPoint < 120) widget.onSubmit?.call();
  }

  @override
  Widget build(BuildContext context) {
    final timerValue =
        (controller.value * widget.hideAfterSec - widget.hideAfterSec)
            .abs()
            .toString()[0];
    return GestureDetector(
        onVerticalDragUpdate: (s) => _onVerticalDragStartHandler(s),
        child: Container(
            margin: const EdgeInsets.only(bottom: Dimen.size10),
            padding: const EdgeInsets.symmetric(
                vertical: Dimen.size12, horizontal: Dimen.size16),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: getBackgroundByStyle(widget.style),
                borderRadius:
                    const BorderRadius.all(Radius.circular(Dimen.size12)),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.04),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset.zero),
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.04),
                      spreadRadius: 0,
                      blurRadius: 6,
                      offset: Offset(0, 2)),
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.04),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ]),
            child: Row(children: [
              Padding(
                  padding: const EdgeInsets.only(right: Dimen.size12),
                  child: widget.showTimeoutProgress
                      ? SizedBox(
                          width: Dimen.size24,
                          height: Dimen.size24,
                          child: Stack(children: <Widget>[
                            CircularProgressIndicator(
                                value: controller.value,
                                color: AppColor.primary,
                                strokeWidth: 2),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                top: 4,
                                child: Text(timerValue,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: getColorByStyle(widget.style),
                                        fontSize: Dimen.size14,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal)))
                          ]))
                      : widget.isConnectionAlert
                          ? Container(
                              padding: const EdgeInsets.all(Dimen.size4),
                              decoration: const BoxDecoration(
                                  color: AppColor.connectionRed,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.warning_rounded))
                          : getIconByStyle(widget.style)),
              Flexible(
                  child: Row(children: [
                Expanded(
                    child: Text(widget.message,
                        maxLines: null,
                        style: context.themeData.textTheme.displayLarge?.copyWith(
                            decoration: TextDecoration.none,
                            color: getContentColorByStyle(widget.style),
                            fontSize: 16,
                            fontWeight: FontWeight.normal))),
                const SizedBox(width: Dimen.size12),
                if (widget.submitText != null)
                  GestureDetector(
                      onTap: () => widget.onSubmit?.call(),
                      child: Text(widget.submitText ?? '',
                          style: context.themeData.textTheme.displayLarge
                              ?.copyWith(
                                  decoration: TextDecoration.none,
                                  color: getColorByStyle(widget.style),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)))
              ]))
            ])));
  }
}
