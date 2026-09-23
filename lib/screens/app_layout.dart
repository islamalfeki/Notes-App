import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_database_notes_app/screens/done_screen.dart';
import 'package:local_database_notes_app/screens/in_progress_screen.dart';

import '../utils/local_database_helper.dart';

class AppLayout extends StatefulWidget {
  AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  List<Widget> screenList = [InProgressScreen(), DoneScreen()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, -1),
              blurRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: "In Progress",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: "Done"),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          selectedItemColor: Color(0xffCA4E6A),
          iconSize: 32.sp,
          selectedFontSize: 16.sp,
          backgroundColor: Colors.white,
          selectedLabelStyle: TextStyle(
            color: Color(0xffD2D2D2),
            fontFamily: "Poppins",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: "Poppins",
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
