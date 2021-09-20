import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_challenge/app.dart';
import 'package:flutter_challenge/views/pages/pages.dart';
import 'package:flutter_challenge/views/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

@GenerateMocks([http.Client])
void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  const String uri =
      "https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json";
  const String res =
      '{ "product" : "astro" , "init" : "2021091906" ,"dataseries" : [{"timepoint" : 3,"cloudcover" : 8,"seeing" : 6,"tansparency" : 3,"lifted_index" : -4,"rh2m" : 6,"wind10m" : {"direction" : "SW","speed" : 2},"temp2m" : 33,"prec_type" : "rain"},{"timepoint" : 6,"cloudcover" : 8,"seeing" : 7,"transparency" : 4,"lifted_index" : -4,"rh2m" : 9,"wind10m" : {"direction" : "S","speed" : 3},"temp2m" : 31,"prec_type" : "rain"},]}';
  testWidgets('Run App and route to Navigation Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    expect(find.byType(NavigationScreen), findsOneWidget);
  });

  testWidgets('Test http connection', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final HttpClient client = HttpClient();
      final HttpClientRequest request = await client.getUrl(Uri.parse(uri));

      final HttpClientResponse res = await request.close();
      print(res.statusCode);
    });
  });

  //[TODO] fix test failure
  //Test failed "No implementation found for method requestPermission"
  testWidgets('Test with HTTP enabled', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final HttpClient client = HttpClient();
      final HttpClientRequest request = await client.getUrl(Uri.parse(uri));
      final HttpClientResponse res = await request.close();
      await tester.pumpWidget(const ProviderScope(child: App()));
      expect(find.byType(NavigationScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(WeatherPage), findsOneWidget);
    });
  });
}
