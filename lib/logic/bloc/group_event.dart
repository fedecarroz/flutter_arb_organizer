part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class GroupFetch extends GroupEvent {}

class AddGroup extends GroupEvent {}

class RemoveGroup extends GroupEvent {}

