import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app_bloc/Widgets/gridTile.dart';
import 'package:notes_app_bloc/bloc/notes_bloc.dart';
import 'package:notes_app_bloc/constant.dart';
import 'package:notes_app_bloc/pages/note_add_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  void getAllNotes() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    BlocProvider.of<NotesBloc>(context)
        .add(NotesInitialEvent(user_id: user_id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.backGroundColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.backGroundColor,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const NoteAddPage();
                },
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: BlocConsumer<NotesBloc, NotesState>(
          listener: (context, state) {},
          builder: (context, state) {
            return state is NotesLoadingSate
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state is NotesLoadedSate && state.notes.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                top: 60,
                                bottom: 20,
                              ),
                              height: 45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Notes',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Constants.tabColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: GridView.custom(
                                gridDelegate: SliverStairedGridDelegate(
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  // startCrossAxisDirectionReversed: true,
                                  pattern: [
                                    StairedGridTile(0.5, 1),
                                    StairedGridTile(0.5, 1),
                                    StairedGridTile(1.0, 10 / 4),
                                  ],
                                ),
                                childrenDelegate: SliverChildBuilderDelegate(
                                  childCount: state.notes.length,
                                  (context, index) => MyGridTile(
                                    notes: state.notes[index],
                                    index: index,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: const Text('No Notes'),
                      );
          },
        ));
  }
}
