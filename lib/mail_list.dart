import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gmail_clone/header_delegate.dart';
import 'package:flutter_gmail_clone/list_item.dart';
import 'package:flutter_gmail_clone/mail_drawer.dart';
import 'package:flutter_gmail_clone/mail_model.dart';
import 'package:flutter_gmail_clone/selected_count_notifier.dart';

class MailList extends StatefulWidget {
  final Animation<double> animation;
  final bool floating;
  final bool pinned;
  final Function(bool) animate;

  const MailList({
    Key key,
    @required this.animation,
    @required this.floating,
    @required this.pinned,
    @required this.animate,
  }) : super(key: key);

  @override
  _MailListState createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  final SelectedCountNotifier _selectedCountNotifier = SelectedCountNotifier(0);
  final List<MailModel> _selectedValues = [];
  final List<MailModel> _values = List.generate(26, (index) {
    return MailModel(
        firstLetter: String.fromCharCode(64 + index),
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(1.0));
  });

  @override
  void dispose() {
    _selectedCountNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MailDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: HeaderDelegate(
              animation: widget.animation,
              selectedCountNotifier: _selectedCountNotifier,
              topPadding: MediaQuery.of(context).padding.top,
            ),
            floating: widget.floating,
            pinned: widget.pinned,
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              top: 16.0,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                _sliverChildBuilderDelegateBuilder,
                childCount: _values.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'New email',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _sliverChildBuilderDelegateBuilder(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Text(
          'INBOX',
          style: Theme.of(context).textTheme.body1.copyWith(
            color: Colors.grey[700],
          ),
        ),
      );
    }
    bool isSelected = _selectedValues.contains(_values[index]);
    return Card(
      color: isSelected ? Colors.blue[100] : Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: ListItem(
          selected: isSelected,
          value: _values[index],
          itemSelect: _itemSelect,
        ),
      ),
    );
  }

  void _itemSelect(MailModel value) {
    if (!_selectedValues.remove(value)) {
      _selectedValues.add(value);
    }

    if (_selectedValues.length > 0) {
      _selectedCountNotifier.value = _selectedValues.length;
    }

    setState(() {});

    if (_selectedValues.length > 1) {
      return;
    }

    widget.animate(_selectedValues.isEmpty);
  }
}
