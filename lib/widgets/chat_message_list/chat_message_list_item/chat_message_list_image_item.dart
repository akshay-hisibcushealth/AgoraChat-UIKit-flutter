
import 'package:agora_chat_uikit/views/photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../agora_chat_uikit.dart';

class ChatMessageListImageItem extends ChatMessageListItem {
  const ChatMessageListImageItem(
      {super.key,
      required super.model,
      super.onTap,
      super.onBubbleLongPress,
      super.onBubbleDoubleTap,
      super.onResendTap,
      super.avatarBuilder,
      super.nicknameBuilder,
      super.bubbleColor,
      super.bubblePadding,
      super.unreadFlagBuilder});

  @override
  Widget build(BuildContext context) {
    return getBubbleWidget(chatCustomImageView(context, model));
  }

  Widget chatCustomImageView(
      BuildContext context, ChatMessageListItemModel model) {
    ChatImageMessageBody body = model.message.body as ChatImageMessageBody;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Align(
        alignment: model.message.direction == MessageDirection.SEND
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: body.remotePath == null
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 48,
                child: const Center(child: CircularProgressIndicator()),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhotoViewScreen(body.remotePath),
                        ),
                      );
                    },
                    child: Hero(
                      tag: "zoom_image",
                      child: CachedNetworkImage(
                        imageUrl: body.remotePath ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: Image.asset("images/default_image.jpg"),
                        ),
                        errorWidget: (c, url, e) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
