import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/resourses/dimens.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({
    Key? key,
    this.mBook,
  }) : super(key: key);

  final BookVO? mBook;
  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        actions: [
          Icon(
            Icons.file_upload_outlined,
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MARGIN_CARD_MEDIUM_2,
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 150,
                child:
                    CachedNetworkImage(imageUrl: '${widget.mBook?.posterPath}'),
              ),
              SizedBox(
                width: MARGIN_CARD_MEDIUM_2,
              ),
              Column(
                children: [
                  Text(
                    '${widget.mBook?.name}',
                    style: TextStyle(
                      fontSize: TEXT_HEADING_1X,
                    ),
                  ),
                  Text(
                    '${widget.mBook?.author}',
                    style: TextStyle(
                      fontSize: TEXT_SMALL,
                    ),
                  ),
                  Text(
                    '${widget.mBook?.author}',
                    style: TextStyle(
                      fontSize: TEXT_SMALL,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MARGIN_LARGE,
          ),
          const Divider(),
          Row(
            children: [
              SizedBox(
                width: MARGIN_XXL_LARGE,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('Free sample'),
                ),
              ),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_to_photos_outlined,
                  ),
                  label: Text(
                    'Add to whishlist',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.circleExclamation,
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  '${widget.mBook?.posterPath}',
                  style: TextStyle(
                    fontSize: TEXT_SMALL,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: MARGIN_LARGE,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM),
            child: Row(
              children: [
                Text(
                  'About this ebook',
                  style: TextStyle(
                    fontSize: TEXT_HEADING_1X,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM),
            child: Text(
              '${widget.mBook?.posterPath}',
              style: TextStyle(),
            ),
          ),
          SizedBox(
            height: MARGIN_LARGE,
          ),
          Row(
            children: [
              Text(
                'Ratings and reviews',
                style: TextStyle(
                  fontSize: TEXT_HEADING_1X,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
              ),
            ],
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    '3.9',
                    style: TextStyle(
                      fontSize: TEXT_BIG,
                    ),
                  ),
                  
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
