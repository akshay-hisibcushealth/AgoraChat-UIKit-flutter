import 'dart:io';

import 'package:agora_chat_uikit/views/photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:agora_chat_uikit/tools/icon_image_provider.dart';

import '../../../agora_chat_uikit.dart';

class ChatMessageListImageItem extends ChatMessageListItem {
  const ChatMessageListImageItem({
    super.key,
    required super.model,
    super.onTap,
    super.onBubbleLongPress,
    super.onBubbleDoubleTap,
    super.onResendTap,
    super.avatarBuilder,
    super.nicknameBuilder,
    super.bubbleColor,
    super.bubblePadding,
    super.unreadFlagBuilder
  });

  @override
  Widget build(BuildContext context) {
    ChatMessage message = model.message;
    ChatImageMessageBody body = message.body as ChatImageMessageBody;

    double max = getMaxWidth(context);
    double width = body.width ?? max;
    double height = body.height ?? max;

    double ratio = width / height;
    if (ratio <= 0.5 || ratio >= 2) {
      max = max / 3 * 4;
    }
    if (width > height) {
      height = max / width * height;
      width = max;
    } else {
      width = max / height * width;
      height = max;
    }

    Widget content;

    do {
      File file = File(body.localPath);
      if (file.existsSync()) {
        content = Image(
          gaplessPlayback: true,
          image: ResizeImage(
            FileImage(file),
            width: width.toInt(),
            height: height.toInt(),
          ),
          fit: BoxFit.fill,
        );
        break;
      }
      if (body.thumbnailLocalPath != null) {
        File thumbnailFile = File(body.thumbnailLocalPath!);
        if (thumbnailFile.existsSync()) {
          content = Image(
            gaplessPlayback: true,
            image: ResizeImage(
              FileImage(thumbnailFile),
              width: width.toInt(),
              height: height.toInt(),
            ),
            fit: BoxFit.fill,
          );
          break;
        }
      }
      if (body.thumbnailRemotePath != null) {
        content = Container(
          color: const Color.fromRGBO(242, 242, 242, 1),
          child: FadeInImage(
            placeholderFit: BoxFit.contain,
            placeholder: IconImageProvider(Icons.image),
            image: NetworkImage(body.thumbnailRemotePath!),
            imageErrorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 48);
            },
            fit: BoxFit.fill,
          ),
        );
        break;
      }
      content = const Icon(Icons.broken_image, size: 58, color: Colors.white);
    } while (false);

    content = SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: content,
      ),
    );

    return getBubbleWidget(content);
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
