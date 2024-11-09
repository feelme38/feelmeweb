// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:feelmeweb/data/repository/aromas/aromas_repository.dart'
    as _i13;
import 'package:feelmeweb/data/repository/auth/auth_repository.dart' as _i15;
import 'package:feelmeweb/data/repository/checklists/checklists_repository.dart'
    as _i17;
import 'package:feelmeweb/data/repository/customers/customers_repository.dart'
    as _i19;
import 'package:feelmeweb/data/repository/devices/devices_repository.dart'
    as _i21;
import 'package:feelmeweb/data/repository/regions/regions_repository.dart'
    as _i6;
import 'package:feelmeweb/data/repository/tasks/tasks_repository.dart' as _i9;
import 'package:feelmeweb/data/repository/users/users_repository.dart' as _i11;
import 'package:feelmeweb/data/sources/remote/aromas_remote_source.dart'
    as _i12;
import 'package:feelmeweb/data/sources/remote/auth_remote_source.dart' as _i14;
import 'package:feelmeweb/data/sources/remote/checklist_remote_source.dart'
    as _i16;
import 'package:feelmeweb/data/sources/remote/customers_remote_source.dart'
    as _i18;
import 'package:feelmeweb/data/sources/remote/devices_remote_source.dart'
    as _i20;
import 'package:feelmeweb/data/sources/remote/regions_remote_source.dart'
    as _i5;
import 'package:feelmeweb/data/sources/remote/tasks_remote_source.dart' as _i8;
import 'package:feelmeweb/data/sources/remote/users_remote_source.dart' as _i10;
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
    gh.singleton<_i8.TasksRemoteSource>(
        _i8.TasksRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i9.TasksRepository>(
        _i9.TasksRepositoryImpl(gh<_i8.TasksRemoteSource>()));
    gh.singleton<_i10.UsersRemoteSource>(
        _i10.UsersRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i11.UsersRepository>(
        _i11.UsersRepositoryImpl(gh<_i10.UsersRemoteSource>()));
    gh.singleton<_i12.AromasRemoteSource>(
        _i12.AromasRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i13.AromasRepository>(
        _i13.AromasRepositoryImpl(gh<_i12.AromasRemoteSource>()));
    gh.singleton<_i14.AuthRemoteSource>(
        _i14.AuthRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i15.AuthRepository>(
        _i15.AuthRepositoryImpl(gh<_i14.AuthRemoteSource>()));
    gh.singleton<_i16.ChecklistRemoteSource>(
        _i16.ChecklistRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i17.ChecklistsRepository>(
        _i17.ChecklistsRepositoryImpl(gh<_i16.ChecklistRemoteSource>()));
    gh.singleton<_i18.CustomersRemoteSource>(
        _i18.CustomersRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i19.CustomersRepository>(
        _i19.CustomersRepositoryImpl(gh<_i18.CustomersRemoteSource>()));
    gh.singleton<_i20.DevicesRemoteSource>(
        _i20.DevicesRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i21.DevicesRepository>(
        _i21.DevicesRepositoryImpl(gh<_i20.DevicesRemoteSource>()));
    return this;
  }
}
