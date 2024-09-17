import 'package:flutter/material.dart';

import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/add_project/add_project_screen.dart';
import 'package:project7/widgets/cards/user_project_card.dart';

class UserProjectScreen extends StatelessWidget {
  const UserProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // bool allowEditing = true;
    // String _selectedDate = '';
    // String _dateCount = '';
    // String _range = '';
    // String _rangeCount = '';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: context.getWidth(),
              height: 190,
              decoration: const BoxDecoration(
                  color: AppConstants.mainPurple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  const SizedBox(height: 38),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "My Projects",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: "Lato"),
                        ),
                        IconButton(
                          onPressed: () =>
                              context.push(screen: const AddProjectScreen()),
                          icon: const Icon(
                            Icons.add_box,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: context.getWidth(divideBy: 1.2),
                    height: 30,
                    child: TextFormField(
                      // controller: cubit.searchController,
                      // onChanged: (value) => cubit.handleSearch(value),
                      cursorHeight: 17,
                      style: const TextStyle(fontSize: 13),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search for a project ....",
                        hintStyle:
                            TextStyle(color: Colors.black45, fontSize: 13),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppConstants.mainPurple, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "bootcamp",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  UserProjectCard(
                    name: "Shopping App",
                    catgaory: "Flutter",
                    type: "App",
                    rate: "5.0",
                    date: "9-10-2024",
                    state: "Active",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
