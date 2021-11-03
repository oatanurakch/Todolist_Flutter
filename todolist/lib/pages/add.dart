import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:todolist/constant/api.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // ประกาศตัวแปรไว้รอเก็บข้อมูล
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการใหม่ให้กับ Database'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // ช่องกรอก Title ของ To-dolist
            TextField(
              minLines: 4,
              maxLines: 8,
              controller: todo_title,
              decoration: InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              minLines: 4,
              maxLines: 8,
              controller: todo_detail,
              decoration: InputDecoration(
                  labelText: 'Detail', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 10),
              child: ElevatedButton(
                onPressed: () {
                  //onPressed is click button
                  print('--------------------');
                  print('title: ${todo_title.text}');
                  print('detail: ${todo_detail.text}');
                  postTodo();
                  // หลังจาก POST เสร็จแล้วให้ทำการ Clear ข้อมูลโดยการใช้ setState()
                  setState(() {
                    todo_title.clear();
                    todo_detail.clear();
                  });
                },
                child: (Text(
                  "เพิ่มรายการ",
                  style: TextStyle(fontSize: 20),
                )),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue[700]),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(50, 20, 50, 20)),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    // var url = Uri.http('192.168.0.6:8000', '/api/post-todolist');
    var url = Uri.http('${AllURL['ip']}', '${AllURL['post-todolist']}');
    Map<String, String> header = {"Content-type" : "application/json"};
    String jsondata = '{"title" : "${todo_title.text}", "detail" : "${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('---------------------');
    print(response.body);
  }
}