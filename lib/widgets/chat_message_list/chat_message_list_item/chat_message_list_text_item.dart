import 'package:flutter/material.dart';

import '../../../agora_chat_uikit.dart';

class ChatMessageListTextItem extends ChatMessageListItem {
  final TextStyle? contentStyle;

  const ChatMessageListTextItem({
    super.key,
    required super.model,
    this.contentStyle,
    super.onTap,
    super.onBubbleLongPress,
    super.onBubbleDoubleTap,
    super.onResendTap,
    super.avatarBuilder,
    super.nicknameBuilder,
    super.bubbleColor,
    super.bubblePadding,
    super.unreadFlagBuilder,
  });

  @override
  Widget build(BuildContext context) {
    ChatMessage message = model.message;
    bool isLeft = message.direction == MessageDirection.RECEIVE;
    ChatTextMessageBody body = message.body as ChatTextMessageBody;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          body.content,
          style: contentStyle ??
              (isLeft
                  ? ChatUIKit.of(context)?.theme.receiveTextStyle ??
                      const TextStyle(color: Colors.black)
                  : ChatUIKit.of(context)?.theme.sendTextStyle) ??
              const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          TimeTool.timeStrByMs(message.serverTime),
          style: ChatUIKit.of(context)?.theme.messagesListItemTsStyle ??
              const TextStyle(color: Colors.grey, fontSize: 14),
        )
      ],
    );

    return getBubbleWidget(content);
  }
}
