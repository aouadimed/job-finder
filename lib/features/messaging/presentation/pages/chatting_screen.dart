import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/features/messaging/presentation/bloc/messaging_bloc.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChattingScreen extends StatefulWidget {
  final String receiverName;
  final String receiverId;
  final String chatId;

  const ChattingScreen({
    Key? key,
    required this.receiverName,
    required this.receiverId,
    required this.chatId,
  }) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late io.Socket socket;
  List<Map<String, Object>> messages = [];
  bool isTyping = false;
  bool isLoadingMore = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    initializeSocket();
    context.read<MessagingBloc>().add(
        GetMessagesChatEvent(id: widget.chatId, page: currentPage.toString()));
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    socket.disconnect();
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void initializeSocket() {
    socket = io.io('http://$url', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      socket.emit('join chat', widget.chatId);
    });

    socket.on('message-received', (data) {
      if (mounted) {
        setState(() {
          messages.insert(0, <String, Object>{
            'content': data['content'],
            'isMe': false,
          });
        });
      }
    });

    socket.on('typing', (room) {
      if (room == widget.chatId) {
        setState(() {
          isTyping = true;
        });
      }
    });

    socket.on('stop-typing', (room) {
      if (room == widget.chatId) {
        setState(() {
          isTyping = false;
        });
      }
    });

    socket.onDisconnect((_) {
      //  print('Disconnected from socket server');
    });
  }

  void _sendMessage() {
    final content = messageController.text.trim();
    if (content.isNotEmpty) {
      context.read<MessagingBloc>().add(
            SendMessageEvent(
              receiver: widget.receiverId,
              content: content,
            ),
          );
      messageController.clear();

      final message = {
        'content': content,
        'sender': {'_id': 'your_sender_id'},
        'chat': {'_id': widget.chatId},
      };

      socket.emit('new message', message);
      socket.emit('stop-typing', widget.chatId);

      setState(() {
        messages.insert(0, <String, Object>{
          'content': content,
          'isMe': true,
        });
      });
    }
FocusScope.of(context).unfocus();


  }

  void _onMessageChanged(String text) {
    if (text.isNotEmpty) {
      socket.emit('typing', widget.chatId);
    } else {
      socket.emit('stop-typing', widget.chatId);
    }
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _loadMoreMessages();
    }
  }

  void _loadMoreMessages() {
    if (!isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      currentPage++;
      context.read<MessagingBloc>().add(GetMessagesChatEvent(
          id: widget.chatId, page: currentPage.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        titleText: widget.receiverName,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildMessagesList(),
            if (isTyping) _buildTypingIndicator(),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    return Expanded(
      child: BlocBuilder<MessagingBloc, MessagingState>(
        builder: (context, state) {
          if (state is MessagingLoading && currentPage == 1) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMessagesSuccess) {
            final newMessages = state.chatMessage.messages.map((message) {
              return <String, Object>{
                'content': message.content,
                'isMe': message.sender != widget.receiverId,
              };
            }).toList();
            messages = [
              ...messages.where((localMessage) => newMessages.every(
                  (newMessage) =>
                      newMessage['content'] != localMessage['content'])),
              ...newMessages,
            ];

            isLoadingMore = false;
          } else if (state is MessagingFailure) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: redColor),
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            reverse: true,
            itemCount: messages.length + (isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == messages.length && isLoadingMore) {
                return const Center(child: CircularProgressIndicator());
              }

              final message = messages[index];
              return message['isMe'] == true
                  ? _buildSenderBubble(message['content'] as String)
                  : _buildReceiverBubble(message['content'] as String);
            },
          );
        },
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return _buildReceiverBubble('Typing...');
  }

  Widget _buildReceiverBubble(String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChatBubble(
        clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
        alignment: Alignment.topLeft,
        backGroundColor: const Color(0xffE7E7ED),
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: Text(
            content,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ),
    );
  }

  Widget _buildSenderBubble(String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChatBubble(
        clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        backGroundColor: primaryColor,
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: Text(
            content,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: InputField(
              controller: messageController,
              hint: "Type a message ...",
              hintColor: Colors.grey[400],
              onChanged: _onMessageChanged,
              suffixIcon: IconButton(
                icon: const Icon(Feather.send),
                color: primaryColor,
                onPressed: _sendMessage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
