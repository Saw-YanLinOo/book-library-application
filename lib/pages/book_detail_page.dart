import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/blocs/book_detail_bloc.dart';
import 'package:library_app/blocs/home_bloc.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:library_app/resourses/strings.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({
    Key? key,
    this.mBook,
    this.listName,
  }) : super(key: key);

  final BookVO? mBook;
  final String? listName;
  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    widget.mBook?.listName = widget.listName;
    widget.mBook?.openDate = DateTime.now();

    return ChangeNotifierProvider<BookDetailBloc>(
      lazy: false,
      create: (context) => BookDetailBloc(widget.mBook ?? BookVO()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: [
            Icon(
              Icons.file_upload_outlined,
              color: Colors.black,
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            )
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: MARGIN_CARD_MEDIUM_2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 150,
                    child: CachedNetworkImage(
                      imageUrl: '${widget.mBook?.bookImage}',
                      errorWidget: (context, _, __) {
                        return Lottie.asset('assets/book.json');
                      },
                    ),
                  ),
                  SizedBox(
                    width: MARGIN_CARD_MEDIUM_2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          '${widget.mBook?.title}',
                          style: TextStyle(
                            fontSize: TEXT_REGULAR_3X,
                          ),
                        ),
                      ),
                      Text(
                        '${widget.mBook?.author}',
                        style: TextStyle(
                          fontSize: TEXT_SMALL,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${widget.mBook?.author}',
                        style: TextStyle(
                          fontSize: TEXT_SMALL,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('Free sample'),
                  ),
                  SizedBox(
                    width: MARGIN_MEDIUM,
                  ),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_to_photos_outlined,
                        size: MARGIN_MEDIUM_2,
                        color: Colors.white,
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
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM_2,
              ),
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.circleExclamation,
                      size: MARGIN_CARD_MEDIUM_2,
                    ),
                    SizedBox(
                      width: MARGIN_MEDIUM,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        '${widget.mBook?.amazonProductUrl}',
                        style: TextStyle(
                          fontSize: TEXT_SMALL,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MARGIN_MEDIUM_2,
            ),
            Divider(),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'About this ebook',
                    style: TextStyle(
                      fontSize: TEXT_REGULAR_2X,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Text(
                '${widget.mBook?.description}',
                style: TextStyle(),
              ),
            ),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ratings and reviews',
                    style: TextStyle(
                      fontSize: TEXT_REGULAR_2X,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            '3.9',
                            style: TextStyle(
                              fontSize: TEXT_BIG,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MARGIN_SMALL,
                        ),
                        RatingBarIndicator(
                          rating: 2.75,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.blue,
                          ),
                          itemCount: 5,
                          itemSize: MARGIN_CARD_MEDIUM_3,
                        ),
                        SizedBox(
                          height: MARGIN_SMALL,
                        ),
                        Text(
                          '20 ratings',
                          style: TextStyle(fontSize: TEXT_SMALL),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextAndRatingBarView(
                          title: FIVE_STAR,
                          value: 0.2,
                        ),
                        TextAndRatingBarView(
                          title: FOUR_STAR,
                          value: 0.5,
                        ),
                        TextAndRatingBarView(
                          title: THREE_STAR,
                          value: 0.1,
                        ),
                        TextAndRatingBarView(
                          title: TWO_STAR,
                          value: 0.4,
                        ),
                        TextAndRatingBarView(
                          title: ONE_STAR,
                          value: 0.9,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MARGIN_CARD_MEDIUM_3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RatingChipItemView(title: '1'),
                  RatingChipItemView(title: '2'),
                  RatingChipItemView(title: '3'),
                  RatingChipItemView(title: '4'),
                  RatingChipItemView(title: '5'),
                ],
              ),
            ),
            SizedBox(
              height: MARGIN_CARD_MEDIUM_3,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
                      child: UserCommandItemView(
                        userName: widget.mBook?.contributor,
                        userProfileImage: widget.mBook?.bookImage,
                        description:
                            'Iv wanted to read this story for years now I was so hyped up that i finally bought it after so long.. Then I read it and was sort of disappointed.. I\'m not saying is wasn\'t good..',
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class UserCommandItemView extends StatelessWidget {
  const UserCommandItemView({
    Key? key,
    this.userName,
    this.userProfileImage,
    this.rating,
    this.description,
  }) : super(key: key);

  final String? userName;
  final String? userProfileImage;
  final double? rating;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              MARGIN_LARGE,
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: '$userProfileImage',
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$userName',
                style: TextStyle(
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: MARGIN_SMALL,
              ),
              RatingBarIndicator(
                rating: 2.75,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
                itemCount: 5,
                itemSize: MARGIN_CARD_MEDIUM_3,
              ),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Text(
                '$description',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: TEXT_SMALL,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingChipItemView extends StatelessWidget {
  const RatingChipItemView({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Chip(
      clipBehavior: Clip.antiAlias,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$title'),
          SizedBox(
            width: MARGIN_SMALL,
          ),
          Icon(
            Icons.star,
            size: MARGIN_MEDIUM_2,
          ),
        ],
      ),
      shape: StadiumBorder(
        side: BorderSide(width: 0.2),
      ),
    );
  }
}

class TextAndRatingBarView extends StatelessWidget {
  const TextAndRatingBarView({
    Key? key,
    this.title,
    this.value,
  }) : super(key: key);

  final String? title;
  final double? value; // TODO : 0 - 1
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title'),
        const SizedBox(
          width: MARGIN_CARD_MEDIUM,
        ),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.56,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.56 * (value ?? 0),
              height: 10,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RatingViewItem extends StatelessWidget {
  const RatingViewItem({
    Key? key,
    this.title,
    this.value,
  }) : super(key: key);

  final String? title;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        children: [
          Text('$title'),
          SizedBox(
            width: MARGIN_MEDIUM,
          ),
          LinearProgressIndicator(
            value: value,
          ),
        ],
      ),
    );
  }
}
