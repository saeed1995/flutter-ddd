import 'package:flutter_advanced_course/application/bookmark/bookmark_bloc.dart';
import 'package:flutter_advanced_course/application/weather/home_bloc.dart';
import 'package:flutter_advanced_course/domain/feature_bookmark/repository/city_repository.dart';
import 'package:flutter_advanced_course/domain/feature_bookmark/use_cases/delete_city_usecase.dart';
import 'package:flutter_advanced_course/domain/feature_bookmark/use_cases/get_all_city_usecase.dart';
import 'package:flutter_advanced_course/domain/feature_bookmark/use_cases/get_city_usecase.dart';
import 'package:flutter_advanced_course/domain/feature_bookmark/use_cases/save_city_usecase.dart';
import 'package:flutter_advanced_course/domain/feature_weather/repository/weather_repository.dart';
import 'package:flutter_advanced_course/domain/feature_weather/use_cases/get_current_weather_usecase.dart';
import 'package:flutter_advanced_course/domain/feature_weather/use_cases/get_forecast_weather_usecase.dart';

import 'package:flutter_advanced_course/infrastructure/bookmark/data_source/local/database.dart';
import 'package:flutter_advanced_course/infrastructure/bookmark/repository/city_repositoryimpl.dart';
import 'package:flutter_advanced_course/infrastructure/weather/data_source/remote/api_provider.dart';
import 'package:flutter_advanced_course/infrastructure/weather/repository/weather_repositoryImpl.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setup() async {
  locator.registerSingleton<ApiProvider>(ApiProvider());

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  /// repositories
  locator
      .registerSingleton<WeatherRepository>(WeatherRepositoryImpl(locator()));
  locator
      .registerSingleton<CityRepository>(CityRepositoryImpl(database.cityDao));

  /// use case
  locator.registerSingleton<GetCurrentWeatherUseCase>(
      GetCurrentWeatherUseCase(locator()));
  locator.registerSingleton<GetForecastWeatherUseCase>(
      GetForecastWeatherUseCase(locator()));
  locator.registerSingleton<GetCityUseCase>(GetCityUseCase(locator()));
  locator.registerSingleton<SaveCityUseCase>(SaveCityUseCase(locator()));
  locator.registerSingleton<GetAllCityUseCase>(GetAllCityUseCase(locator()));
  locator.registerSingleton<DeleteCityUseCase>(DeleteCityUseCase(locator()));

  locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator()));
  locator.registerSingleton<BookmarkBloc>(
      BookmarkBloc(locator(), locator(), locator(), locator()));
}
