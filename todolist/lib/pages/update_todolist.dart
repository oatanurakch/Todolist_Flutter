import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:todolist/constant/api.dart';

// การแก้ไขคำที่เหมือนกันให้ Double Click ที่คำที่ต้องการแก้ จากนั้นกด CTRL + D เพื่อเลือกคำที่เหมือนกัน
class UpdatePage extends StatefulWidget {
  final v1, v2, v3;
  // this. เปรียบเสมือน Contructor ใน Python
  const UpdatePage(this.v1, this.v2, this.v3);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var _v1, _v2, _v3;
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1; // id
    _v2 = widget.v2; // title
    _v3 = widget.v3; // detail
    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล'),
        actions: [
          IconButton(
            onPressed: () {
              DeleteTodo();
              // Navigator.pop(context);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
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
                  UpdateTodo();
                },
                child: (Text(
                  "แก้ไขข้อมูล",
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

  // ignore: non_constant_identifier_names
  Future UpdateTodo() async {
    var url = Uri.http('${AllURL['ip']}', '${AllURL['put-todolist']}/$_v1');
    // var url = Uri.http('8b6c-171-101-98-85.ngrok.io', '/api/post-todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title" : "${todo_title.text}", "detail" : "${todo_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('---------------------');
    print(response.body);
  }

  // ignore: non_constant_identifier_names
  Future DeleteTodo() async {
    var url = Uri.http('${AllURL['ip']}', '${AllURL['กำสำะำ-todolist']}/$_v1');
    // var url = Uri.http('8b6c-171-101-98-85.ngrok.io', '/api/post-todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('---------------------');
    print(response.body);
    if(response.statusCode == 200){
      Navigator.pop(context, 'delete');
    }
  }
}
