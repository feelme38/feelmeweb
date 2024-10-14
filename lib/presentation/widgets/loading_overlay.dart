import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key, required this.child, required this.isLoading})
      : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLoading)
          Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: Dimen.size64,
                    width: Dimen.size64,
                    child: CircularProgressIndicator(color: AppColor.primary),
                  ),
                  const SizedBox(height: Dimen.size50),
                  Text("Загружаем данные",
                      style: GoogleFonts.notoSans(
                          decoration: TextDecoration.none,
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          height: 0.05)),
                ]),
          ),
      ],
    );
  }
}
