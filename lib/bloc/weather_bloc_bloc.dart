import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/logger.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

String API_KEY = "";//

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async{
      emit(WeatherBlocLoadind());
      try {
        log('🚀 set position');
        WeatherFactory wf = WeatherFactory(
          API_KEY, 
          language: Language.ENGLISH);
      
        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude, 
          event.position.longitude
        );
        log('🚀 set weather');
        // log(weather);
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
