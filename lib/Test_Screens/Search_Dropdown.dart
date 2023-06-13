import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:select2dot1/select2dot1.dart';
import 'package:provider/provider.dart';

import 'DropDownController.dart';

class CustomSelect2dot1 extends StatelessWidget {
  final String title;
  bool isReortedby;
  final List<SingleCategoryModel> data;
  final bool isMultiSelect;
  final bool avatarInSingleSelect;
  final bool extraInfoInSingleSelect;
  final bool extraInfoInDropdown;
  final ScrollController? scrollController;

  CustomSelect2dot1({
    super.key,
    required this.isReortedby,
    required this.title,
    required this.data,
    required this.isMultiSelect,
    required this.avatarInSingleSelect,
    required this.extraInfoInSingleSelect,
    required this.extraInfoInDropdown,
    required this.scrollController,
  });
  @override
  Widget build(BuildContext context) {
    DropDownController dropDownController = context.read<DropDownController>();
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300,
      ),
      child: Select2dot1(
        selectChipSettings: SelectChipSettings(
          iconColor: context.primaryColor,
          dividerColor: context.dividerColor,
        ),
        onChanged: (value) {
          if (isReortedby) {
            dropDownController.isReportedbyId = value.single;
          } else {
            dropDownController.selectedStudentId = value.single;
          }
          dropDownController.notifyListeners();
        },
        selectDataController:
            SelectDataController(data: data, isMultiSelect: isMultiSelect),
        pillboxTitleSettings: PillboxTitleSettings(
          title: title,
          titlePadding: EdgeInsets.zero,
          titleStyleDefault: const TextStyle(
            color: Color(0xFF99A5C1),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          titleStyleHover: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          titleStyleFocus: TextStyle(
            color: context.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        pillboxSettings: PillboxSettings(
          padding: null,
          defaultDecoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: context.primaryColor),
            ),
          ),
          activeDecoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: context.dividerColor,
              ),
            ),
          ),
          hoverDecoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          focusDecoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFF1DEDB2)),
            ),
          ),
        ),
        pillboxIconSettings: PillboxIconSettings(
          padding: null,
          defaultColor: const Color(0xFF99A5C1),
          hoverColor: Colors.black,
          focusColor: context.primaryColor,
        ),
        selectEmptyInfoSettings: const SelectEmptyInfoSettings(
          padding: EdgeInsets.zero,
          text: 'Select',
          textStyle: TextStyle(
            color: Color(0xFF6B7893),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        pillboxContentMultiSettings: const PillboxContentMultiSettings(
          pillboxLayout: PillboxLayout.scroll,
        ),
        selectChipBuilder: (context, selectChipDetails) {
          return Container(
            height: 29,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            constraints: const BoxConstraints(maxWidth: 200),
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: Text(
                    selectChipDetails.singleItemCategory.nameSingleItem,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0, left: 2.0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        if (isReortedby)
                          dropDownController.isReportedbyId = null;
                        else {
                          dropDownController.selectedStudentId = null;
                        }
                        dropDownController.notifyListeners();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 14,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        dropdownOverlaySettings: DropdownOverlaySettings(
          maxHeight: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: context.dividerColor,
            border: const Border(),
            boxShadow: const [],
          ),
          animationBuilder: (context, child, animationController) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SizeTransition(
                sizeFactor: CurvedAnimation(
                  parent: animationController,
                  curve: Curves.easeInOutQuart,
                ),
                child: child,
              ),
            );
          },
        ),
        searchBarOverlayBuilder: (context, searchBarOverlayDetails) {
          return Container(
            height: 48,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(top: 9, left: 5, right: 5, bottom: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 149, 176, 215),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: searchBarOverlayDetails.searchBarController,
                    focusNode: searchBarOverlayDetails.searchBarFocusNode,
                    cursorColor: const Color(0xFF1DEDB2),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        searchEmptyInfoOverlaySettings: const SearchEmptyInfoOverlaySettings(
          textStyle: TextStyle(color: Colors.black),
        ),
        listDataViewOverlaySettings:
            const ListDataViewOverlaySettings(thumbColor: Color(0xFF1DEDB2)),
        categoryNameOverlaySettings: CategoryNameOverlaySettings(
          constraints: const BoxConstraints(minHeight: 27),
          textStyle: const TextStyle(
            color: Color(0xFF6B7893),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          defaultDecoration: const BoxDecoration(color: Colors.red),
          hoverDecoration:
              BoxDecoration(color: const Color(0xFF00183D).withOpacity(0.5)),
        ),
        categoryItemOverlaySettings: CategoryItemOverlaySettings(
          constraints: const BoxConstraints(minHeight: 35),
          defaultTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          selectedTextStyle: const TextStyle(
            color: Color(0xFF1DEDB2),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          iconSize: 14,
          iconSelectedColor: const Color(0xFF1DEDB2),
          defaultDecoration: const BoxDecoration(color: Colors.transparent),
          hoverDecoration:
              BoxDecoration(color: const Color(0xFF00183D).withOpacity(0.5)),
          showExtraInfo: extraInfoInDropdown,
        ),
        searchBarModalBuilder: (context, searchBarModalDetails) {
          return Container(
            height: 48,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(top: 9, bottom: 2),
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: searchBarModalDetails.searchBarModalController,
                    focusNode: searchBarModalDetails.searchBarModalFocusNode,
                    cursorColor: const Color(0xFF1DEDB2),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Color(0xFF202E50)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        searchEmptyInfoModalSettings: const SearchEmptyInfoModalSettings(
          textStyle: TextStyle(color: Colors.black),
        ),
        dropdownModalSettings: DropdownModalSettings(
          backgroundColor: context.scaffoldBackgroundColor,
        ),
        categoryNameModalSettings: const CategoryNameModalSettings(
          textStyle: TextStyle(
            color: Color(0xFF6B7893),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        categoryItemModalSettings: CategoryItemModalSettings(
          defaultTextStyle: TextStyle(
            color: context.iconColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          selectedTextStyle: TextStyle(
            color: context.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          // ignore: avoid_redundant_argument_values
          iconSize: 18,
          iconSelectedColor: context.primaryColor,
          showExtraInfo: extraInfoInDropdown,
        ),
        titleModalSettings: TitleModalSettings(
          title: title,
          titleTextStyle: TextStyle(
            color: context.iconColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        doneButtonModalSettings: DoneButtonModalSettings(
          buttonDecoration: BoxDecoration(
            border: Border.all(color: context.primaryColor),
            color: context.cardColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: TextStyle(
            color: context.iconColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        selectOverloadInfoSettings: const SelectOverloadInfoSettings(
          textStyle: TextStyle(color: Colors.black),
          padding: null,
        ),
        selectSingleSettings: SelectSingleSettings(
          padding: null,
          textStyle: const TextStyle(color: Colors.black),
          showExtraInfo: extraInfoInSingleSelect,
          showAvatar: avatarInSingleSelect,
        ),
        scrollController: scrollController,
      ),
    );
  }
}
