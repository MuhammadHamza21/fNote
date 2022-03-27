import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnote/bloc/app_cubit.dart';
import 'package:fnote/bloc/app_states.dart';
import 'package:fnote/presentation/note_page.dart';
import 'package:fnote/shared/widgets/main_title_widget.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  int itemCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<AppCubit>(context),
                child: NotePage(),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Fnote'),
      ),
      body: AppCubit.get(context).notes.isEmpty
          ? Center( 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 80,
                    color: Colors.grey,
                  ),
                  Text(
                    'Note is empty try add notes!',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                print(index);
                return MainTitleWidget(
                  title: AppCubit.get(context).notes[index]['title'],
                  date: AppCubit.get(context).notes[index]['date'],
                  id: AppCubit.get(context).notes[index]['id'],
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<AppCubit>(context),
                          child: NotePage(
                            id: AppCubit.get(context).notes[index]['id'],
                            reuseTitle: AppCubit.get(context).notes[index]
                                ['title'],
                            reuseBody: AppCubit.get(context).notes[index]
                                ['body'],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              itemCount: AppCubit.get(context).notes.length,
            ),
    );
  }
}
