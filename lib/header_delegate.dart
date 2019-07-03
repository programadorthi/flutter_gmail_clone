import 'package:flutter/material.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Animation<double> animation;
  final double topPadding;
  final ValueNotifier<int> selectedCountNotifier;

  const HeaderDelegate({
    @required this.animation,
    @required this.topPadding,
    @required this.selectedCountNotifier,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, child) {
          return SearchToolbar(
            animationValue: 1.0 - animation.value,
            selectedCountNotifier: selectedCountNotifier,
            topPadding: topPadding,
          );
        },
      ),
    );
  }

  @override
  double get maxExtent => topPadding + kToolbarHeight;

  @override
  double get minExtent => topPadding + kToolbarHeight;

  @override
  bool shouldRebuild(HeaderDelegate oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.animation.value != animation.value;
  }
}

class SearchToolbar extends StatelessWidget {
  final double animationValue;
  final double topPadding;
  final ValueNotifier<int> selectedCountNotifier;

  const SearchToolbar({
    Key key,
    @required this.animationValue,
    @required this.selectedCountNotifier,
    @required this.topPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      elevation: 1.0 + 3.0 * animationValue,
      margin: EdgeInsets.only(
        left: 16.0 * animationValue,
        top: topPadding + (10.0 * animationValue),
        right: 8.0 * animationValue,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0 * animationValue),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 6.0,
        ),
        child: animationValue < 0.9
            ? SelectedItemActions(
                selectedCountNotifier: selectedCountNotifier,
              )
            : NoSelectedItemsActions(),
      ),
    );
  }
}

class NoSelectedItemsActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          color: Colors.grey[700],
          onPressed: () {
            ScaffoldState state = Scaffold.of(context);
            if (state.hasDrawer) {
              state.openDrawer();
            }
          },
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Text(
            'Search mail',
            style: Theme.of(context).textTheme.subhead.copyWith(
                  color: Colors.grey[700],
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: CircleAvatar(),
        ),
      ],
    );
  }
}

class SelectedItemActions extends StatelessWidget {
  final ValueNotifier<int> selectedCountNotifier;

  const SelectedItemActions({
    Key key,
    @required this.selectedCountNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: BackButtonIcon(),
          color: Colors.blue,
          onPressed: () {},
        ),
        SizedBox(
          width: 24.0,
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: selectedCountNotifier,
            builder: (_, value, child) {
              return Text(
                value.toString(),
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.blue,
                    ),
              );
            },
          ),
        ),
        Icon(
          Icons.archive,
          color: Colors.blue,
        ),
        SizedBox(
          width: 24.0,
        ),
        Icon(
          Icons.delete,
          color: Colors.blue,
        ),
        SizedBox(
          width: 24.0,
        ),
        Icon(
          Icons.email,
          color: Colors.blue,
        ),
        SizedBox(
          width: 24.0,
        ),
        Icon(
          Icons.more_vert,
          color: Colors.blue,
        ),
      ],
    );
  }
}
