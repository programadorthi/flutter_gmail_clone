import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gmail_clone/mail_model.dart';

class ListItem extends StatefulWidget {
  final bool selected;
  final MailModel value;
  final Function(MailModel) itemSelect;

  const ListItem({
    Key key,
    @required this.selected,
    @required this.value,
    @required this.itemSelect,
  }) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.isAnimating) {
      if (widget.selected && _controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      if (!widget.selected && _controller.status == AnimationStatus.completed) {
        _controller.reverse();
      }
    }
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () => widget.itemSelect(widget.value),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: AnimatedBuilder(
              animation: _controller,
              child: CircleAvatar(
                backgroundColor: widget.value.color,
                child: Text(widget.value.firstLetter),
              ),
              builder: (_, child) {
                return Transform(
                  transform: Matrix4.rotationY(_controller.value * math.pi),
                  alignment: Alignment.center,
                  child: _controller.value < 0.5
                      ? child
                      : CircleAvatar(
                          backgroundColor: Colors.blue[700],
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (_, iconChild) {
                              return Transform(
                                transform: Matrix4.rotationY(_controller.value * -math.pi),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 24.0 * _controller.value,
                                ),
                              );
                            },
                          ),
                        ),
                );
              },
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
