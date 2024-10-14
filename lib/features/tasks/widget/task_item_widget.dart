import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:todo_app/features/tasks/widget/custom_alert_dialog.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:easy_localization/easy_localization.dart'; // Added this for localization

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = BlocProvider.of<AuthCubit>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.22,
          dragDismissible: false,
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) {},
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'edit'.tr(),
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.22,
          dragDismissible: false,
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      backgroundColor: theme.primaryColor,
                      content: Text(
                        "confirm_delete".tr(),
                        style: theme.textTheme.bodyMedium,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            "cancel".tr(),
                            style: theme.textTheme.bodyMedium,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Dismiss the dialog
                          },
                        ),
                        TextButton(
                          child: Text(
                            "delete".tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () {
                            // Show loading
                            EasyLoading.show();

                            // Perform delete operation
                            FirebaseUtils.deleteTask(
                              id: taskModel.id,
                              collectionName: provider.getUserUid!,
                            ).then((value) {
                              EasyLoading.dismiss();
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'delete'.tr(),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
              leading: Container(
                width: 4,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: taskModel.isDone ? Colors.green : theme.primaryColor,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          taskModel.isDone ? Colors.green : theme.primaryColor,
                    ),
                  ),
                  Text(
                    taskModel.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          taskModel.isDone ? Colors.green : theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.alarm,
                        size: 20,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat("dd/MM/yyyy").format(taskModel.selectedDate),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              trailing: taskModel.isDone
                  ? Text(
                      "task_done".tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onPressed: () {
                        EasyLoading.show();
                        FirebaseUtils.updateisDone(
                                taskModel: taskModel,
                                collectionName: provider.getUserUid!)
                            .then((value) => EasyLoading.dismiss());
                      },
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 35,
                      ),
                    )),
        ),
      ),
    );
  }
}
