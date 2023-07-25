// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Accounts> accounts;

  const HomeState({this.accounts = const []});

  factory HomeState.initial() {
    return const HomeState();
  }

  double incomesTotal() => accounts.where((element) => element.accountsType == AccountsEnum.income).fold<double>(0, (prev, cur) => prev + cur.sum);
  double expensesTotal() => accounts.where((element) => element.accountsType == AccountsEnum.expense).fold<double>(0, (prev, cur) => prev + cur.sum);
  double allTotal() => accounts.fold<double>(0, (prev, cur) => prev + cur.sum);
  @override
  List<Object> get props => [];

  HomeState copyWith({
    List<Accounts>? accounts,
  }) {
    return HomeState(
      accounts: accounts ?? this.accounts,
    );
  }
}
