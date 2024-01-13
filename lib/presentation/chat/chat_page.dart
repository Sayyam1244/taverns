import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';
import 'chat_cubit.dart';
import 'chat_state.dart';

class ChatPage extends StatefulWidget {
  final ChatCubit cubit;

  const ChatPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatState();
}

class _ChatState extends State<ChatPage> {
  ChatCubit get cubit => widget.cubit;
  TextEditingController msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<String> msgs = [
    'This is a test message you can a test a dummy message too.'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        // title: Text('Tavern Profile', style: CustomTextStyles.titleMedium16),
        actions: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 50.h),
                height: 45.adaptSize,
                width: 45.adaptSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // image: DecorationImage(image: NetworkImage(imagePath)),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 1,
                  ),
                ),
              ),
              SizedBox(width: 12.h),
              Container(
                height: 60.adaptSize,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // color: Colors.amber,
                      child: Text(
                        'GM0001231',
                        style: CustomTextStyles.titleMedium16,
                      ),
                    ),
                    Text(
                      'GM',
                      style: CustomTextStyles.bodySmallMulishBluegray900,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: msgs.length,
              itemBuilder: (context, index) {
                final data = msgs.reversed.toList();
                return Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * .7,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * .7,
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                )),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Text(
                              data[index],
                              style: CustomTextStyles.titleSmallStd14Bwhite,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                '12/11/2024 12:09PM',
                                style: CustomTextStyles
                                    .bodySmallSFProBluegray40001,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Icon(
                    Icons.add,
                    color: appTheme.white,
                    size: 16,
                  ),
                ),
                Expanded(
                    child: CustomTextFormField(
                  controller: msgController,
                  hintText: 'Write here...',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                )),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(left: 8),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      if (msgController.text.isNotEmpty) {
                        msgs.add(msgController.text);
                        setState(() {});
                        msgController.clear();
                      }
                    },
                    child: Icon(
                      Icons.arrow_outward,
                      color: appTheme.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
