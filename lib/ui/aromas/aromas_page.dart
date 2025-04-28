import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';
import '../../presentation/widgets/search_widget.dart';
import 'aromas_view_model.dart';

class AromasPage extends StatelessWidget {
  const AromasPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => AromasViewModel(), child: const AromasPage());

  @override
  Widget build(BuildContext context) {
    final aromasByType = context.watch<AromasViewModel>().aromasByType;
    final aromas = context.watch<AromasViewModel>().aromas;
    final viewModel = context.read<AromasViewModel>();

    return BaseScreen<AromasViewModel>(
      needBackButton: false,
      needAppBar: true,
      drawer: getDrawer(context, reloadCallback: viewModel.loadAromas),
      appBar: SearchWidget<AromasViewModel>(
          context.read<AromasViewModel>().onSearch, () {},
          needBottomEdge: true, needBackButton: false),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: List.generate(
            aromasByType.keys.length,
            (index) {
              AromaType aromaType = aromasByType.keys.elementAt(index);
              return Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text(
                        aromaType.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: AppTableWidget(
                          dataColumns: viewModel.tableAromasColumns,
                          dataRows:
                              viewModel.getTableAromasRows(aromas, aromaType),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
