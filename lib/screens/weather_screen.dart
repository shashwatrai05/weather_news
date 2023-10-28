import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_news/bloc/weather_bloc_bloc.dart';
import 'package:weather_news/bloc/weather_bloc_state.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController areaNameController = TextEditingController();

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset(
          "assets/8.png",
        );
      case >= 300 && < 400:
        return Image.asset(
          "assets/6.png",
        );
      case >= 400 && < 500:
        return Image.asset(
          "assets/6.png",
        );
      case >= 500 && < 600:
        return Image.asset(
          "assets/7.png",
        );
      case >= 600 && < 700:
        return Image.asset(
          "assets/3.png",
        );
      case >= 700 && < 800:
        return Image.asset(
          "assets/2.png",
        );
      case == 800:
        return Image.asset(
          "assets/4.png",
        );
      case > 800 && < 804:
        return Image.asset(
          "assets/1.png",
        );
      default:
        return Image.asset(
          "assets/4.png",
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0.5 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.deepPurpleAccent, shape: BoxShape.circle),
                  height: 300,
                  width: 300,
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.deepPurpleAccent, shape: BoxShape.circle),
                  height: 300,
                  width: 300,
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  color: Colors.teal,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    areaNameController.text = "${state.weather.areaName}";
                    return SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("📍 "),
                              Expanded(
                                child: TextFormField(
                                  controller: areaNameController,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onFieldSubmitted: (value) {
                                    BlocProvider.of<WeatherBlocBloc>(context)
                                        .add(FetchWeatherByCity(
                                            areaNameController.text));
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Good Morning",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          getWeatherIcon(state.weather.weatherConditionCode!),
                          Center(
                            child: Text(
                              "${state.weather.temperature!.celsius!.round()} °C",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 55),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain!.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd ·')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/4.png",
                                    scale: 8,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Sunrise",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunrise!),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/5.png",
                                    scale: 8,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Sunset",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunset!),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/11.png",
                                    scale: 8,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Temp Max",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "${state.weather.tempMax!.celsius!.round().toString()}°C",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/12.png",
                                    scale: 9,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Temp Min",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "${state.weather.tempMin!.celsius!.round().toString()}°C",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
