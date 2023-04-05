import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms_app/helper/colors.dart';

/*
* uasge
* use map<key,value>
* in example
* List=[
*   {
*     'id' : companyId, @required
*     'value' : companyName, @required
*     'some_key' : some extra values as per need ...
*   },
* ]
*
*
* */
class Spinner extends StatelessWidget {
  final String? value;
  final List<Map<String, String>> items;
  final Function(String?)? onChanged;
  final String? hint;
  final double? width;
  final double? fontSize;
  final bool showHint;

  Spinner(
    this.value,
    this.items, {
    required this.onChanged,
    this.hint,
    this.width,
    this.fontSize,
    this.showHint = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: stroke, blurRadius: 0.5)]),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text(
            hint ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          value: value,
          items: buildDropdownItem(
            items,
            fontSize: fontSize,
          ),
          onChanged: (val) {
            if (showHint) {
              if (val.toString() != '-1') {
                onChanged!('$val');
              }
            } else {
              onChanged!('$val');
            }
          },
          onTap: () => Get.focusScope?.unfocus(),
          isExpanded: true,
          style: TextStyle(
            fontSize: fontSize ?? 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  buildDropdownItem(
    List<Map<String, String>> items, {
    double? fontSize,
  }) {
    return items
        .map((e) => DropdownMenuItem<String>(
              value: e['id'],
              child: Text(
                '${e['value']}',
              ),
            ))
        .toList();
  }
}

Map<String, String> getMapItem(
    List<Map<String, String>> items, String selected) {
  return items.firstWhere((element) => element['id'] == selected,
      orElse: () => {});
}
