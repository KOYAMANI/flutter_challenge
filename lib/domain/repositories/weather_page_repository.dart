class WeatherPageRepository {
  Future<String> fetchData(String tempreature) async {
    await Future.delayed(const Duration(seconds: 1));
    return tempreature;
  }
}
