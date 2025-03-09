import 'package:eduinfo/screens/dashboard/institution/message_details/message_details_controller.dart';
import 'package:eduinfo/widgets/app_body.dart';
import 'package:eduinfo/widgets/app_header_secondary.dart';
import 'package:eduinfo/widgets/loading_container.dart';
import 'package:eduinfo/widgets/message_input_field.dart';
import 'package:eduinfo/widgets/recieved_message_box.dart';
import 'package:eduinfo/widgets/sent_message_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageDetailsScreen extends StatelessWidget {
  const MessageDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
    init: Get.put(MessageDetailsController()),
    builder: (controller) {
      return AppBody(
        floatingActionButtonPadding: EdgeInsets.zero,
        isFloatingButton: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppHeaderSecondary(
              text: controller.messageDetails.person.name,
              backPressed: controller.back,
            ),
            Expanded(
              child: LoadingContainer(
                  startLoading: controller.isLoading,                  
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 25),
                    reverse:  controller.isScrollable,
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.messageDetails.messages.length,
                    itemBuilder: (context, index) {
                      var data;
                      if(controller.isScrollable){
                        data = controller.messageDetails.messages.toList()[index];
                      }else {
                        data = controller.messageDetails.messages.reversed.toList()[index];
                      }
                      return data.isMine
                          ? SentMessageBox(
                              message: data.message,
                              formattedDate: data.formattedDate,
                            )
                          : RecievedMessageBox(
                              message: data.message,
                              formattedDate: data.formattedDate,
                            );
                    },
                  ),
              ),
            ),
           MessageInputField(
            textEditingController: controller.messageController,
            onPressed: controller.sendMessages,
           )

          ],
        ),
      );
    });
  }
}