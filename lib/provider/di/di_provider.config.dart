// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:feelmeweb/data/repository/aromas/aromas_repository.dart'
    as _i19;
import 'package:feelmeweb/data/repository/auth/auth_repository.dart' as _i21;
import 'package:feelmeweb/data/repository/checklists/checklists_repository.dart'
    as _i23;
import 'package:feelmeweb/data/repository/customers/customers_repository.dart'
    as _i25;
import 'package:feelmeweb/data/repository/device_models/device_models_repository.dart'
    as _i27;
import 'package:feelmeweb/data/repository/devices/devices_repository.dart'
    as _i29;
import 'package:feelmeweb/data/repository/inventory/inventory_repository.dart'
    as _i31;
import 'package:feelmeweb/data/repository/regions/regions_repository.dart'
    as _i8;
import 'package:feelmeweb/data/repository/route/route_repository.dart' as _i11;
import 'package:feelmeweb/data/repository/subtasks/ssubtasks_repository.dart'
    as _i13;
import 'package:feelmeweb/data/repository/tasks/tasks_repository.dart' as _i15;
import 'package:feelmeweb/data/repository/users/users_repository.dart' as _i17;
import 'package:feelmeweb/data/sources/remote/aromas_remote_source.dart'
    as _i18;
import 'package:feelmeweb/data/sources/remote/auth_remote_source.dart' as _i20;
import 'package:feelmeweb/data/sources/remote/checklist_remote_source.dart'
    as _i22;
import 'package:feelmeweb/data/sources/remote/customers_remote_source.dart'
    as _i24;
import 'package:feelmeweb/data/sources/remote/device_models_remote_source.dart'
    as _i26;
import 'package:feelmeweb/data/sources/remote/devices_remote_source.dart'
    as _i28;
import 'package:feelmeweb/data/sources/remote/inventory_remote_source.dart'
    as _i30;
import 'package:feelmeweb/data/sources/remote/regions_remote_source.dart'
    as _i7;
import 'package:feelmeweb/data/sources/remote/route_remote_source.dart' as _i10;
import 'package:feelmeweb/data/sources/remote/ssubtasks_remote_source.dart'
    as _i12;
import 'package:feelmeweb/data/sources/remote/tasks_remote_source.dart' as _i14;
import 'package:feelmeweb/data/sources/remote/users_remote_source.dart' as _i16;
import 'package:feelmeweb/domain/device_models/get_device_models_usecase.dart'
    as _i5;
import 'package:feelmeweb/presentation/navigation/route_generation.dart' as _i9;
import 'package:feelmeweb/provider/network/auth_preferences.dart' as _i3;
import 'package:feelmeweb/provider/network/network_provider.dart' as _i6;
import 'package:feelmeweb/ui/device_models/device_models_view_model.dart'
    as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AuthPreferences>(_i3.AuthPreferences());
    gh.factory<_i4.DeviceModelsViewModel>(() => _i4.DeviceModelsViewModel());
    gh.factory<_i5.GetAromasUseCase>(() => _i5.GetAromasUseCase());
    gh.singleton<_i6.NetworkProvider>(
        _i6.NetworkProvider(gh<_i3.AuthPreferences>()));
    gh.singleton<_i7.RegionsRemoteSource>(
        _i7.RegionsRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i8.RegionsRepository>(
        _i8.RegionsRepositoryImpl(gh<_i7.RegionsRemoteSource>()));
    gh.singleton<_i9.RouteGenerator>(_i9.RouteGenerator());
    gh.singleton<_i10.RouteRemoteSource>(
        _i10.RouteRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i11.RouteRepository>(
        _i11.RouteRepositoryImpl(gh<_i10.RouteRemoteSource>()));
    gh.singleton<_i12.SubtasksRemoteSource>(
        _i12.SubtasksRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i13.SubtasksRepository>(
        _i13.SubtasksRepositoryImpl(gh<_i12.SubtasksRemoteSource>()));
    gh.singleton<_i14.TasksRemoteSource>(
        _i14.TasksRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i15.TasksRepository>(
        _i15.TasksRepositoryImpl(gh<_i14.TasksRemoteSource>()));
    gh.singleton<_i16.UsersRemoteSource>(
        _i16.UsersRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i17.UsersRepository>(
        _i17.UsersRepositoryImpl(gh<_i16.UsersRemoteSource>()));
    gh.singleton<_i18.AromasRemoteSource>(
        _i18.AromasRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i19.AromasRepository>(
        _i19.AromasRepositoryImpl(gh<_i18.AromasRemoteSource>()));
    gh.singleton<_i20.AuthRemoteSource>(
        _i20.AuthRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i21.AuthRepository>(
        _i21.AuthRepositoryImpl(gh<_i20.AuthRemoteSource>()));
    gh.singleton<_i22.ChecklistRemoteSource>(
        _i22.ChecklistRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i23.ChecklistsRepository>(
        _i23.ChecklistsRepositoryImpl(gh<_i22.ChecklistRemoteSource>()));
    gh.singleton<_i24.CustomersRemoteSource>(
        _i24.CustomersRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i25.CustomersRepository>(
        _i25.CustomersRepositoryImpl(gh<_i24.CustomersRemoteSource>()));
    gh.singleton<_i26.DeviceModelsRemoteSource>(
        _i26.DeviceModelsRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i27.DeviceModelsRepository>(
        _i27.DeviceModelsRepositoryImpl(gh<_i26.DeviceModelsRemoteSource>()));
    gh.singleton<_i28.DevicesRemoteSource>(
        _i28.DevicesRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i29.DevicesRepository>(
        _i29.DevicesRepositoryImpl(gh<_i28.DevicesRemoteSource>()));
    gh.singleton<_i30.InventoryRemoteSource>(
        _i30.InventoryRemoteSource(gh<_i6.NetworkProvider>()));
    gh.singleton<_i31.InventoryRepository>(
        _i31.InventoryRepositoryImpl(gh<_i30.InventoryRemoteSource>()));
    return this;
  }
}
