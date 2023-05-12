import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/Widgets/text_widget.dart';
import 'package:dengue_tracing_application/Global/Widgets/txtfield_Round.dart';
import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/Officer/officer_view.dart';
import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/Sectors/SectorsDropDown.dart';
import 'package:flutter/material.dart';

getOfficerEditDialogue(emailcontr, context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyTextField(
            controller: emailcontr,
            hintText: "Name",
            keytype: TextInputType.text,
            obscureText: false,
            prefixIcon: const Icon(Icons.person),
            //sufixIcon: Icons.remove_red_eye,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyTextField(
            controller: emailcontr,
            hintText: "Email",
            keytype: TextInputType.text,
            obscureText: false,
            prefixIcon: const Icon(Icons.email),
            //sufixIcon: Icons.remove_red_eye,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyTextField(
            controller: emailcontr,
            hintText: "Phone Number",
            keytype: TextInputType.text,
            obscureText: false,
            prefixIcon: const Icon(Icons.call),
            // sufixIcon: Icons.remove_red_eye,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SectorsDrop(),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(14),
                child: const TextWidget(
                    title: " Cancel ", txtSize: 15, txtColor: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OfficersListScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(14),
                child: const TextWidget(
                    title: "  Save  ", txtSize: 15, txtColor: Colors.white),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
