// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class AddNewCategory extends HomeEvent {
  final String title;
  final AccountsEnum accountsEnum;
  const AddNewCategory(
    this.title,
    this.accountsEnum,
  );
}

class AddNewPayType extends HomeEvent {
  final String title;

  const AddNewPayType(this.title);
}

class ChangeDefaultCategory extends HomeEvent {
  final int index;
  final AccountsEnum accountsEnum;
  const ChangeDefaultCategory(
    this.index,
    this.accountsEnum,
  );
}

class ChangeDefaultPayType extends HomeEvent {
  final int index;

  const ChangeDefaultPayType(this.index);
}

class DeleteAccount extends HomeEvent {
  final Accounts accounts;

  const DeleteAccount(this.accounts);
}
