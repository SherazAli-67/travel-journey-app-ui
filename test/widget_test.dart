import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/main.dart';

void main() {
  testWidgets('Welcome screen loads as initial route', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    expect(find.textContaining(StringConst.welcomeHeadlineLine1), findsOneWidget);
  });
}
