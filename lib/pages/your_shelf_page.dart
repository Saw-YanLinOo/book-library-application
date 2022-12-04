import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/pages/create_shelf_page.dart';
import 'package:library_app/pages/shelf_detail_page.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:provider/provider.dart';

class YourShelfPage extends StatelessWidget {
  const YourShelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Selector<LibraryPageBloc, List<ShelfVO>?>(
            shouldRebuild: (previous, next) => true,
            selector: (context, bloc) => bloc.shelflist,
            builder: (context, shelfs, child) {
              if (shelfs == null || shelfs.isEmpty) {
                return Center(
                  child: Text(
                    'No shelf',
                    style: TextStyle(
                      fontSize: TEXT_REGULAR,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: shelfs.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM),
                itemBuilder: (context, index) {
                  var shelf = shelfs[index];
                  return ShelfViewItem(
                    key: UniqueKey(),
                    shelf: shelf,
                    onTapForward: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShelfDetailPage(shelf: shelf),
                        ),
                      );
                    },
                  );
                },
              );
            }),
        Align(
          alignment: Alignment.bottomCenter,
          child: NewSheetButton(
            key: const Key('CreateNewShelf'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateShelfPage()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NewSheetButton extends StatelessWidget {
  const NewSheetButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
        //_showAddShelf(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
        ),
        padding: const EdgeInsets.all(MARGIN_MEDIUM),
        margin: const EdgeInsets.only(bottom: MARGIN_CARD_MEDIUM),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.edit,
              color: Colors.white,
              size: MARGIN_MEDIUM_2,
            ),
            SizedBox(
              width: MARGIN_SMALL,
            ),
            Text(
              'Create New',
              style: TextStyle(
                  fontSize: TEXT_SMALL,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class ShelfViewItem extends StatelessWidget {
  const ShelfViewItem({
    Key? key,
    required this.shelf,
    required this.onTapForward,
  }) : super(key: key);

  final ShelfVO shelf;
  final Function onTapForward;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: shelf.bookList?.last.bookImage == null
                  ? Container(
                      color: Colors.grey,
                    )
                  : CachedNetworkImage(
                      imageUrl: '${shelf.bookList?.last.bookImage}',
                      fit: BoxFit.cover,
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
                      '${shelf.shelfName}',
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
                    '${shelf.bookList?.length ?? 0} book',
                    style: TextStyle(fontSize: TEXT_SMALL),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            InkWell(
              onTap: () {
                onTapForward();
              },
              child: Icon(
                Icons.arrow_forward_ios,
              ),
            )
          ],
        ),
        Divider(),
      ],
    );
  }
}
