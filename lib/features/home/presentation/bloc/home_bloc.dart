import 'package:bloc/bloc.dart';
import 'package:cloud_notes/core/model/accounts_category_model.dart';
import 'package:cloud_notes/core/model/accounts_enum.dart';
import 'package:cloud_notes/core/model/accounts_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late Box<Accounts> accountsBox;
  late Box<AccountsCategoryModel> payTypesBox;
  late Box<AccountsCategoryModel> categoriesBox;

  HomeBloc() : super(HomeState.initial()) {
    on<AddAccountToBack>(_addAccountToBack);
    on<Init>(_init);
    on<AddAccountToState>(_addAccountToState);
  }

  //* AddAccount
  Future<void> _addAccountToBack(AddAccountToBack event, Emitter<HomeState> emit) async {
    accountsBox.add(event.accounts);
  }

  //* Init
  Future<void> _init(Init event, Emitter<HomeState> emit) async {
    accountsBox = await Hive.openBox<Accounts>('accounts');
    payTypesBox = await Hive.openBox<AccountsCategoryModel>('payment_types');
    categoriesBox = await Hive.openBox<AccountsCategoryModel>('categories');

    payTypesBox.put(0, const AccountsCategoryModel(id: 0, title: "Cash"));
    payTypesBox.put(1, const AccountsCategoryModel(id: 1, title: "Card"));
    payTypesBox.put(2, const AccountsCategoryModel(id: 2, title: "Kaspi gold"));
    payTypesBox.put(3, const AccountsCategoryModel(id: 3, title: "Simply"));
    categoriesBox.put(0, const AccountsCategoryModel(id: 0, title: "Onay"));
    categoriesBox.put(1, const AccountsCategoryModel(id: 1, title: "Anau mnau"));
    categoriesBox.put(2, const AccountsCategoryModel(id: 2, title: "Cofe"));
    categoriesBox.put(3, const AccountsCategoryModel(id: 3, title: "Food"));
    _accountsBoxListener();
    accountsBox.listenable().addListener(_accountsBoxListener);
  }

  void _accountsBoxListener() {
    add(AddAccountToState(accountsBox.values.toList()));
  }

  //* AddAccountToState
  Future<void> _addAccountToState(AddAccountToState event, Emitter<HomeState> emit) async {
    emit(state.copyWith(accounts: event.accounts));
  }
}
