import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:library_app/resourses/dimens.dart';

class CreateShelfPage extends StatefulWidget {
  const CreateShelfPage({Key? key}) : super(key: key);

  @override
  State<CreateShelfPage> createState() => _CreateShelfPageState();
}

class _CreateShelfPageState extends State<CreateShelfPage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Create Shelf',
          style: TextStyle(
            fontSize: TEXT_REGULAR,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MARGIN_XXXL_LARGE,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Shelf name",
                hintStyle: TextStyle(
                  fontSize: TEXT_HEADING_1X,
                ),
              ),
              onSubmitted: (value) {},
            ),
          ),
          SizedBox(
            height: MARGIN_LARGE,
          ),
          Divider(),
        ],
      ),
    );
  }
}
