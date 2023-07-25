import 'package:cloud_notes/features/home/presentation/widgets/incomes_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "Incomes",
                ),
                Tab(
                  text: "Expenses",
                ),
              ],
            ),
            body: TabBarView(
              children: [
                Container(
                  color: Colors.amber,
                  height: 100,
                  width: 100,
                ),
                const IncomesPage(),
                Container(
                  color: Colors.amber,
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
