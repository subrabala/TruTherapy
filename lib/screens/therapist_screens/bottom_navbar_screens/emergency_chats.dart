import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/therapist/emergency_chat_controller.dart';
import 'package:fsui/screens/aibot_screen.dart';
import 'package:fsui/screens/therapist_screens/chat_logs_screen.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class EmergencyChats extends StatelessWidget {
  final EmergencyChatController controller = Get.put(EmergencyChatController());

  final RxString selectedTab = 'pending'.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Chat History',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue.shade900),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tabs(selectedTab: selectedTab),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.fetchChats();
                  },
                  child: Obx(() {
                    List<Map<String, dynamic>> filteredChats = controller
                        .chatMessages
                        .where(
                            (chat) => chat['alert_status'] == selectedTab.value)
                        .toList();

                    return ListView.builder(
                      itemCount: filteredChats.length,
                      itemBuilder: (context, index) {
                        final chat = filteredChats[index];
                        return GestureDetector(
                          onTap: () async {
                            // if (selectedTab.value == 'pending') {
                            //   return;
                            // } else {
                              await controller
                                  .getChatsForSession(chat['session_id']);
                              Get.to(() => TherapistChatLogsScreen());
                          //   }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            padding: const EdgeInsets.only(
                                left: 16, right: 8, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              color: PastelColors.pastelPink.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // Display Name and Phone Number
                                    Row(
                                      children: [
                                        Text(
                                          chat['name'] + '    |    ',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 240, 251, 254),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            chat['phone_number'].substring(5) ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    // Display the response
                                    Text(
                                      chat['alert_reason'].length > 30
                                          ? '${chat['alert_reason'].substring(0, 30)}...'
                                          : chat['alert_reason'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.mail_outline_rounded,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          chat['email'],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    // Display the triggered_at time
                                    Text(
                                      convertToReadableDateAndTime(
                                          chat['triggered_at']),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                // Accept Button

                                if (selectedTab.value == 'pending')
                                  OutlinedButton.icon(
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                      ),
                                      minimumSize:
                                          WidgetStateProperty.all(Size.zero),
                                      backgroundColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      side: WidgetStateProperty.all(
                                          const BorderSide(
                                        color: Colors.green,
                                        width: 1,
                                      )),
                                    ),
                                    onPressed: () {
                                      controller
                                          .acceptSession(chat['session_id']);
                                    },
                                    icon: const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                    label: const Text(
                                      'Accept',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                        height: 1,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                if (selectedTab.value != 'pending')
                                  PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 'resolved') {
                                        controller.updateSessionStatus(
                                            chat['session_id'], 'resolved');
                                      } else if (value == 'pending') {
                                        controller.updateSessionStatus(
                                            chat['session_id'], 'pending');
                                      } else if (value == 'session_scheduled') {
                                        controller.updateSessionStatus(
                                            chat['session_id'],
                                            'session_scheduled');
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        const PopupMenuItem(
                                          value: 'resolved',
                                          child: Text('Mark as resolved'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'pending',
                                          child: Text('Pending'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'session_scheduled',
                                          child: Text('Session Scheduled'),
                                        ),
                                      ];
                                    },
                                    child: const Icon(
                                      Icons.more_vert,
                                      color: Colors.black54,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  const Tabs({
    super.key,
    required this.selectedTab,
  });

  final RxString selectedTab;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Obx(() {
          return Row(
            children: [
              // Pending Tab
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedTab.value = 'pending';
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: selectedTab.value == 'pending'
                                ? PastelColors.skyBlueDark
                                : Colors.transparent,
                            width: 2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Pending',
                        style: TextStyle(
                          color: selectedTab.value == 'pending'
                              ? PastelColors.skyBlueDark
                              : Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Scheduled Tab
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedTab.value = 'session_scheduled';
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: selectedTab.value == 'session_scheduled'
                                ? PastelColors.skyBlueDark
                                : Colors.transparent,
                            width: 2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'In Progress',
                        style: TextStyle(
                          color: selectedTab.value == 'session_scheduled'
                              ? PastelColors.skyBlueDark
                              : Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Completed Tab
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedTab.value = 'resolved';
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: selectedTab.value == 'resolved'
                                ? PastelColors.skyBlueDark
                                : Colors.transparent,
                            width: 2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Resolved',
                        style: TextStyle(
                          color: selectedTab.value == 'resolved'
                              ? PastelColors.skyBlueDark
                              : Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
