import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_challenge/app.dart';
import 'package:flutter_challenge/views/pages/pages.dart';
import 'package:flutter_challenge/views/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_challenge/domain/apis/api.dart';
import 'package:flutter_challenge/domain/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

@GenerateMocks([http.Client])
void main() {
  // "https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json";
  const String res =
      '{ "product" : "astro" , "init" : "2021091906" ,"dataseries" : [{"timepoint" : 3,"cloudcover" : 8,"seeing" : 6,"tansparency" : 3,"lifted_index" : -4,"rh2m" : 6,"wind10m" : {"direction" : "SW","speed" : 2},"temp2m" : 33,"prec_type" : "rain"},{"timepoint" : 6,"cloudcover" : 8,"seeing" : 7,"transparency" : 4,"lifted_index" : -4,"rh2m" : 9,"wind10m" : {"direction" : "S","speed" : 3},"temp2m" : 31,"prec_type" : "rain"},]}';
  final UserLocation userLocation = UserLocation(
      latitude: 0.0, longtitude: 0.0, country: 'country', city: 'city');
  group('fetchAlbum', () {
    test('returns WeatherData if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.https('my-json-server.typicode.com',
              'KOYAMANI/fetchWeather/dataseries')))
          .thenAnswer((_) async => http.Response('res', 200));

      expect(await fetchWeather(userLocation), isA<List<WeatherData>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client.get(Uri.https(
              'my-json-server.typicode.com', 'KOYAMANI/setColor/color')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchWeather(client), throwsException);
    });
  });
}
