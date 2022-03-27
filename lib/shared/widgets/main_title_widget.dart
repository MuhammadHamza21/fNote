import 'package:flutter/material.dart';
import 'package:fnote/bloc/app_cubit.dart';

class MainTitleWidget extends StatelessWidget {
  late final String title;
  late final String date;
  late final int id;
  final Function() onPressed;
  MainTitleWidget({
    required this.title,
    required this.date,
    required this.id,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        AppCubit.get(context).deleteRecordFromDatabase(id);
      },
      key: UniqueKey(),
      // ignore: deprecated_member_use
      child: FlatButton(
        padding: EdgeInsets.only(
          top: 5,
          left: 2,
          right: 2,
          bottom: 5,
        ),
        minWidth: double.infinity,
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.only(
            right: 30,
            left: 10,
          ),
          color: Colors.white,
          height: 75,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
