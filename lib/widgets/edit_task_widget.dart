import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';

import '../business_logic/cubit/task_cubit.dart';
import '../enums/task_level_enum.dart';
import '../model/task_model.dart';

class EditTaskWidget extends StatefulWidget {
  final TaskModel taskModel;

  const EditTaskWidget({super.key, required this.taskModel});

  @override
  State<EditTaskWidget> createState() => _EditTaskWidgetState();
}

class _EditTaskWidgetState extends State<EditTaskWidget> {
  void intResources() {
    titleController = TextEditingController(text: widget.taskModel.title);
    value = taskLevel.firstWhere((element) {
      return element.name == widget.taskModel.level;
    });
    dateTime = widget.taskModel.dateTime;
  }

  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  List<TaskLevelEnum> taskLevel = [
    TaskLevelEnum.Low,
    TaskLevelEnum.Medium,
    TaskLevelEnum.High,
  ];
  TaskLevelEnum? value;
  String? dateTime;

  @override
  void initState() {
    super.initState();
    intResources();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a task title";
                }
              },
              controller: titleController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
              decoration: InputDecoration(
                fillColor: Color(0xffF8F8F8),
                filled: true,
                label: Text("Task Title"),
                labelStyle: TextStyle(
                  color: Color(0xffD2D2D2),
                  fontFamily: "Poppins",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                hintText: "Add New Task",
                hintStyle: TextStyle(
                  color: Color(0xffD2D2D2),
                  fontFamily: "Poppins",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(59.29.r),
                  ),
                  borderSide: BorderSide(color: Color(0xffF8F8F8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(59.29.r),
                  ),
                  borderSide: BorderSide(color: Color(0xffCA4E6A)),
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            DropdownButtonFormField(
              validator: (level) {
                if (level == null) {
                  return "Please enter a task level";
                }
              },
              decoration: InputDecoration(
                fillColor: Color(0xffF8F8F8),
                filled: true,
                labelStyle: TextStyle(
                  color: Color(0xffD2D2D2),
                  fontFamily: "Poppins",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                labelText: 'Level',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(59.29.r),
                  ),
                  borderSide: BorderSide(color: Color(0xffF8F8F8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(59.29.r),
                  ),
                  borderSide: BorderSide(color: Color(0xffCA4E6A)),
                ),
              ),
              items: taskLevel
                  .map(
                    (level) => DropdownMenuItem(
                      value: level,
                      child: Text(
                        level.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: value,
              onChanged: (level) {
                setState(() {
                  value = level;
                });
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      Duration(days: 365),
                    ),
                  ).then((date) {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((time) {
                      dateTime = date
                          ?.add(
                            Duration(
                              hours: time?.hour ?? 0,
                              minutes: time?.minute ?? 0,
                            ),
                          )
                          .toString();
                      setState(() {});
                    });
                  });
                },
                child: Text(
                  dateTime != null
                      ? Jiffy.parse(dateTime ?? "").yMMMMEEEEdjm
                      : "Select Date",
                  style: TextStyle(
                    color: Color(0xffCA4E6A),
                    fontFamily: "Poppins",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 12.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.sp),
              width: 335.w,
              height: 61.w,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    TaskCubit.get(context).editTask(
                      taskModel: TaskModel(
                        id: widget.taskModel.id,
                        title: titleController.text,
                        level: value!.name,
                        dateTime: dateTime ?? "",
                      ),
                    );

                    if (mounted) {
                      Navigator.of(
                        context,
                      ).pop(true); // ← يقفل الـ bottom sheet ويبعت true
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffCA4E6A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  "Edit Task",
                  style: TextStyle(
                    color: Color(0xffF3F3F3),
                    fontFamily: "Nunito",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
