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
  const String uri =
      "https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json";
  const String res =
      '{ "product" : "astro" , "init" : "2021091906" ,"dataseries" : [{"timepoint" : 3,"cloudcover" : 8,"seeing" : 6,"tansparency" : 3,"lifted_index" : -4,"rh2m" : 6,"wind10m" : {"direction" : "SW","speed" : 2},"temp2m" : 33,"prec_type" : "rain"},{"timepoint" : 6,"cloudcover" : 8,"seeing" : 7,"transparency" : 4,"lifted_index" : -4,"rh2m" : 9,"wind10m" : {"direction" : "S","speed" : 3},"temp2m" : 31,"prec_type" : "rain"},]}';
  testWidgets('Run App and route to Navigation Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    expect(find.byType(NavigationScreen), findsOneWidget);
  });

  testWidgets(
    'Test with HTTP enabled',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        final client = MockClient();
        when(client.get(Uri.parse(uri)))
            .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
        // when(client.get(any)).thenAnswer((_) async => await http.Response('{"title": "test"}', 200));
        print(res);
        await tester.pumpWidget(const ProviderScope(child: App()));
        expect(find.byType(NavigationScreen), findsOneWidget);
        await tester.pumpAndSettle();

        expect(find.byType(WeatherPage), findsOneWidget);
      });
    },
  );

  // testWidgets('Run App and route to WeatherPage', (WidgetTester tester) async {
  //   await tester.pumpWidget(const ProviderScope(child: App()));

  //   expect(find.byType(NavigationScreen), findsOneWidget);

  //   await tester.pumpAndSettle();

  //   expect(find.byType(WeatherPage), findsOneWidget);
  // });

  // testWidgets('Navigate CVPage from Weather Page', (WidgetTester tester) async {
  //   await tester.pumpWidget(const ProviderScope(child: App()));

  //   expect(find.text('Weather'), findsOneWidget);
  //   expect(find.text('Profile'), findsNothing);

  //   // await tester.tap(find.byIcon(Icons.person));
  //   // await tester.pumpAndSettle();

  //   // expect(find.byType(CircleAvatar), findsOneWidget);
  //   // expect(find.text('Weather'), findsNothing);
  // });
}

// await tester.tap(find.byIcon(Icons.person));
// Icons.wb_sunny,