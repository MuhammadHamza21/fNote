import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnote/presentation/home_page.dart';
import 'bloc/app_cubit.dart';
import 'bloc/app_states.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fnote',
      home: BlocProvider(
        create: (context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, states) {
            return HomePage();
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}


// onChanged: (value) {
            //   setState(() {
            //     if (value.isNotEmpty) {
            //       isEmpty = false;
            //     } else {
            //       isEmpty = true;
            //     }
            //   });
            // },