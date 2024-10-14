import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:todo_app/features/tasks/widget/task_item_widget.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:easy_localization/easy_localization.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();

  var _focusDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = BlocProvider.of<AuthCubit>(context);
    var mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 55),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.only(top: 50, left: 30),
                color: theme.primaryColor,
                height: mediaQuery.size.height * 0.18,
                width: mediaQuery.size.width,
                child: Text(
                  "to_do_list".tr(), // Localized title
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Positioned(
                top: 110,
                child: SizedBox(
                  width: mediaQuery.size.width,
                  child: EasyInfiniteDateTimeLine(
                    timeLineProps: EasyTimeLineProps(
                      separatorPadding: 10,
                    ),
                    showTimelineHeader: false,
                    controller: _controller,
                    firstDate: DateTime(2024),
                    focusDate: _focusDate,
                    dayProps: EasyDayProps(
                      activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        monthStrStyle: theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                        dayStrStyle: theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                        dayNumStyle: theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        monthStrStyle: theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        dayStrStyle: theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        dayNumStyle: theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      todayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        monthStrStyle: theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        dayStrStyle: theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        dayNumStyle: theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    onDateChange: (selectedDate) {
                      setState(() {
                        _focusDate = selectedDate;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseUtils.getRealTimeDataFromFirestore(
                collectionName: provider.getUserUid!, selectedDate: _focusDate),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text(
                    'something_went_wrong'.tr()); // Localized error message
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              var taskList =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItemWidget(
                      taskModel: taskList[index],
                    );
                  },
                  itemCount: taskList.length,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
