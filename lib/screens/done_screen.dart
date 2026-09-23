import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:jiffy/jiffy.dart';
import 'package:local_database_notes_app/business_logic/cubit/task_cubit.dart';
import 'package:local_database_notes_app/model/task_model.dart';
import 'package:local_database_notes_app/widgets/task_widget.dart';
import 'package:lottie/lottie.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({super.key});

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  void initState() {
    super.initState();
    TaskCubit.get(context).getDoneTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Done Tasks",
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
          if (state is RemoveTaskSuccess) {
            TaskCubit.get(context).doneTaskList.removeWhere((element) {
              return element.id == state.removeId;
            });
          }
        },
        builder: (context, state) {
          return state is GetDoneTaskListLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xffE53170),
                    color: Color(0xffE53170),
                  ),
                )
              : TaskCubit.get(context).doneTaskList.isNotEmpty
              ? GroupedListView<TaskModel, String>(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  elements: TaskCubit.get(context).doneTaskList,
                  groupBy: (element) {
                    final date = DateTime.parse(
                      element.dateTime ?? DateTime.now().toString(),
                    );
                    return "${date.year}-${date.month}-${date.day}";
                  },
                  order: GroupedListOrder.ASC,
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) {
                    final d1 = DateTime.parse(item1.dateTime ?? "");
                    final d2 = DateTime.parse(item2.dateTime ?? "");
                    return d2.compareTo(d1); // الأحدث الأول جوه اليوم نفسه
                  },
                  groupSeparatorBuilder: (String groupByValue) {
                    final parts = groupByValue.split('-');
                    final date = DateTime(
                      int.parse(parts[0]),
                      int.parse(parts[1]),
                      int.parse(parts[2]),
                    );
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        Jiffy.parseFromDateTime(date).yMMMMEEEEd,
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
                    return TaskWidget(
                      taskModel: element,
                      onDeletePressed: () {
                        TaskCubit.get(context).removeTask(
                          removeId: element.id ?? 0,
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
    );
  }
}
