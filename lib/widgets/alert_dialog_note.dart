import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Future<void> AlertDialogNote({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onPressed,
  required TextEditingController titleController,
  required TextEditingController contentController,

}) async {
  return showDialog<void>(
    
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // <-- SEE HERE
        title: Text(title,
            style: const TextStyle(color: Colors.blue),
            textAlign: TextAlign.center),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.95,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Tiêu đề',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: contentController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Nội dung',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey, width: 1, style: BorderStyle.solid),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: const Text(
                  'Hủy',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text(
                  'Lưu',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  onPressed.call();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
