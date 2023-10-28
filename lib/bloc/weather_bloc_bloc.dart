import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:weather_news/bloc/weather_bloc_state.dart';
import 'package:geolocator/geolocator.dart';
import '../data/my_data.dart';
part 'weather_bloc_event.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      try {
        WeatherFactory wf = WeatherFactory(apiKey, language: Language.ENGLISH);

        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );

        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
    on<FetchWeatherByCity>((event, emit) async {
      try {
        WeatherFactory wf = WeatherFactory(apiKey, language: Language.ENGLISH);

        Weather weather = await wf.currentWeatherByCityName(event.cityName);

        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
