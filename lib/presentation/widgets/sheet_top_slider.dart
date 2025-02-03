import 'package:flutter/cupertino.dart';

import '../theme/dimen.dart';
import '../theme/theme_colors.dart';

class SheetTopSlider extends StatelessWidget {
  const SheetTopSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: Dimen.size32,
              height: Dimen.size4,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Dimen.size16)),
                  color: AppColor.basicLightGrey))
        ]);
  }
}
