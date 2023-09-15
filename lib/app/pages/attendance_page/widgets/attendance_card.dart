import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vitalize/app/core/routes/go_route_config.dart';
import 'package:vitalize/data/models/attendance.dart';

class AttendanceCard extends StatelessWidget {
  final Attendance attendance;

  const AttendanceCard({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          context.pushNamed(attendanceDetailPageConfig.name, extra: attendance);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                attendance.name,
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${attendance.type} - ${attendance.slot}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        'Total Classes: ${attendance.totalClasses}',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        'Attended Classes: ${attendance.attendedClasses}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircularPercentIndicator(
                        radius: 22,
                        progressColor: theme.colorScheme.primary,
                        percent:
                            double.parse(attendance.attendancePercentage) / 100,
                        center: Text(
                          '${attendance.attendancePercentage}%',
                          style: const TextStyle().copyWith(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 8)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
