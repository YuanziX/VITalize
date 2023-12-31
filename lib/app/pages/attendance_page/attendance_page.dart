import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:vitalize/app/core/widgets/center_widget_in_column.dart';
import 'package:vitalize/app/core/widgets/centered_circular_progress_bar.dart';
import 'package:vitalize/app/pages/attendance_page/cubit/attendance_page_cubit.dart';
import 'package:vitalize/app/pages/attendance_page/widgets/attendance_card.dart';

class AttendancePageProvider extends StatelessWidget {
  const AttendancePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendancePageCubit()..loadAttendanceFromBox(),
      child: const AttendancePage(),
    );
  }
}

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  Future<IndicatorResult> _onRefresh(BuildContext context) async {
    await BlocProvider.of<AttendancePageCubit>(context).loadAttendanceFromApi();
    return BlocProvider.of<AttendancePageCubit>(context).responseStatus
        ? IndicatorResult.success
        : IndicatorResult.fail;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendancePageCubit, AttendancePageState>(
      builder: (context, state) {
        if (state is AttendancePageInitial) {
          return const CenteredCircularProgressBar();
        } else if (state is AttendancePageLoaded) {
          return AnimationLimiter(
            child: EasyRefresh(
              onRefresh: () async {
                return await _onRefresh(context);
              },
              child: ListView.builder(
                itemCount: state.attendance.length,
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 150),
                  child: SlideAnimation(
                    verticalOffset: 44,
                    child: FadeInAnimation(
                      child: AttendanceCard(
                        attendance: state.attendance.values.elementAt(index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is AttendancePageNoAttendanceInThisSem) {
          return EasyRefresh(
            onRefresh: () async {
              return await _onRefresh(context);
            },
            child: ListView(
              children: [
                CenterWidgetInColumn(
                  child: Text(
                    'No Attendance in current semester yet.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Placeholder();
        }
      },
    );
  }
}
