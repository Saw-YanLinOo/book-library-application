import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:library_app/blocs/add_to_shelf_bloc.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/resourses/dimens.dart';
import 'package:provider/provider.dart';

class AddToShelfPage extends StatelessWidget {
  const AddToShelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddToShelfBloc>(
      create: (context) => AddToShelfBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add to Shelves',
            style: TextStyle(
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w200,
            ),
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
                child: Icon(Icons.clear),
              ),
            )
          ],
        ),
        body: Selector<AddToShelfBloc, List<ShelfVO>?>(
          selector: (context, bloc) => bloc.shelfList,
          builder: (context, shelfs, child) {
            return ListView.builder(
              itemCount: shelfs?.length,
              itemBuilder: (context, index) {
                var shelf = shelfs?[index];
                return ShelfView(
                  shelf: shelf,
                  onShelfCheck: (value) {},
                );
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
    required this.onShelfCheck,
  }) : super(key: key);

  final ShelfVO? shelf;
  final Function(bool?) onShelfCheck;
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
          value: true,
          onChanged: (value) {
            onShelfCheck(value);
          },
        ),
      ],
    );
  }
}
