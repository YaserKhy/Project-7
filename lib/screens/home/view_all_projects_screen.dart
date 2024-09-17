import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/view_project/project_screen.dart';

class ViewAllProjectsScreen extends StatelessWidget {
  const ViewAllProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 100,
                ),
                const Text(
                  "All Flutter Projects",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Lato",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
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
                      hintStyle: TextStyle(color: Colors.black45, fontSize: 13),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppConstants.mainPurple, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
                const Icon(Icons.qr_code, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
