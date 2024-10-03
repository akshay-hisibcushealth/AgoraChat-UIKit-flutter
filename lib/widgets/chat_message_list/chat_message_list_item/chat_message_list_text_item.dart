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

    Widget content = EmojiText(
      text: body.content,
      textStyle: contentStyle ??
          (isLeft
              ? ChatUIKit.of(context)?.theme.receiveTextStyle ??
                  const TextStyle(color: Colors.black)
              : ChatUIKit.of(context)?.theme.sendTextStyle) ??
          const TextStyle(color: Colors.white),
    );

    return getBubbleWidget(content);
  }
}

class EmojiText extends StatelessWidget {
  const EmojiText({
    Key? key,
    required this.text,
    required this.textStyle,
  }) : super(key: key);

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _buildText(text),
    );
  }

  TextSpan _buildText(String text) {
    final children = <TextSpan>[];
    final runes = text.runes;

    for (int i = 0; i < runes.length;) {
      int current = runes.elementAt(i);
      final isEmoji = current > 255;
      final shouldBreak = isEmoji ? (x) => x <= 255 : (x) => x > 255;

      final chunk = <int>[];
      while (!shouldBreak(current)) {
        chunk.add(current);
        if (++i >= runes.length) break;
        current = runes.elementAt(i);
      }

      children.add(
        TextSpan(
          text: String.fromCharCodes(chunk),
          style: TextStyle(
            fontFamily: isEmoji ? 'EmojiOne' : null,
          ),
        ),
      );
    }

    return TextSpan(children: children);
  }
}
