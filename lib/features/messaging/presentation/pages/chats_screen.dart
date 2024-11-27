import 'package:cv_frontend/features/messaging/data/models/get_chat_model.dart';
import 'package:cv_frontend/features/messaging/presentation/bloc/messaging_bloc.dart';
import 'package:cv_frontend/features/messaging/presentation/pages/chatting_screen.dart';
import 'package:cv_frontend/features/messaging/presentation/pages/widgets/chat_card.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/utils/date_utils.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoadingMore = false;
  late Chat chat;

  @override
  void initState() {
    super.initState();
    _fetchChats();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          !_isLoadingMore &&
          context.read<MessagingBloc>().hasMoreChats) {
        _fetchMoreChats();
      }
    });
  }

  void _fetchChats() {
    context
        .read<MessagingBloc>()
        .add(GetChatsEvent(page: _currentPage.toString()));
  }

  void _fetchMoreChats() {
    setState(() {
      _isLoadingMore = true;
      _currentPage++;
    });

    context
        .read<MessagingBloc>()
        .add(GetChatsEvent(page: _currentPage.toString()));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        titleText: "Message",
        logo: AssetImage('assets/images/logo.webp'),
      ),
      body: SafeArea(
        child: BlocConsumer<MessagingBloc, MessagingState>(
          listener: (context, state) {
            if (state is GetChatsSuccess) {
              setState(() {
                _isLoadingMore = false;
              });
            } else if (state is MessagingFailure) {
              setState(() {
                _isLoadingMore = false;
              });
            }
          },
          builder: (context, state) {
            if (state is MessagingLoading && _currentPage == 1) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetChatsSuccess) {
              if (state.chatModel.chats!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "No Messages found.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.chatModel.chats?.length ??
                        0 + (_isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.chatModel.chats?.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final chat = state.chatModel.chats![index];

                      return ChatCard(
                        receiverImage: chat.otherUser!.profileImg ?? '',
                        receiverName: chat.otherUser!.username ?? '',
                        lastMessage: chat.latestMessage?.content ?? '',
                        lastConversationDate:
                            timeAgoFormessaging(chat.latestMessage!.createdAt!),
                        numberOfNotReadMessages:
                            chat.unseenMessagesCount.toString(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => sl<MessagingBloc>(),
                                  child: ChattingScreen(
                                      receiverName:
                                          chat.otherUser!.username ?? "",
                                      receiverId: chat.otherUser!.id ?? '',
                                      chatId: chat.id ?? ""),
                                ),
                              )).then(
                            (_) {
                              if (context.mounted) {
                                context.read<MessagingBloc>().add(GetChatsEvent(
                                    page: _currentPage.toString()));
                              }
                            },
                          );
                        },
                      );
                    });
              }
            } else if (state is MessagingFailure) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
