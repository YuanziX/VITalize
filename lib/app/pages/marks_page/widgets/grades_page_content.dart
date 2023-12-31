import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalize/app/core/widgets/animated_column.dart';
import 'package:vitalize/app/pages/marks_page/cubit/grades_page_cubit.dart';

class GradesPageContent extends StatelessWidget {
  final Map grades;

  const GradesPageContent(this.grades, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return EasyRefresh(
      onRefresh: () async {
        await BlocProvider.of<GradesPageCubit>(context).getGradesFromApi();
        return BlocProvider.of<GradesPageCubit>(context).responseStatus
            ? IndicatorResult.success
            : IndicatorResult.fail;
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          Text(
            'Overview',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedColumn(
                children: [
                  ListTile(
                    title: Text(
                      'CGPA',
                      style: theme.textTheme.headlineSmall!.copyWith(
                          fontSize: 18, color: theme.colorScheme.secondary),
                    ),
                    trailing: Text(grades['cgpa'],
                        style:
                            theme.textTheme.bodyMedium!.copyWith(fontSize: 16)),
                  ),
                  ListTile(
                    title: Text(
                      'Credits Earned',
                      style: theme.textTheme.headlineSmall!.copyWith(
                          fontSize: 18, color: theme.colorScheme.secondary),
                    ),
                    trailing: Text(grades['creditsEarned'],
                        style:
                            theme.textTheme.bodyMedium!.copyWith(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Subject-wise grade',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedColumn(
                children: [
                  for (var subject in (grades['subjects'] as Map).values)
                    ListTile(
                      title: Text(
                        subject['name'],
                        style: theme.textTheme.bodyMedium,
                      ),
                      trailing: Text(
                        subject['grade'],
                        style: theme.textTheme.bodyMedium,
                      ),
                      subtitle: Text('Credits: ${subject['credits']}'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
