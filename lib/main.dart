import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_database_notes_app/bloc_observer.dart';
import 'package:local_database_notes_app/business_logic/cubit/task_cubit.dart';
import 'package:local_database_notes_app/screens/app_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskCubit()..intDatabase()),
      ],
      child: ScreenUtilInit(
        designSize: Size(412, 846),
        minTextAdapt: true,
        splitScreenMode: true,
        child: SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Notes App",
            home: AppLayout(),
          ),
        ),
      ),
    );
  }
}
