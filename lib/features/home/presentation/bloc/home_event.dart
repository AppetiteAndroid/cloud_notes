part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AddAccountToBack extends HomeEvent {
  final Accounts accounts;

  const AddAccountToBack(this.accounts);
}

class AddAccountToState extends HomeEvent {
  final List<Accounts> accounts;

  const AddAccountToState(this.accounts);
}

class Init extends HomeEvent {}
