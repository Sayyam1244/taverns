import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/user_model.dart';
import 'package:taverns/presentation/chat_list/chat_list_state.dart';
import 'package:taverns/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:taverns/widgets/custom_search_view.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';
import 'chat_list_cubit.dart';

class ChatListPage extends StatefulWidget {
  final ChatListCubit cubit;

  const ChatListPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListState();
}

class _ChatListState extends State<ChatListPage> with ChangeNotifier {
  ChatListCubit get cubit => widget.cubit;
  ValueNotifier<String> search = ValueNotifier<String>('');

  @override
  void initState() {
    cubit.getUsers(context);
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        title: AppbarSubtitleOne(text: "Users"),
      ),
      body: BlocBuilder<ChatListCubit, ChatListState>(
        bloc: cubit,
        builder: (ctx, state) => state.isloading
            ? CustomLoadingWidget()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: CustomSearchView(
                      autofocus: false,
                      onChanged: (v) {
                        search.value = v;
                        search.notifyListeners();
                      },
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: search,
                      builder: (context, v, child) {
                        List<UserModel> data = state.users;
                        if (v != '') {
                          log(v.toString());

                          data = data
                              .where((element) => element.userName!
                                  .toUpperCase()
                                  .contains(v.toString().toUpperCase()))
                              .toList();
                        }
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) => Container(
                            clipBehavior: Clip.hardEdge,
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.h, vertical: 6.v),
                            decoration:
                                AppDecoration.fillOnErrorContainer.copyWith(
                              color: appTheme.black9000a,
                              borderRadius: BorderRadiusStyle.roundedBorder16,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (cubit.initialParams.character != null) {
                                  cubit.sendToUserAndNavigate(
                                      content: 'Character Sheet',
                                      otherUserID: data[index].docId!,
                                      sheetName:
                                          cubit.initialParams.character!.title,
                                      type: 'Character Sheet',
                                      level:
                                          cubit.initialParams.character!.level,
                                      system: cubit.initialParams.character!
                                          .system!.title,
                                      context: ctx);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.h,
                                  vertical: 15.v,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index].userName ?? '',
                                          style: CustomTextStyles
                                              .titleMediumCircularStdBluegray90001),
                                      Text(data[index].accountType ?? '',
                                          style: CustomTextStyles
                                              .bodySmallCircularStdBluegray40001),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
