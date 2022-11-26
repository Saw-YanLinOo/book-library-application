import 'package:flutter/material.dart';
import 'package:library_app/resourses/dimens.dart';

class UpdateShelfView extends StatelessWidget {
  const UpdateShelfView({
    Key? key,
    this.shelfName,
    required this.onEdit,
    required this.onDelected,
  }) : super(key: key);

  final String? shelfName;
  final Function onEdit;
  final Function onDelected;

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
          child: Text(
            '${shelfName}',
            style: TextStyle(
              fontSize: TEXT_REGULAR_3X,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            onEdit();
          },
          leading: Icon(Icons.edit),
          title: Text(
            'Rename shelf',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            onDelected();
          },
          leading: Icon(Icons.delete),
          title: Text(
            'Delete shelf',
            style: TextStyle(
              fontSize: TEXT_SMALL,
            ),
          ),
        )
      ],
    );
  }
}
