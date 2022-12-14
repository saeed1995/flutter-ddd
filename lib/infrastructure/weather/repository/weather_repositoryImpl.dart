
import 'package:dio/dio.dart';
import 'package:flutter_advanced_course/core/resources/data_state.dart';
import 'package:flutter_advanced_course/domain/feature_weather/entities/current_city_entity.dart';
import 'package:flutter_advanced_course/domain/feature_weather/entities/forecase_days_entity.dart';
import 'package:flutter_advanced_course/domain/feature_weather/entities/suggest_city_entity.dart';
import 'package:flutter_advanced_course/domain/feature_weather/repository/weather_repository.dart';
import 'package:flutter_advanced_course/infrastructure/weather/data_source/remote/api_provider.dart';
import 'package:flutter_advanced_course/infrastructure/weather/models/current_city_model.dart';
import 'package:flutter_advanced_course/infrastructure/weather/models/suggest_city_model.dart';


import '../../../../core/params/ForecastParams.dart';

import '../models/ForcastDaysModel.dart';

class WeatherRepositoryImpl extends WeatherRepository{
  ApiProvider apiProvider;

  WeatherRepositoryImpl(this.apiProvider);

  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName) async {

    try{
      Response response = await apiProvider.callCurrentWeather(cityName);
      if(response.statusCode == 200){
        CurrentCityEntity currentCityEntity = CurrentCityModel.fromJson(response.data);

        return DataSuccess(currentCityEntity);
      }else{
        return const DataFailed("Something Went Wrong. try again...");
      }
    }catch(e){
      return const DataFailed("please check your connection...");
    }
  }


  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(ForecastParams params) async {
    try{
      Response response = await apiProvider.sendRequest7DaysForcast(params);

      if(response.statusCode == 200){
        ForecastDaysEntity forecastDaysEntity = ForecastDaysModel.fromJson(response.data);
        return DataSuccess(forecastDaysEntity);
      }else{
        return const DataFailed("Something Went Wrong. try again...");
      }
    }catch(e){
      print(e.toString());
      return const DataFailed("please check your connection...");
    }
  }

  @override
  Future<List<Data>> fetchSuggestData(cityName) async {

    Response response = await apiProvider.sendRequestCitySuggestion(cityName);

    SuggestCityEntity suggestCityEntity = SuggestCityModel.fromJson(response.data);

    return suggestCityEntity.data as List<Data>;

  }
}