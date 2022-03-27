import 'package:flutter/material.dart';
import 'package:fnote/bloc/app_cubit.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NotePage extends StatelessWidget {
  NotePage({
    this.reuseBody = '',
    this.reuseTitle = '',
    this.id,
  });
  final String reuseTitle;
  final String reuseBody;
  final int? id;
  int index = 0;
  bool isEmpty = true;
  var titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool autoTitleTyping = true;

  @override
  Widget build(BuildContext context) {
    titleController.text = reuseTitle;
    bodyController.text = reuseBody;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          color: Colors.white,
          height: 45,
          child: TextFormField(
            onChanged: (value) {
              if (titleController.text.isEmpty) {
                autoTitleTyping = false;
              }
            },
            cursorWidth: 3,
            controller: titleController,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (reuseBody == '' && reuseTitle == '') {
                if (titleController.text == '') {
                  titleController.text =
                      DateFormat.yMMMd().format(DateTime.now()).toString();
                }
                AppCubit.get(context).insertRecordToDatabase(
                  title: titleController.text,
                  body: bodyController.text,
                  date: DateFormat.MMMd().format(DateTime.now()).toString(),
                );
              } else {
                if (titleController.text.isEmpty) {
                  titleController.text =
                      DateFormat.yMMMd().format(DateTime.now()).toString();
                }
                AppCubit.get(context).updateRecordFromDatabase(
                  id: id!,
                  title: titleController.text,
                  body: bodyController.text,
                  date: DateFormat.MMMd().format(DateTime.now()).toString(),
                );
              }

              Navigator.pop(context);
            },
            icon: Icon(
              Icons.save,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.all(5),
        child: TextFormField(
          onChanged: (value) {
            if (autoTitleTyping && index < 40) {
              titleController.text = value;
              index++;
            }
          },
          maxLines: 50,
          cursorHeight: 40,
          cursorWidth: 3.0,
          controller: bodyController,
          style: TextStyle(
            fontSize: 25,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class New extends StatelessWidget {
  const New({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(),
    );
  }
}
