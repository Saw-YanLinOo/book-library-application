import 'dart:async';

import 'package:flutter/material.dart';
import 'package:library_app/blocs/shelf_bloc.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:provider/provider.dart';

class CreateShelfPage extends StatefulWidget {
  const CreateShelfPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateShelfPage> createState() => _CreateShelfPageState();
}

class _CreateShelfPageState extends State<CreateShelfPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShelfBloc>(
        create: (context) => ShelfBloc(),
        builder: (context, child) {
          return Scaffold(
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
                  height: MARGIN_XXXXL_LARGE,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Shelf name",
                      hintStyle: TextStyle(
                        fontSize: TEXT_HEADING_1X,
                      ),
                    ),
                    onSubmitted: (value) {
                      var shelf = ShelfVO(shelfName: value);

                      Provider.of<ShelfBloc>(context, listen: false)
                          .addShelf(shelf);

                      Timer.periodic(const Duration(seconds: 1), (timer) {
                        if (mounted) {
                          Navigator.pop(context);
                        }
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
          );
        });
  }
}
