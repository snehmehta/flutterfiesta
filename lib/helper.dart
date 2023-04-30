import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map> getCurrentWeather() async {
  const String url =
      'https://api.openweathermap.org/data/2.5/weather?=&lat=21.1365438&lon=72.7606162&units=metric&appid=bd2405271307d866fda95eaabac3e4dd';

  final response = await http.get(Uri.parse(url));

  return json.decode(response.body);
}

Future<Map> getForecast() async {
  const String url =
      'https://api.openweathermap.org/data/2.5/forecast?=&lat=33.44&lon=72.7606199&units=metric&appid=bd2405271307d866fda95eaabac3e4dd';

  final response = await http.get(Uri.parse(url));

  return json.decode(response.body);
}

const lottieAnimations = {
  "Clear": "sun.json?alt=media&token=1df3a50c-c2a6-4445-b3da-bfe99da1b416",
  "Drizzle":
      "cloud_rain.json?alt=media&token=9f0dcce5-389e-4b61-9705-cd3e9b08d539",
  "Rain":
      "cloud_rain.json?alt=media&token=9f0dcce5-389e-4b61-9705-cd3e9b08d539",
  "Snow": "snow.json?alt=media&token=8a31ad4b-f99f-4f54-adc2-008e4fa10527",
  "Clouds": "cloud.json?alt=media&token=18853386-7ce6-44ac-83a2-08c0124de72d",
  "Mist":
      "cloud_wind.json?alt=media&token=c87e658a-afb5-4868-872f-4423b47ab1d9",
  "Smoke":
      "cloud_wind.json?alt=media&token=c87e658a-afb5-4868-872f-4423b47ab1d9",
  "Haze":
      "cloud_wind.json?alt=media&token=c87e658a-afb5-4868-872f-4423b47ab1d9",
  "Dust":
      "cloud_wind.json?alt=media&token=c87e658a-afb5-4868-872f-4423b47ab1d9",
  "Fog": "cloud_wind.json?alt=media&token=c87e658a-afb5-4868-872f-4423b47ab1d9",
  "Sand":
      "cloud_wind.json?alt=media&token=c87e658a-afb5-4868-872f-4423b47ab1d9",
  "Ash": "cloud_wind.json?alt=media&token=c87e658a-afb5-4868-872f-4423b47ab1d9",
  "Squall":
      "cloud_wind.json?alt=media&token=c87e658a-afb5-4868-872f-4423b47ab1d9",
  "Tornado":
      "cloud_wind.json?alt=media&token=c87e658a-afb5-4868-872f-4423b47ab1d9",
  "Thunderstorm":
      "cloud_thunder_heavyrain.json?alt=media&token=02fd5715-6bc6-4af0-98c6-75ac8f968e5a"
};
String getLottieAnimation(condition) {
  const baseURL =
      "https://firebasestorage.googleapis.com/v0/b/ensemble-web-studio.appspot.com/o/demo_apps%2Fweather-app%2F";

  return baseURL + lottieAnimations[condition]!;
}

String formatTime(String datetime) {
  DateTime time = DateTime.parse(datetime);
  time = DateTime(time.year, time.month, time.day, time.hour, time.minute);
  String formattedTime =
      "${time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour < 12 ? 'AM' : 'PM'}";
  return formattedTime;
}
