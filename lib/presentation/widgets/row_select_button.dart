import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';

class RowSelectButton extends StatelessWidget {
  final List<String> items;
  final int selected;
  final String title;
  final Function(int) onSelect;

  const RowSelectButton(this.title, this.items, this.selected, this.onSelect,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: Dimen.size50,
          padding: const EdgeInsets.symmetric(
              horizontal: Dimen.size24, vertical: Dimen.size12),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title,
                style: GoogleFonts.roboto(color: Colors.black, fontSize: 20)),
            Padding(
                padding: const EdgeInsets.only(top: Dimen.size4),
                child: PopupMenuButton(
                    onSelected: (element) => onSelect(items.indexOf(element)),
                    itemBuilder: (context) {
                      return items.map((str) {
                        return PopupMenuItem(
                            value: str,
                            child: Text(
                              str,
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ));
                      }).toList();
                    },
                    child: Row(children: [
                      Text(items[selected],
                          style: GoogleFonts.roboto(color: Colors.grey)),
                      const Padding(
                          padding: EdgeInsets.only(
                              left: Dimen.size8, top: Dimen.size2),
                          child: Icon(Icons.arrow_forward_rounded,
                              color: AppColor.primary, size: 18))
                    ])))
          ])),
      const Divider()
    ]);
  }
}
