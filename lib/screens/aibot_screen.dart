import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/aibot_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class AIBotScreen extends StatelessWidget {
  final AIBotController controller = Get.put(AIBotController());
  final TextEditingController queryController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final String? firstQuery;

  AIBotScreen({Key? key, this.firstQuery}) : super(key: key);

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (firstQuery != null && firstQuery!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        queryController.text = firstQuery!;
      });
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Aqua Bot",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.mid,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                final List<Map<String, String>> preprocessedChats = [];

                for (var log in controller.chatLogsForSession) {
                  if (log.containsKey('query') && log.containsKey('response')) {
                    preprocessedChats.add({'user': log['query'] ?? ''});
                    preprocessedChats.add({'bot': log['response'] ?? ''});
                  }
                }

                final combinedChats = [
                  ...preprocessedChats,
                  ...controller.chatHistory
                ];

                if (combinedChats.isEmpty) {
                  return const Center(
                    child: Text(
                      "No chats available. Start a conversation!",
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  );
                }

                // Scroll after the ListView is updated
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  scrollToBottom();
                });

                return ListView.builder(
                  controller: scrollController,
                  itemCount: combinedChats.length,
                  itemBuilder: (context, index) {
                    final message = combinedChats[index];
                    final isUser = message.containsKey('user');
                    final text = isUser ? message['user'] : message['bot'];

                    return Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8.0,
                            ),
                            padding: const EdgeInsets.all(12.0),
                            constraints:
                                const BoxConstraints(maxWidth: 0.8 * 1000),
                            decoration: BoxDecoration(
                              color:
                                  isUser ? Colors.blue[100] : Colors.green[100],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: MarkdownBody(
                              data: text ?? "",
                              styleSheet: MarkdownStyleSheet(
                                p: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: queryController,
                      decoration: InputDecoration(
                        hintText: "Enter your message...",
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          borderSide:
                              const BorderSide(color: PastelColors.skyBlueDark),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: PastelColors.skyBlueDark,
                    ),
                    onPressed: () {
                      final query = queryController.text.trim();
                      if (query.isNotEmpty) {
                        controller.handleQuery(query);
                        queryController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
