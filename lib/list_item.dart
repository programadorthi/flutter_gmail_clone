import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gmail_clone/mail_model.dart';

class ListItem extends StatelessWidget {
  final MailModel value;
  final Function(MailModel) itemSelect;

  const ListItem({
    Key key,
    @required this.value,
    @required this.itemSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () => itemSelect(value),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: CircleAvatar(
              backgroundColor: value.color,
              child: Text(value.firstLetter),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Icon(
                      Icons.label_important,
                      color: Colors.orange,
                      size: 18.0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'A big email title to show the ellipses in the end of the tile',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subhead.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Transform.rotate(
                      angle: math.pi / 2,
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.grey,
                        size: 18.0,
                      ),
                    ),
                  ),
                  Text(
                    'Time',
                    style: Theme.of(context).textTheme.body1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'A big email subtitle to show the ellipses in the end of the subtile',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.body2.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'A big email text preview to show the ellipses in the end of the text preview',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5.0,
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    child: Icon(
                      Icons.star_border,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
