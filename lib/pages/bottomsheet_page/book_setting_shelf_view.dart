import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/resourses/dimens.dart';

class BookSettingSheetView extends StatelessWidget {
  const BookSettingSheetView({
    Key? key,
    this.book,
    required this.onTapAboutThisBook,
    required this.onTapDelete,
    required this.onTapAddToShelf,
    required this.onTapClose,
  }) : super(key: key);

  final BookVO? book;
  final Function onTapAboutThisBook;
  final Function onTapDelete;
  final Function onTapAddToShelf;
  final Function onTapClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_CARD_MEDIUM,
            vertical: MARGIN_MEDIUM_2,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                height: 80,
                child: CachedNetworkImage(
                  imageUrl: '${book?.bookImage}',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: MARGIN_MEDIUM,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      '${book?.title}',
                      style: const TextStyle(
                        fontSize: TEXT_REGULAR,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    '${book?.author}',
                    style: const TextStyle(
                      fontSize: TEXT_SMALL,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            //onEdit();
          },
          leading: Icon(Icons.file_download_outlined),
          title: Text(
            'Download',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            onTapDelete();
          },
          leading: Icon(Icons.delete),
          title: Text(
            'Delete from your library',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            onTapAddToShelf();
          },
          leading: Icon(Icons.add),
          title: Text(
            'Add to Shelf',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            //onDelected();
          },
          leading: Icon(Icons.done),
          title: Text(
            'Make as read',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            //onDelected();
            onTapAboutThisBook();
          },
          leading: Icon(Icons.book),
          title: Text(
            'About this book',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            //onDelected();
            onTapClose();
          },
          leading: Icon(Icons.clear),
          title: Text(
            'Close',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
      ],
    );
  }
}
