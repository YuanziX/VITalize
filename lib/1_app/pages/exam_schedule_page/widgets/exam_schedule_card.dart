import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamScheduleCard extends StatelessWidget {
  final Map subjects;

  const ExamScheduleCard(this.subjects, {super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    var sortedEntries = subjects.entries.toList()
      ..sort((a, b) {
        // Parse the date and time strings
        DateTime dateA = DateFormat('dd-MMM-yyyy hh:mm a')
            .parse(a.value['date'] + ' ' + a.value['duration'].split(' - ')[0]);
        DateTime dateB = DateFormat('dd-MMM-yyyy hh:mm a')
            .parse(b.value['date'] + ' ' + b.value['duration'].split(' - ')[0]);
        return dateA.compareTo(dateB);
      });

    Map sortedSubjects = Map.fromEntries(sortedEntries);

    return ListView.builder(
        itemCount: sortedSubjects.length,
        itemBuilder: (context, index) {
          final courseCode = sortedSubjects.keys.elementAt(index);
          final subject = sortedSubjects.values.elementAt(index);
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$courseCode: ${subject['name']}',
                    style: const TextStyle().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: Icon(
                      Icons.edit_calendar_sharp,
                      size: 18,
                      color: theme.colorScheme.secondary,
                    ),
                    title: Text(
                      subject['date'],
                      style: theme.textTheme.bodyMedium,
                    ),
                    trailing: Text(
                      subject['slot'],
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.alarm,
                      size: 18,
                      color: theme.colorScheme.secondary,
                    ),
                    title: Text(
                      timeRangeTo24Format(subject['duration']),
                      style: theme.textTheme.bodyMedium,
                    ),
                    trailing: Text(
                      timeTo24Format(subject['reportingTime']),
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w200),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on_rounded,
                      size: 18,
                      color: theme.colorScheme.secondary,
                    ),
                    title: Text(
                      '${subject['roomNo']} ${subject['venue']} - ${subject['seatLocation']}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    trailing: Text(subject['seatNo'],
                        style: theme.textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
          );
        });
  }

  String timeRangeTo24Format(String time) {
    List<String> times = time.split(' - ');

    DateFormat format12Hour = DateFormat('hh:mm a');

    DateTime startTime = format12Hour.parse(times[0]);
    DateTime endTime = format12Hour.parse(times[1]);

    String startTime24Hour = DateFormat('HH:mm').format(startTime);
    String endTime24Hour = DateFormat('HH:mm').format(endTime);

    return '$startTime24Hour - $endTime24Hour';
  }

  String timeTo24Format(String time) {
    return DateFormat('HH:mm')
        .format(DateFormat('hh:mm a').parse(time))
        .toString();
  }

  Widget _gap() => const SizedBox(height: 4);
  Widget _horizontalGap() => const SizedBox(height: 8);
}