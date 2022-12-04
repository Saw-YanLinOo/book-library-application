import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/add_to_shelf_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:provider/provider.dart';

class AddToShelfPage extends StatefulWidget {
  const AddToShelfPage({
    Key? key,
    this.book,
  }) : super(key: key);

  final BookVO? book;

  @override
  State<AddToShelfPage> createState() => _AddToShelfPageState();
}

class _AddToShelfPageState extends State<AddToShelfPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    var bloc = Provider.of<AddToShelfBloc>(context, listen: false);
    bloc.isDispose = true;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddToShelfBloc>.value(
      value: AddToShelfBloc(),
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
                if (mounted) {
                  Navigator.of(context).pop();
                }
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
          shouldRebuild: (previous, next) => true,
          selector: (context, bloc) => bloc.shelfList,
          builder: (context, shelfs, child) {
            return ListView.separated(
              itemCount: shelfs?.length ?? 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM),
              itemBuilder: (context, index) {
                var shelf = shelfs?[index];

                return ShelfView(
                  shelf: shelf,
                  isCheck: shelf?.bookTiteList?.contains(widget.book?.title),
                  onShelfCheck: (value) {
                    Provider.of<AddToShelfBloc>(context, listen: false)
                        .bookToShelf(
                      shelf ?? ShelfVO(),
                      widget.book ?? BookVO(),
                      value ?? false,
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
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
            key: Key('${shelf?.bookList?.last.title}'),
            imageUrl: '${shelf?.bookList?.last.bookImage}',
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
