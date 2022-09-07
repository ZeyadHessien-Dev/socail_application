import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/layout_cubit/cubit.dart';
import 'package:social_aplication/layout/layout_cubit/states.dart';
import 'package:social_aplication/model/message_model.dart';
import 'package:social_aplication/shared/style/icon_broken.dart';
import '../../model/user_model.dart';
import '../../shared/components/constants.dart';

class ChatScreen extends StatefulWidget {
  UserModel userModel;
  ChatScreen(this.userModel);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void scrollBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollBottom());
    return Builder(
      builder: (context) {
        SocialLayoutCubit.get(context).getMessage(receiverUid: widget.userModel.uid!);

        return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
          listener: (context, state) {
            if (state is SuccessGetMessagesState) {
              textController.clear();
            }
          },
          builder: (context, state) {
            var cubit = SocialLayoutCubit.get(context);
            var cubitMessages = SocialLayoutCubit.get(context).messages;
            return cubitMessages != null
                ? Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          IconBroken.Arrow___Left_2,
                        ),
                      ),
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(
                              widget.userModel.image!,
                            ),
                          ),
                          const SizedBox(
                            width: 15.5,
                          ),
                          Text(widget.userModel.name!),
                        ],
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                if (UID != cubitMessages[index].senderUID!) {
                                  return userMessage(cubitMessages[index]);
                                }
                                return myMessage(cubitMessages[index]);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: cubit.messages.length,
                            ),
                          ),
                          if (state is LoadingSendMessagesState)
                            const LinearProgressIndicator(),
                          if (state is LoadingSendMessagesState)
                            const SizedBox(
                              height: 10,
                            ),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10.0,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 60.0,
                                    child: TextFormField(
                                      controller: textController,
                                      decoration: const InputDecoration(
                                        hintText: 'Write Message ..',
                                        helperStyle: TextStyle(
                                          fontSize: 10.0,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 60.0,
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    onPressed: () {
                                      cubit.sendMessage(
                                        text: textController.text,
                                        dateTime: DateTime.now().toString(),
                                        receiverUid: widget.userModel.uid!,
                                        senderUid: UID,
                                      );
                                    },
                                    child: const Icon(
                                      IconBroken.Message,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        );
      },
    );
  }

  Widget myMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          padding: const EdgeInsets.all(
            10.0,
          ),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(
                10.0,
              ),
              bottomStart: Radius.circular(
                10.0,
              ),
              bottomEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          child: Text(
            model.text!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      );

  Widget userMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          padding: const EdgeInsets.all(
            10.0,
          ),
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(
                10.0,
              ),
              bottomStart: Radius.circular(
                10.0,
              ),
              bottomEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          child: Text(
            model.text!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      );
}
