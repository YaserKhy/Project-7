import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/screens/view_project/cubit/drop_down_cubit.dart';

class DropDowan extends StatelessWidget {
  const DropDowan({super.key});

  // Method to get different icons based on the selected value
  Icon _getIconForValue(String value) {
    switch (value) {
      case 'State':
        return const Icon(HugeIcons.strokeRoundedAlertSquare,
            color: AppConstants.iconsGrayColor); // Custom icon
      case 'Privata':
        return const Icon(HugeIcons.strokeRoundedSquareLock02,
            color: AppConstants.red); // Custom icon
      case 'Public':
        return const Icon(HugeIcons.strokeRoundedSquareUnlock02,
            color: AppConstants.green); // Custom icon
      default:
        return const Icon(Icons.star); // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: BlocBuilder<DropdownCubit, String>(
          builder: (context, selectedItem) {
            return DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              value: selectedItem,
              onChanged: (String? value) {
                if (value != null) {
                  context.read<DropdownCubit>().selectItem(value);
                }
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppConstants
                        .iconsGrayColor, // Border color when not focused
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppConstants
                        .iconsGrayColor, // Border color when focused
                    width: 1,
                  ),
                ),
              ),
              items: [
                'State',
                'Privata',
                'Public',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      _getIconForValue(value), // Custom icon for each item
                      const SizedBox(width: 10),
                      Text(
                        value,
                        style: TextStyle(
                          color: value == selectedItem
                              ? Colors.black
                              : AppConstants
                                  .textGrayColor, // Custom text color for selected item
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
