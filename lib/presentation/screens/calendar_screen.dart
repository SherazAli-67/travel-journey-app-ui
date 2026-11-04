import 'package:flutter/material.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/presentation/widgets/stub_tab_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StubTabScreen(title: StringConst.calendarTitle);
  }
}
