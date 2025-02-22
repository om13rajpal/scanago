import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Dashboard'),
            floating: true,
            snap: true,
            pinned: false,
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Text('This is my dashboard page'),
            ),
          )
        ],
      ),
    );
  }
}
