import 'package:andi_taxi/ui/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
//       create: (context) {
//         favoritesList = Favorites();
//         return favoritesList;
//       },
//       child: MaterialApp(
//         home: FavoritesPage(),
//       ),
//     );
Widget createWelcomeScreen() => MaterialApp(home: Welcome());

void main() {
  final mainKey = Key('main');
  final pvKey = Key('pv');
  final dotKey = Key('dot');
  final signBtnKey = Key('sign-btn');

  group("Welcome UI", () {
    testWidgets("All the main widgets are there", (WidgetTester tester) async {
      await tester.pumpWidget(createWelcomeScreen());

      expect(find.byKey(mainKey), findsOneWidget);
      expect(find.byKey(pvKey), findsOneWidget);
      expect(find.byKey(dotKey), findsOneWidget);
      expect(find.byKey(signBtnKey), findsNothing);
    });

    testWidgets("The page viewer swipe and sign buttons appears", (WidgetTester tester) async {
      await tester.pumpWidget(createWelcomeScreen());

      expect(find.byKey(signBtnKey), findsNothing);

      // final pv = tester.widget<PageView>(find.byKey(pvKey));
      // final pv = find.byKey(pvKey);
      final pv = find.byType(PageView);

      var dotKey0 = tester.widget<Material>(find.byKey(Key('dot_0')));
      expect(dotKey0.color, Colors.white);

      // pv.
      await tester.drag(pv, const Offset(-20.0, 0.0));
      await tester.pump();
      
      var dotKey1 = tester.widget<Material>(find.byKey(Key('dot_1')));
      expect(dotKey1.color, Colors.white);
      dotKey0 = tester.widget<Material>(find.byKey(Key('dot_0')));
      expect(dotKey0.color, Colors.blue);
      
      expect(find.byKey(signBtnKey), findsNothing);

      // await tester.drag(pv, const Offset(-100.0, 0.0));
      // await tester.pump();
      // expect(find.byKey(signBtnKey), findsNothing);

      // await tester.drag(pv, const Offset(-100, 0.0));
      // await tester.pump();
      // expect(find.byKey(signBtnKey), findsOneWidget);
    });
  });
}