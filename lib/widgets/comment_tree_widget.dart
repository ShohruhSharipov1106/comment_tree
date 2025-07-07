import 'package:flutter/material.dart';
import './comment_child_widget.dart';
import './root_comment_widget.dart';
import './tree_theme_data.dart';
import 'package:provider/provider.dart';

typedef AvatarWidgetBuilder<T> = PreferredSize Function(
  BuildContext context,
  T value,
);
typedef ContentBuilder<T> = Widget Function(BuildContext context, T value);

class CommentTreeWidget extends StatefulWidget {
  final List<Widget> replies;
  final Size avatarRoot;
  final AvatarWidgetBuilder avatarChild;
  final TreeThemeData treeThemeData;

  const CommentTreeWidget({
    required this.replies,
    this.treeThemeData = const TreeThemeData(lineWidth: 1),
    required this.avatarRoot,
    required this.avatarChild,
  });

  @override
  _CommentTreeWidgetState createState() => _CommentTreeWidgetState();
}

class _CommentTreeWidgetState extends State<CommentTreeWidget> {
  @override
  Widget build(BuildContext context) {
    return Provider<TreeThemeData>.value(
      value: widget.treeThemeData,
      child: Column(
        children: [
          // RootCommentWidget(widget.rootWidget),
          ...widget.replies.map(
            (e) => CommentChildWidget(
              isLast: widget.replies.indexOf(e) == (widget.replies.length - 1),
              avatar: widget.avatarChild(context, e),
              avatarRoot: widget.avatarRoot,
              content: e,
            ),
          )
        ],
      ),
    );
  }
}
