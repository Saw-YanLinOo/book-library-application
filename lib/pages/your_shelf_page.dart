import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:library_app/pages/create_shelf_page.dart';
import 'package:library_app/resourses/dimens.dart';

class YourShelfPage extends StatelessWidget {
  const YourShelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateShelfPage()));
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
          ),
        ),
      ],
    );
  }
}
