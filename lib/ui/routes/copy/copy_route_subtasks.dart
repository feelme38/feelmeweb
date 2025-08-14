import 'package:feelmeweb/core/date_utils.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/ui/routes/copy/widgets/choose_subtasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'copy_route_view_model.dart';

class CopyRouteSubtasksWidget extends StatefulWidget {
  const CopyRouteSubtasksWidget({super.key});

  @override
  State<CopyRouteSubtasksWidget> createState() =>
      _CopyRouteSubtasksWidgetState();
}

class _CopyRouteSubtasksWidgetState extends State<CopyRouteSubtasksWidget> {
  late final TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    // Initialize from VM if already selected
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<CopyRouteViewModel>();
      if (vm.selectedRouteDate != null) {
        _dateController.text = vm.selectedRouteDate!;
      }
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CopyRouteViewModel>();

    final isCreateOrUpdateRouteButtonEnabled =
        context.watch<CopyRouteViewModel>().isCreateOrUpdateRouteButtonEnabled;
    final selectedDate = context.watch<CopyRouteViewModel>().selectedRouteDate;
    // Keep controller in sync when VM date changes externally
    if (selectedDate != null && _dateController.text != selectedDate) {
      // schedule to avoid setState during build issues
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _dateController.text = selectedDate;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            children: [
              const Text('Дата маршрута:'),
              const SizedBox(width: 12),
              SizedBox(
                width: 160,
                child: TextFormField(
                  readOnly: true,
                  controller: _dateController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'ГГГГ-ММ-ДД',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(now.year - 1),
                      lastDate: DateTime(now.year + 2),
                      locale: const Locale('ru'),
                    );
                    if (picked != null) {
                      _dateController.text = DateUtil.formatToYYYYMMDD(picked);
                      viewModel.updateRouteDate(picked);
                    }
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        const Expanded(flex: 1, child: CopyRouteChooseSubtasksWidget()),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 32),
                child: SizedBox(
                    width: 200,
                    child: BaseTextButton(
                        buttonText: "Копировать маршрут",
                        onTap: () => viewModel.createRoute(),
                        weight: FontWeight.w500,
                        fontSize: 14,
                        enabled: isCreateOrUpdateRouteButtonEnabled,
                        textColor: Colors.white,
                        buttonColor: AppColor.redDefect))),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32, 32),
                child: SizedBox(
                    width: 150,
                    child: BaseTextButton(
                        buttonText: "Назад",
                        onTap: () {},
                        weight: FontWeight.w500,
                        fontSize: 14,
                        enabled: true,
                        textColor: Colors.white,
                        buttonColor: AppColor.primary))),
          ],
        )
      ],
    );
  }
}
