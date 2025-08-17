import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class ChecklistsPaginationBar extends StatelessWidget {
  final int currentPage;
  final int lastPage;
  final Function(int) onPageChanged;

  const ChecklistsPaginationBar({
    super.key,
    required this.currentPage,
    required this.lastPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 32, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            child: BaseTextButton(
              buttonText: "<",
              onTap: () => onPageChanged(currentPage - 1),
              weight: FontWeight.w500,
              fontSize: 14,
              enabled: currentPage > 1,
              textColor: Colors.white,
              buttonColor: AppColor.primary,
            ),
          ),
          const SizedBox(width: 10),
          Text('$currentPage / $lastPage'),
          const SizedBox(width: 10),
          SizedBox(
            width: 50,
            child: BaseTextButton(
              buttonText: ">",
              onTap: () => onPageChanged(currentPage + 1),
              weight: FontWeight.w500,
              fontSize: 14,
              enabled: currentPage < lastPage,
              textColor: Colors.white,
              buttonColor: AppColor.primary,
            ),
          ),
        ],
      ),
    );
  }
}
