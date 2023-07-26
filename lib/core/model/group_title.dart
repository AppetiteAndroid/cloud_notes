// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:cloud_notes/core/model/ui_item.dart';

class GroupTitle extends Equatable implements UiItem {
  final String title;
  final double total;

  const GroupTitle(this.title, this.total);

  @override
  List<Object> get props => [title, total];
}
