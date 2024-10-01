import 'dart:math';

import 'package:agora_chat_uikit/agora_chat_uikit.dart';
import 'package:flutter/widgets.dart';

import '../../../em_chat_define.dart';
import '../../../models/chat_message_list_item_model.dart';
import 'chat_message_bubble.dart';

class ChatMessageListItem extends StatelessWidget {
  const ChatMessageListItem({
    super.key,
    required this.model,
    this.onTap,
    this.onBubbleLongPress,
    this.onBubbleDoubleTap,
    this.onResendTap,
    this.avatarBuilder,
    this.nicknameBuilder,
    this.bubbleColor,
    this.bubblePadding,
    this.unreadFlagBuilder,
    this.previousMessage,
  });

  final ChatMessageListItemModel model;
  final ChatMessage? previousMessage;
  final ChatMessageTapAction? onTap;
  final ChatMessageTapAction? onBubbleLongPress;
  final ChatMessageTapAction? onBubbleDoubleTap;
  final VoidCallback? onResendTap;
  final ChatWidgetBuilder? avatarBuilder;
  final ChatWidgetBuilder? nicknameBuilder;
  final Color? bubbleColor;
  final EdgeInsets? bubblePadding;
  final WidgetBuilder? unreadFlagBuilder;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget getBubbleWidget(Widget content) {
    Widget ret = ChatMessageBubble(
      model: model,
      previousMessage: previousMessage,
      padding: bubblePadding,
      bubbleColor: bubbleColor,
      childBuilder: (context) => content,
      unreadFlagBuilder: unreadFlagBuilder,
      onBubbleDoubleTap: onBubbleDoubleTap,
      onBubbleLongPress: onBubbleLongPress,
      onTap: onTap,
      avatarBuilder: avatarBuilder,
      nicknameBuilder: nicknameBuilder,
      onResendTap: onResendTap,
    );

    return ret;
  }

  /// get max bubble max width.
  double getMaxWidth(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    double max = min(screenW, screenH) * 0.7;
    return max;
  }
}
