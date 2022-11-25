import 'dart:async';

import 'package:flutter/material.dart';
import 'package:library_app/blocs/add_to_shelf_bloc.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/blocs/shelf_bloc.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:provider/provider.dart';

class CreateShelfPage extends StatelessWidget {
  const CreateShelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    return ChangeNotifierProvider<AddToShelfBloc>(
      create: (context) => AddToShelfBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Create Shelf',
            style: TextStyle(
              fontSize: TEXT_REGULAR,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: MARGIN_XXXL_LARGE,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: "Shelf name",
                  hintStyle: TextStyle(
                    fontSize: TEXT_HEADING_1X,
                  ),
                ),
                onSubmitted: (value) {
                  var shelf = ShelfVO(shelfName: value);

                  Provider.of<AddToShelfBloc>(context).addShelf(shelf);
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                    Navigator.pop(context);
                  });
                },
              ),
            ),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
