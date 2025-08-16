import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class RouteActionsBar extends StatelessWidget {
  final RouteResponse? selectedRoute;
  final int currentPage;
  final int lastPage;
  final Function(int) onPageChanged;
  final VoidCallback onCopyRoute;
  final VoidCallback onCreateRoute;

  const RouteActionsBar({
    super.key,
    required this.selectedRoute,
    required this.currentPage,
    required this.lastPage,
    required this.onPageChanged,
    required this.onCopyRoute,
    required this.onCreateRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Copy route button
        Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 32),
          child: SizedBox(
            width: 200,
            child: BaseTextButton(
              buttonText: "Копировать маршрут",
              onTap: onCopyRoute,
              weight: FontWeight.w500,
              fontSize: 14,
              enabled: selectedRoute != null,
              textColor: Colors.white,
              buttonColor: AppColor.success,
            ),
          ),
        ),
        const Spacer(),
        // Pagination
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32, 0),
          child: Row(
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
        ),
        const Spacer(),
        // Create route button
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32, 32),
          child: SizedBox(
            width: 200,
            child: BaseTextButton(
              buttonText: "Создать маршрут",
              onTap: onCreateRoute,
              weight: FontWeight.w500,
              fontSize: 14,
              enabled: selectedRoute != null,
              textColor: Colors.white,
              buttonColor: AppColor.redDefect,
            ),
          ),
        ),
      ],
    );
  }
}
