import 'package:flutter/material.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/theme/dimensions.dart';
import 'package:note_app/views/notes_page/widgets/filter_dialog.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppDimentions.pageMargin, vertical: 10.0),
        child: Row(children: [
          Expanded(
            child: Container(
              height: 40.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(6.0)),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/search.png",
                    width: 24.0,
                  ),
                  const SizedBox(width: 10.0),
                  const Expanded(
                      child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        isDense: true,
                        hintText: "Search..."),
                  ))
                ],
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            width: 40.0,
            height: 40.0,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const FilterDialog();
                    });
              },
              child: const Icon(Icons.filter_list),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                elevation: 0.0,
                // fixedSize: const Size(30.0, 40.0)
              ),
            ),
          )
        ]));
  }
}
