import 'package:feelmeweb/data/models/response/inventory_response.dart';
import 'package:feelmeweb/domain/inventory/get_inventory_usecase.dart';
import 'package:feelmeweb/domain/inventory/update_inventory_usecase.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:flutter/cupertino.dart';

class InventoryViewModel extends BaseSearchViewModel {
  InventoryViewModel(this.userId) {
    loadInventory();
  }

  final String userId;

  final _getInventoryUseCase = GetInventoryUseCase();
  final _updateInventoryUserCase = UpdateInventoryUseCase();

  final _router = getIt<RouteGenerator>().router;

  InventoryResponse? _inventory;
  InventoryResponse? get inventory => _inventory;

  // Сохраняем изменения в количестве для ароматов и устройств
  final Map<String, bool> checkboxValues = {};
  final Map<String, TextEditingController> textControllers = {};

  Future loadInventory() async {
    loadingOn();
    (await executeUseCase<InventoryResponse>(_getInventoryUseCase))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _inventory = value;
      notifyListeners();
      _initializeControllers(value); // Инициализируем контроллеры для ввода
    });
    loadingOff();
  }

  void updateInventory() async {
    loadingOn();
    InventoryResponse inventory = collectInventoryData();
    (await executeUseCaseParam<bool, UpdateInventoryParam>(
      _updateInventoryUserCase,
      UpdateInventoryParam(userId, inventory),
    ))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) async {
      await loadInventory();
    });
    loadingOff();
  }

  // Инициализируем контроллеры с актуальными значениями из инвентаря
  void _initializeControllers(InventoryResponse inventory) {
    for (var device in inventory.devices) {
      checkboxValues.putIfAbsent('device_${device.id}', () => false);
      //textControllers.putIfAbsent(
      //    'device_${device.id}', () => TextEditingController(text: '1'));
    }

// Создаем Map для группировки ароматов по названию и подсчета общего количества
    Map<String, double> groupedAromas = {};

// Проходим по каждому аромату в inventory.aromas
    for (var aroma in inventory.aromas) {
      // Получаем название аромата
      String? aromaName = aroma.aroma?.name;

      // Если название аромата не null, добавляем его в Map
      if (aromaName != null) {
        // Если аромат уже есть в Map, добавляем количество к существующему значению
        if (groupedAromas.containsKey(aromaName)) {
          groupedAromas[aromaName] =
              (groupedAromas[aromaName] ?? 0) + (aroma.quantity ?? 0);
        } else {
          // Если аромата еще нет в Map, добавляем его с текущим количеством
          groupedAromas[aromaName] = aroma.quantity ?? 0;
        }
      }
    }

    // Теперь работаем с groupedAromas для заполнения checkboxValues и textControllers
    for (var entry in groupedAromas.entries) {
      String aromaKey = 'aroma_${entry.key}'; // Ключ на основе названия аромата

      // Добавляем ключ в checkboxValues, если его еще нет
      checkboxValues.putIfAbsent(aromaKey, () => false);

      // Добавляем TextEditingController для текстового поля с суммарным количеством
      textControllers.putIfAbsent(
        aromaKey,
        () => TextEditingController(text: entry.value.toString()),
      );
    }

    for (var aroma in inventory.aromas) {
      checkboxValues.putIfAbsent('aroma_${aroma.aroma?.name}', () => false);
      textControllers.putIfAbsent('aroma_${aroma.aroma?.name}',
          () => TextEditingController(text: aroma.quantity?.toString() ?? '0'));
    }
  }

  InventoryResponse collectInventoryData() {
    List<Device> updatedDevices = [];
    List<AromaQuantity> updatedAromas = [];

    // Проверяем изменения в устройствах
    for (var device in _inventory?.devices ?? []) {
      String key = 'device_${device.id}';
      bool? checkboxValue = checkboxValues[key];

      if (checkboxValue == true) {
        // Если чекбокс отмечен, просто добавляем устройство
        updatedDevices.add(device);
      }
    }

    // Проверяем изменения в ароматах
    for (AromaQuantity aroma in _inventory?.aromas ?? []) {
      String key = 'aroma_${aroma.aroma?.name}';
      bool? checkboxValue = checkboxValues[key];
      String currentQuantity = textControllers[key]?.text ?? '0';
      double current = double.tryParse(currentQuantity) ?? 0;

      if (checkboxValue == true) {
        // Если чекбокс отмечен, добавляем весь аромат с его количеством
        updatedAromas.add(
          AromaQuantity(aroma: aroma.aroma, quantity: current),
        );
      }
    }

    return InventoryResponse(
        materials: [],
        instruments: [],
        other: [],
        aromas: updatedAromas,
        devices: updatedDevices);
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
  }

  @override
  String get title => 'Инвентарь СИ';
}
