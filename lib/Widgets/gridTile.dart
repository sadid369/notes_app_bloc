// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_bloc/bloc/notes_bloc.dart';
import 'package:notes_app_bloc/constant.dart';
import 'package:notes_app_bloc/model/notes.dart';
import 'package:notes_app_bloc/pages/note_display_page.dart';

class MyGridTile extends StatelessWidget {
  final Notes notes;
  final int index;

  const MyGridTile({
    Key? key,
    required this.notes,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return NoteDisplayPage(index: index);
          },
        ));
      },
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Constants
                  .listColors[Random().nextInt(Constants.listColors.length)],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              // mainAxisAlignment:
              //     MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 45,
                    left: 5,
                    right: 5,
                  ),
                  // height: 150,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      overflow: TextOverflow.ellipsis,

                      maxLines: 4,
                      // '''${notes[index].title.toString()}''',
                      '''${notes.title.toString()}''',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Align(
                    // alignment: Alignment.bottomLeft,
                    child: Text(
                      DateFormat.yMMMMd().format(notes.dateTime),
                      style: TextStyle(
                        color: Constants.backGroundColor.withOpacity(0.3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Constants.backGroundColor,
                        content: const Text(
                          'Delete This Note!!!!',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<NotesBloc>(context)
                                  .add(NotesDeleteEvent(
                                id: notes.note_id!,
                              ));
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete_forever_sharp,
                  color: Constants.tabColor,
                  size: 25,
                )),
          ),
        ],
      ),
    );
  }
}
