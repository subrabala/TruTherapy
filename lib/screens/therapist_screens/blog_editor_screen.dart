import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fleather/fleather.dart';
import 'package:fsui/constants.dart';
import 'package:parchment/parchment.dart';
import 'package:fsui/utils.dart';
import 'package:http/http.dart' as http;

class BlogEditorScreen extends StatefulWidget {
  const BlogEditorScreen({super.key});

  @override
  State<BlogEditorScreen> createState() => _BlogEditorScreenState();
}

class _BlogEditorScreenState extends State<BlogEditorScreen> {
  late FleatherController _controller;
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final doc = ParchmentDocument();
    _controller = FleatherController(document: doc);
  }

  Future<void> _submitBlog() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Title cannot be empty")));
      return;
    }

    final delta = _controller.document.toDelta();
    final contentJson = jsonEncode(delta.toJson());
    final jwt = await getJwt(isTemp: true);


    try {
      final response = await http.post(
        Uri.parse("$backendUrl/blogs/create"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt',
        },
        body: jsonEncode({
          "title": title,
          "description": "Blog description ",
          "content": contentJson,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Blog submitted successfully")));
        _titleController.clear();
        _controller.replaceText(0, _controller.document.length, '');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to submit: ${response.body}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to submit")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Editor"),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _submitBlog,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Enter blog title...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            FleatherToolbar.basic(controller: _controller),
            const SizedBox(height: 8),
            Expanded(
              child: FleatherEditor(
                controller: _controller,
                padding: const EdgeInsets.all(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
