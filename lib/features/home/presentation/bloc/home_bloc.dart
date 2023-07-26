import 'package:bloc/bloc.dart';
import 'package:cloud_notes/core/constants.dart';
import 'package:cloud_notes/core/model/accounts_category_model.dart';
import 'package:cloud_notes/core/model/accounts_enum.dart';
import 'package:cloud_notes/core/model/accounts_model.dart';
import 'package:cloud_notes/core/model/group_title.dart';
import 'package:cloud_notes/core/model/ui_item.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late Box<Accounts> accountsBox;
  late Box<AccountsCategoryModel> payTypesBox;
  late Box<AccountsCategoryModel> categoriesExpensesBox;
  late Box<AccountsCategoryModel> categoriesIncomesBox;

  HomeBloc() : super(HomeState.initial()) {
    on<AddAccountToBack>(_addAccountToBack);
    on<Init>(_init);
    on<AddAccountToState>(_addAccountToState);
    on<AddNewCategory>(_addNewCategory);
    on<AddNewPayType>(_addNewPayType);
    on<ChangeDefaultCategory>(_changeDefaultCategory);
    on<ChangeDefaultPayType>(_changeDefaultPayType);
  }

  @override
  Future<void> close() async {
    accountsBox.listenable().removeListener(_accountsBoxListener);
    accountsBox.close();
    payTypesBox.close();
    categoriesExpensesBox.clear();
    return super.close();
  }

  //* AddAccount
  Future<void> _addAccountToBack(AddAccountToBack event, Emitter<HomeState> emit) async {
    accountsBox.add(event.accounts);
    //emit(state.copyWith(accounts: List.from(state.accounts)..insert(0, event.accounts)));
  }

  //* Init
  Future<void> _init(Init event, Emitter<HomeState> emit) async {
    accountsBox = Hive.box<Accounts>(Constants.accounts);
    payTypesBox = Hive.box<AccountsCategoryModel>(Constants.paymentTypes);
    categoriesExpensesBox = Hive.box<AccountsCategoryModel>(Constants.categoriesExpenses);
    categoriesIncomesBox = Hive.box<AccountsCategoryModel>(Constants.categoriesIncomes);
    accountsBox.listenable().addListener(_accountsBoxListener);
    _accountsBoxListener();
  }

  void _accountsBoxListener() {
    add(AddAccountToState(accountsBox.values.toList().reversed.toList()));
  }

  //* AddAccountToState
  Future<void> _addAccountToState(AddAccountToState event, Emitter<HomeState> emit) async {
    emit(state.copyWith(accounts: event.accounts));
  }

  //* AddNewCategory
  Future<void> _addNewCategory(AddNewCategory event, Emitter<HomeState> emit) async {
    switch (event.accountsEnum) {
      case AccountsEnum.income:
        categoriesIncomesBox.add(AccountsCategoryModel(title: event.title, isDefault: categoriesIncomesBox.isEmpty));
        break;
      case AccountsEnum.expense:
        categoriesExpensesBox.add(AccountsCategoryModel(title: event.title, isDefault: categoriesExpensesBox.isEmpty));
        break;
    }
  }

  //* AddNewPayType
  Future<void> _addNewPayType(AddNewPayType event, Emitter<HomeState> emit) async {
    payTypesBox.add(AccountsCategoryModel(title: event.title, isDefault: payTypesBox.isEmpty));
  }

  //* ChangeDefaultCategory
  Future<void> _changeDefaultCategory(ChangeDefaultCategory event, Emitter<HomeState> emit) async {
    switch (event.accountsEnum) {
      case AccountsEnum.income:
        categoriesIncomesBox.values.forEachIndexed((index, element) {
          categoriesIncomesBox.putAt(index, element.copyWith(isDefault: index == event.index));
        });
        break;
      case AccountsEnum.expense:
        categoriesExpensesBox.values.forEachIndexed((index, element) {
          categoriesExpensesBox.putAt(index, element.copyWith(isDefault: index == event.index));
        });
        break;
    }
  }

  //* ChangeDefaultPayType
  Future<void> _changeDefaultPayType(ChangeDefaultPayType event, Emitter<HomeState> emit) async {
    payTypesBox.values.forEachIndexed((index, element) {
      payTypesBox.putAt(index, element.copyWith(isDefault: index == event.index));
    });
  }
}
