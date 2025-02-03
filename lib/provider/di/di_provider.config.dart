// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:feelmeweb/data/repository/aromas/aromas_repository.dart'
    as _i17;
import 'package:feelmeweb/data/repository/auth/auth_repository.dart' as _i19;
import 'package:feelmeweb/data/repository/checklists/checklists_repository.dart'
    as _i21;
import 'package:feelmeweb/data/repository/customers/customers_repository.dart'
    as _i23;
import 'package:feelmeweb/data/repository/devices/devices_repository.dart'
    as _i25;
import 'package:feelmeweb/data/repository/inventory/inventory_repository.dart'
    as _i27;
import 'package:feelmeweb/data/repository/regions/regions_repository.dart'
    as _i6;
import 'package:feelmeweb/data/repository/route/route_repository.dart' as _i9;
import 'package:feelmeweb/data/repository/subtasks/ssubtasks_repository.dart'
    as _i11;
import 'package:feelmeweb/data/repository/tasks/tasks_repository.dart' as _i13;
import 'package:feelmeweb/data/repository/users/users_repository.dart' as _i15;
import 'package:feelmeweb/data/sources/remote/aromas_remote_source.dart'
    as _i16;
import 'package:feelmeweb/data/sources/remote/auth_remote_source.dart' as _i18;
import 'package:feelmeweb/data/sources/remote/checklist_remote_source.dart'
    as _i20;
import 'package:feelmeweb/data/sources/remote/customers_remote_source.dart'
    as _i22;
import 'package:feelmeweb/data/sources/remote/devices_remote_source.dart'
    as _i24;
import 'package:feelmeweb/data/sources/remote/inventory_remote_source.dart'
    as _i26;
import 'package:feelmeweb/data/sources/remote/regions_remote_source.dart'
    as _i5;
import 'package:feelmeweb/data/sources/remote/route_remote_source.dart' as _i8;
import 'package:feelmeweb/data/sources/remote/ssubtasks_remote_source.dart'
    as _i10;
import 'package:feelmeweb/data/sources/remote/tasks_remote_source.dart' as _i12;
import 'package:feelmeweb/data/sources/remote/users_remote_source.dart' as _i14;
import 'package:feelmeweb/presentation/navigation/route_generation.dart' as _i7;
import 'package:feelmeweb/provider/network/auth_preferences.dart' as _i3;
import 'package:feelmeweb/provider/network/network_provider.dart' as _i4;
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
    gh.singleton<_i4.NetworkProvider>(
        _i4.NetworkProvider(gh<_i3.AuthPreferences>()));
    gh.singleton<_i5.RegionsRemoteSource>(
        _i5.RegionsRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i6.RegionsRepository>(
        _i6.RegionsRepositoryImpl(gh<_i5.RegionsRemoteSource>()));
    gh.singleton<_i7.RouteGenerator>(_i7.RouteGenerator());
    gh.singleton<_i8.RouteRemoteSource>(
        _i8.RouteRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i9.RouteRepository>(
        _i9.RouteRepositoryImpl(gh<_i8.RouteRemoteSource>()));
    gh.singleton<_i10.SubtasksRemoteSource>(
        _i10.SubtasksRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i11.SubtasksRepository>(
        _i11.SubtasksRepositoryImpl(gh<_i10.SubtasksRemoteSource>()));
    gh.singleton<_i12.TasksRemoteSource>(
        _i12.TasksRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i13.TasksRepository>(
        _i13.TasksRepositoryImpl(gh<_i12.TasksRemoteSource>()));
    gh.singleton<_i14.UsersRemoteSource>(
        _i14.UsersRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i15.UsersRepository>(
        _i15.UsersRepositoryImpl(gh<_i14.UsersRemoteSource>()));
    gh.singleton<_i16.AromasRemoteSource>(
        _i16.AromasRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i17.AromasRepository>(
        _i17.AromasRepositoryImpl(gh<_i16.AromasRemoteSource>()));
    gh.singleton<_i18.AuthRemoteSource>(
        _i18.AuthRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i19.AuthRepository>(
        _i19.AuthRepositoryImpl(gh<_i18.AuthRemoteSource>()));
    gh.singleton<_i20.ChecklistRemoteSource>(
        _i20.ChecklistRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i21.ChecklistsRepository>(
        _i21.ChecklistsRepositoryImpl(gh<_i20.ChecklistRemoteSource>()));
    gh.singleton<_i22.CustomersRemoteSource>(
        _i22.CustomersRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i23.CustomersRepository>(
        _i23.CustomersRepositoryImpl(gh<_i22.CustomersRemoteSource>()));
    gh.singleton<_i24.DevicesRemoteSource>(
        _i24.DevicesRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i25.DevicesRepository>(
        _i25.DevicesRepositoryImpl(gh<_i24.DevicesRemoteSource>()));
    gh.singleton<_i26.InventoryRemoteSource>(
        _i26.InventoryRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i27.InventoryRepository>(
        _i27.InventoryRepositoryImpl(gh<_i26.InventoryRemoteSource>()));
    return this;
  }
}
