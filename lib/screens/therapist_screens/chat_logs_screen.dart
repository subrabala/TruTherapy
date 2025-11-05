import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/utils.dart';
import 'package:fsui/controllers/therapist/emergency_chat_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TherapistChatLogsScreen extends StatelessWidget {
  final EmergencyChatController controller = Get.put(EmergencyChatController());

  TherapistChatLogsScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkTherapistJwtAndRedirectIfExpired();
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sea Dost",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: PastelColors.skyBlueDark,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric( vertical:  16.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.chatLogsForSession.length,
                    itemBuilder: (context, index) {
                      final message = controller.chatLogsForSession[index];
          
                      final query = message['query'];
                      final response = message['response'];
                      bool isUser = query != null;
          
                      return Column(
                        crossAxisAlignment: isUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          // Query
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
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isUser ? Colors.blue[100] : Colors.green[100],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: MarkdownBody(
                                data: query ?? "",
                                styleSheet: MarkdownStyleSheet(
                                  p: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          // Response message
                          if (response != null)
                            Align(
                              alignment: !isUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 8.0,
                                ),
                                padding: const EdgeInsets.all(12.0),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.8,
                                ),
                                decoration: BoxDecoration(
                                  color: !isUser
                                      ? Colors.blue[100]
                                      : Colors.green[100],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: MarkdownBody(
                                  data: response ?? "",
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
            ],
          ),
        ),
      ),
    );
  }
}
