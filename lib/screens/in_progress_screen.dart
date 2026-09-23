import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:jiffy/jiffy.dart';
import 'package:local_database_notes_app/business_logic/cubit/task_cubit.dart';
import 'package:local_database_notes_app/model/task_model.dart';
import 'package:local_database_notes_app/utils/local_database_helper.dart';
import 'package:local_database_notes_app/widgets/task_widget.dart';
import 'package:lottie/lottie.dart';

import '../widgets/add_task_widget.dart';
import '../widgets/edit_task_widget.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "In Progress Tasks",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Raleway",
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is IntDatabaseSuccess) {
            TaskCubit.get(context).getInProgressTaskList();
          }
          if (state is AddNewTaskSuccess) {
            TaskCubit.get(context).getInProgressTaskList();
          }

          if (state is MakeTaskDoneSuccess) {
            TaskCubit.get(context).inProgressTaskList.removeWhere((element) {
              return element.id == state.taskId;
            });
          }

          if (state is RemoveTaskSuccess) {
            TaskCubit.get(context).inProgressTaskList.removeWhere((element) {
              return element.id == state.removeId;
            });
          }

          if (state is EditTaskSuccess) {
            TaskCubit.get(context).getInProgressTaskList();
          }
        },
        builder: (context, state) {
          return state is GetInProgressTaskListLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xffE53170),
                    color: Color(0xffE53170),
                  ),
                )
              : TaskCubit.get(context).inProgressTaskList.isNotEmpty
              ? GroupedListView<TaskModel, String>(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  elements: TaskCubit.get(context).inProgressTaskList,
                  groupBy: (element) {
                    final date = DateTime.parse(
                      element.dateTime ?? DateTime.now().toString(),
                    );
                    return "${date.year}-${date.month}-${date.day}";
                  },
                  order: GroupedListOrder.ASC,
                  itemComparator: (item1, item2) {
                    final d1 = DateTime.parse(item1.dateTime ?? "");
                    final d2 = DateTime.parse(item2.dateTime ?? "");
                    return d1.compareTo(
                      d2,
                    );
                  },
                  groupSeparatorBuilder: (String groupByValue) {
                    final date = DateTime.parse(
                      "${groupByValue.split('-')[0]}-${groupByValue.split('-')[1].padLeft(2, '0')}-${groupByValue.split('-')[2].padLeft(2, '0')}",
                    );
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        Jiffy.parseFromDateTime(
                          date,
                        ).yMMMMEEEEd,
                        style: TextStyle(
                          color: Color(0xffCA4E6A),
                          fontFamily: "Poppins",
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                  itemBuilder: (context, element) {
                    // ملحوظة: هنا بقى بيرجع element مباشرة، مش index زي ListView
                    return TaskWidget(
                      taskModel: element,
                      onDonePressed: () {
                        TaskCubit.get(
                          context,
                        ).makeTaskDone(taskId: element.id ?? 0);
                      },
                      onDeletePressed: () {
                        TaskCubit.get(
                          context,
                        ).removeTask(removeId: element.id ?? 0);
                      },
                      onEditPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return EditTaskWidget(taskModel: element);
                          },
                        );
                      },
                    );
                  },
                )
              : Center(
                  child: Lottie.asset("assets/lottie/empty.json"),
                );
        },
      ),
      floatingActionButton: SizedBox(
        height: 64.h,
        width: 64.w,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return AddTaskWidget();
              },
            );
          },
          backgroundColor: Color(0xffCA4E6A),
          shape: CircleBorder(),
          foregroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 32.sp,
          ),
        ),
      ),
    );
  }
}
