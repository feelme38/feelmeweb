// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:feelmeweb/data/repository/auth/auth_repository.dart' as _i9;
import 'package:feelmeweb/data/repository/users/users_repository.dart' as _i7;
import 'package:feelmeweb/data/sources/remote/auth_remote_source.dart' as _i8;
import 'package:feelmeweb/data/sources/remote/users_remote_source.dart' as _i6;
import 'package:feelmeweb/presentation/navigation/route_generation.dart' as _i5;
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
    gh.singleton<_i5.RouteGenerator>(_i5.RouteGenerator());
    gh.singleton<_i6.UsersRemoteSource>(
        _i6.UsersRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i7.UsersRepository>(
        _i7.UsersRepositoryImpl(gh<_i6.UsersRemoteSource>()));
    gh.singleton<_i8.AuthRemoteSource>(
        _i8.AuthRemoteSource(gh<_i4.NetworkProvider>()));
    gh.singleton<_i9.AuthRepository>(
        _i9.AuthRepositoryImpl(gh<_i8.AuthRemoteSource>()));
    return this;
  }
}
