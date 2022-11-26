import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:lottie/lottie.dart';

class LargeBookViewItem extends StatelessWidget {
  const LargeBookViewItem({
    Key? key,
    this.book,
    required this.onTapSeeMore,
    required this.onTapBook,
  }) : super(key: key);

  final BookVO? book;
  final Function onTapSeeMore;
  final Function onTapBook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTapBook();
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM,
          vertical: MARGIN_MEDIUM,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 160,
                  height: 220,
                  child: CachedNetworkImage(
                    imageUrl: book?.bookImage ?? '',
                    fit: BoxFit.fill,
                    errorWidget: (context, _, __) {
                      return Lottie.asset('assets/book.json');
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      onTapSeeMore();
                    },
                    child: const Icon(
                      FontAwesomeIcons.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Icon(
                        Icons.headphones_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${book?.title}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: TEXT_SMALL,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${book?.author}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: TEXT_SMALL,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
