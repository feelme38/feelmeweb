import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:feelmeweb/data/models/response/address_dto.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/subtask_types_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:feelmeweb/presentation/modals/widgets/create_subtask_dialog_widget.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/ui/routes/create/widgets/subtask_parameters_widget.dart';
import 'package:flutter/material.dart';

class SubtaskCardWidget extends StatelessWidget {
  final LastCheckListInfoResponse checklist;
  final List<AromaResponse> aromas;
  final List<SubtaskTypeResponse> subtaskTypes;
  final SubtaskBody? subtask;
  final AddressDTO? selectedAddress;
  final CustomerResponse? customer;
  final CreateSubtaskCallback createSubtaskCallback;
  final Function() deleteSubtaskCallback;

  const SubtaskCardWidget({
    super.key,
    required this.checklist,
    required this.aromas,
    required this.subtaskTypes,
    this.subtask,
    required this.selectedAddress,
    required this.customer,
    required this.createSubtaskCallback,
    required this.deleteSubtaskCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubtaskParametersWidget(
                param: 'Устройство', value: checklist.deviceModel.orDash()),
            const SizedBox(height: 16),
            SubtaskParametersWidget(
                param: 'Юр. лицо', value: customer?.name.orDash()),
            SubtaskParametersWidget(
                param: 'ЛПР', value: customer?.ownerName.orDash()),
            SubtaskParametersWidget(
                param: 'Телефон', value: customer?.phone.orDash()),
            const SizedBox(height: 16),
            SubtaskParametersWidget(
                param: 'Адрес', value: selectedAddress?.address.orDash()),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: BaseTextButton(
                      buttonText: "Редактировать",
                      onTap: () {
                        Dialogs.createSubtaskDialog(context,
                            subtask: subtask,
                            checklist: checklist,
                            aromas: aromas,
                            subtaskTypes: subtaskTypes,
                            createSubtaskCallback: createSubtaskCallback);
                      },
                      weight: FontWeight.w500,
                      fontSize: 14,
                      enabled: true,
                      textColor: Colors.white,
                      buttonColor: AppColor.success),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BaseTextButton(
                      buttonText: "Удалить",
                      onTap: deleteSubtaskCallback,
                      weight: FontWeight.w500,
                      fontSize: 14,
                      enabled: subtask != null,
                      textColor: Colors.white,
                      buttonColor: AppColor.redDefect),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
