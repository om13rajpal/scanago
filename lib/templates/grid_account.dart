import 'package:flutter/material.dart';
import 'package:scanago/details.dart';
import 'package:scanago/entry_list.dart';
import 'package:scanago/templates/gridcontent_account.dart';
import 'package:scanago/utils/user_data.dart';

class Grid extends StatelessWidget {
  final double screenWidth;
  const Grid({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      shrinkWrap: true,
      childAspectRatio: 8 / 6.3,
      children: [
        GridContent(
          bgColor: const Color(0xffE5C7F0),
          title: 'Home entry',
          subtitle: 'View your home\nentry',
          page: const EntryList(listType: 'listHomeEntry'),
          screenWidth: screenWidth,
        ),
        GridContent(
          bgColor: const Color(0xffBDE9C2),
          title: 'Local entry',
          subtitle: 'View your local\nentry',
          page: const EntryList(listType: 'listLocalEntry'),
          screenWidth: screenWidth,
        ),
        GridContent(
          bgColor: const Color(0xffE6D6AE),
          title: 'User details',
          subtitle: 'Update your user\ndetails',
          page: Details(token: token, saveType: 'update'),
          screenWidth: screenWidth,
        ),
      ],
    );
  }
}
