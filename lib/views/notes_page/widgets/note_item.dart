import 'package:flutter/material.dart';
import 'package:note_app/theme/colors.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({Key? key, required this.isActionMode}) : super(key: key);
  final bool isActionMode;
  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isActionMode
                ? Container(
                    margin: const EdgeInsets.only(right: 10.0, top: 10.0),
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: const Icon(Icons.check, color: Colors.white),
                  )
                : const SizedBox.shrink(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dividerColor),
                    borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Note Title",
                        style:
                            TextStyle(fontSize: 20.0, color: Color(0xFF2D2D2D)),
                      ),
                      // const
                      SizedBox(height: 6.0),
                      Text(
                        "Jan 20th 2020 03:04 PM",
                        style:
                            TextStyle(fontSize: 10.0, color: Color(0xFF807E7E)),
                      ),
                      // const
                      SizedBox(height: 10.0),
                      Text(
                        "Lorem Ipsum has been the industry's standard text ever "
                        "since the 1500s, when an unknown printer of type "
                        "and scrambled it to also make a type specimen. It has a"
                        "survived not only five centuries, but also in the leap into...",
                        style:
                            TextStyle(fontSize: 14.0, color: Color(0xFF464646)),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
