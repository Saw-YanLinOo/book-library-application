import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/add_to_shelf_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:provider/provider.dart';

class AddToShelfPage extends StatelessWidget {
  const AddToShelfPage({
    Key? key,
    this.book,
  }) : super(key: key);

  final BookVO? book;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddToShelfBloc>(
      create: (context) => AddToShelfBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Add to Shelves',
            style: TextStyle(
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w200,
                color: Colors.black),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: MARGIN_CARD_MEDIUM,
                ),
                child: Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: Selector<AddToShelfBloc, List<ShelfVO>?>(
          selector: (context, bloc) => bloc.shelfList,
          builder: (context, shelfs, child) {
            return ListView.separated(
              itemCount: shelfs?.length ?? 0,
              itemBuilder: (context, index) {
                var shelf = shelfs?[index];

                return ShelfView(
                  shelf: shelf,
                  isCheck: shelf?.bookTiteList?.contains(book?.title),
                  onShelfCheck: (value) {
                    context.read<AddToShelfBloc>().bookToShelf(
                          shelf ?? ShelfVO(),
                          book ?? BookVO(),
                          value ?? false,
                        );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            );
          },
        ),
      ),
    );
  }
}

class ShelfView extends StatelessWidget {
  const ShelfView({
    Key? key,
    this.shelf,
    this.isCheck,
    required this.onShelfCheck,
  }) : super(key: key);

  final ShelfVO? shelf;
  final Function(bool?) onShelfCheck;
  final bool? isCheck;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CachedNetworkImage(
            imageUrl: '${shelf?.bookList?.first.bookImage}',
            fit: BoxFit.fill,
            errorWidget: (context, _, __) {
              return Container(
                width: 80,
                height: 80,
                color: Colors.grey,
              );
            },
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  '${shelf?.shelfName}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: TEXT_REGULAR_2X,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: MARGIN_SMALL,
              ),
              Text(
                '${shelf?.bookList?.length ?? 0} book',
                style: const TextStyle(fontSize: TEXT_SMALL),
              )
            ],
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Checkbox(
          value: isCheck ?? false,
          onChanged: (value) {
            onShelfCheck(value);
          },
        ),
      ],
    );
  }
}
