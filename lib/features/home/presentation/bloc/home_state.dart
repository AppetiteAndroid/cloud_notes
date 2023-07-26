// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum Filter { all, byCategory, byPayType }

class HomeState extends Equatable {
  final List<Accounts> accounts;
  const HomeState({this.accounts = const []});

  factory HomeState.initial() {
    return const HomeState();
  }

  List<UiItem> getElements({AccountsEnum? accountsEnum, Filter filter = Filter.all}) {
    switch (accountsEnum) {
      case null:
        return _filterList(accounts, filter);
      case AccountsEnum.expense:
        return _filterList(accounts.where((element) => element.accountsType == AccountsEnum.expense).toList(), filter);
      case AccountsEnum.income:
        return _filterList(accounts.where((element) => element.accountsType == AccountsEnum.income).toList(), filter);
    }
  }

  double getTotal({AccountsEnum? accountsEnum}) {
    switch (accountsEnum) {
      case AccountsEnum.income:
        return accounts.where((element) => element.accountsType == AccountsEnum.income).fold<double>(0, (prev, cur) => prev + cur.sum);
      case AccountsEnum.expense:
        return accounts.where((element) => element.accountsType == AccountsEnum.expense).fold<double>(0, (prev, cur) => prev + cur.sum);
      case null:
        return accounts.fold<double>(0, (prev, cur) => prev + (cur.accountsType == AccountsEnum.income ? cur.sum : -cur.sum));
    }
  }

  List<UiItem> _filterList(List<Accounts> list, Filter filter) {
    final List<UiItem> groupedList = [];
    Map<String?, List<Accounts>> groupedMap = {};
    switch (filter) {
      case Filter.all:
        return list;
      case Filter.byCategory:
        groupedMap = groupBy(list, (p0) => p0.category?.title);
        break;
      case Filter.byPayType:
        groupedMap = groupBy(list, (p0) => p0.payType?.title);
        break;
    }
    groupedMap.forEach((key, value) {
      groupedList.add(GroupTitle(key ?? "", value.fold(0, (previousValue, element) => previousValue + (element.accountsType == AccountsEnum.expense ? -element.sum : element.sum))));
      groupedList.addAll(value);
    });
    return groupedList;
  }

  @override
  List<Object> get props => [accounts];

  HomeState copyWith({
    List<Accounts>? accounts,
  }) {
    return HomeState(
      accounts: accounts ?? this.accounts,
    );
  }
}
