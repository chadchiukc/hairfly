import 'package:flutter/material.dart';

Widget profileCard(String text1, String? text2,
    {bool editable = true, Function()? editCallback}) {
  return Card(
    margin: const EdgeInsets.all(8.0),
    elevation: 5.0,
    child: ListTile(
      minLeadingWidth: 90,
      leading: Text(
        text1,
        style: const TextStyle(fontSize: 16),
      ),
      title: Text(
        text2 ?? '',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      trailing: editable
          ? GestureDetector(
              child: const Icon(Icons.edit),
              onTap: editCallback,
            )
          : const SizedBox.shrink(),
    ),
  );
}
