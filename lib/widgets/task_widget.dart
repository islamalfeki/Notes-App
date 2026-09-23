import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:local_database_notes_app/model/task_model.dart';

class TaskWidget extends StatelessWidget {
  final void Function()? onDonePressed;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final TaskModel taskModel;

  const TaskWidget({
    super.key,
    this.onDonePressed,
    this.onEditPressed,
    this.onDeletePressed,
    required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.sp),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      width: double.infinity,
      // height: 100.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(0, 10.h),
            blurRadius: 12.r,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskModel.title,
                  style: TextStyle(
                    color: Color(0xffCA4E6A),
                    fontFamily: "Poppins",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  Jiffy.parse(taskModel.dateTime ?? "").yMMMMEEEEdjm,
                  style: TextStyle(
                    color: Color(0xffCA4E6A),
                    fontFamily: "Poppins",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffFCEEF5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    taskModel.level,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: "inter",
                      color: Color(0xff571032),
                    ),
                  ),
                ),
              ],
            ),
          ),
          taskModel.isDone == true
              ? Row(
                  children: [
                    IconButton(
                      onPressed: onDeletePressed,
                      style: IconButton.styleFrom(),

                      icon: Icon(Icons.delete, color: Color(0xffCA4E6A)),
                    ),
                    Icon(Icons.task_alt, color: Colors.green),
                  ],
                )
              : Row(
                  children: [
                    IconButton(
                      onPressed: onDonePressed,
                      icon: Icon(Icons.task_alt, color: Color(0xffCA4E6A)),
                    ),
                    IconButton(
                      onPressed: onEditPressed,

                      icon: Icon(Icons.edit, color: Color(0xffCA4E6A)),
                    ),
                    IconButton(
                      onPressed: onDeletePressed,
                      style: IconButton.styleFrom(),

                      icon: Icon(Icons.delete, color: Color(0xffCA4E6A)),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
