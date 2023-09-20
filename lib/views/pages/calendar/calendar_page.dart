import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scholarsync/views/widgets/app_bar.dart';
import 'package:scholarsync/themes/palette.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateFormat monthYearFormat = DateFormat('dd MMMM yyyy');
  EventController eventController = EventController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    eventController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: 'Calendar',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          titleCenter: false,
          onPressedListButton: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: DayView(
        timeLineBuilder: (date) {
          return Container(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              DateFormat('h a').format(date),
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 14,
              ),
            ),
          );
        },
        hourIndicatorSettings: HourIndicatorSettings(
          color: Theme.of(context).dividerColor,
        ),
        liveTimeIndicatorSettings: const HourIndicatorSettings(
            color: CommonColors.secondaryGreenColor),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        controller: eventController,
        showVerticalLine: false,
        minDay: DateTime(2023),
        maxDay: DateTime(2030),
        heightPerMinute: 1,
        scrollPhysics: const BouncingScrollPhysics(),
        pageViewPhysics: const BouncingScrollPhysics(),
        headerStyle: HeaderStyle(
          headerTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          leftIcon: Icon(
            PhosphorIcons.bold.arrowLeft,
            size: 20,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          rightIcon: Icon(
            PhosphorIcons.bold.arrowRight,
            size: 20,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          headerPadding: const EdgeInsets.only(bottom: 5),
        ),
        dateStringBuilder: (date, {secondaryDate}) {
          return monthYearFormat.format(date);
        },
        // ignore: avoid_print
        onEventTap: (events, date) => print(events),
      ),
    );
  }
}
