import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';
import 'package:feelmeweb/presentation/theme/drawables.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';

class BaseSelectButton extends StatelessWidget {
  const BaseSelectButton(this.label,
      {this.onPressed, this.hasError = false, Key? key})
      : super(key: key);

  final String label;
  final bool hasError;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: Dimen.size56,
        padding: const EdgeInsets.symmetric(horizontal: Dimen.size16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(Dimen.size12)),
            color: AppColor.background2,
            border: Border.all(
                width: 1,
                color: hasError ? AppColor.reject : AppColor.basicLightGrey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: Dimen.size18,
                    color: Colors.black,
                    letterSpacing: Dimen.size1 / 2),
              ),
            ),
            SvgPicture.asset(Drawables.keyboardArrowDown),
          ],
        ),
      ),
    );
  }
}
