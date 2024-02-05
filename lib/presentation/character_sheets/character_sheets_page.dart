import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/data/db_helper.dart';
import 'package:taverns/domain/model/db_models.dart';
import 'package:taverns/main.dart';
import 'package:taverns/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:taverns/widgets/custom_dropdown.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_search_view.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';
import 'character_sheets_cubit.dart';
import 'character_sheets_state.dart';

class CharacterSheetsPage extends StatefulWidget {
  final CharacterSheetsCubit cubit;

  const CharacterSheetsPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<CharacterSheetsPage> createState() => _CharacterSheetsState();
}

class _CharacterSheetsState extends State<CharacterSheetsPage> {
  CharacterSheetsCubit get cubit => widget.cubit;
  int? id;
  TextEditingController title = TextEditingController();
  ValueNotifier<String> search = ValueNotifier<String>('');

  @override
  void initState() {
    cubit.navigator.context = context;
    cubit.getCharacterSheets();
    cubit.getSystems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterSheetsCubit, CharacterSheetsState>(
      bloc: cubit,
      builder: (context, state) {
        final systems = state.systems.map((e) => e.title).toList();
        systems.add('All');
        return state.isloading
            ? Scaffold(
                body: Center(child: CustomLoadingWidget()),
              )
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  toolbarHeight: 70.v,
                  backgroundColor: theme.colorScheme.background,
                  elevation: 0,
                  title: AppbarSubtitleOne(text: "Character Sheets"),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Character List',
                            style: CustomTextStyles
                                .titleMediumCircularStdBluegray90001
                                .copyWith(
                                    fontSize: 14, color: appTheme.gray800),
                          ),
                          Spacer(),
                          Container(
                            width: 120,
                            child: CustomDropdown<String>(
                              closedHeaderPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: CustomDropdownDecoration(
                                headerStyle: CustomTextStyles
                                    .bodySmallCircularStdBluegray40001,
                                hintStyle: CustomTextStyles
                                    .bodySmallCircularStdBluegray40001,
                                closedFillColor: appTheme.yellow50,
                                closedBorderRadius: BorderRadius.circular(16.h),
                              ),
                              hintText: 'Sort by',
                              items: systems,
                              onChanged: (v) {
                                if (v == 'All') {
                                  cubit.getCharacterSheets();
                                } else {
                                  id = state.systems
                                      .singleWhere(
                                          (element) => element.title == v)
                                      .id!;
                                  cubit.getCharacterSheets(sysId: id);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomSearchView(
                        autofocus: false,
                        onChanged: (v) {
                          search.value = v;
                        },
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: search,
                          builder: (context, v, child) {
                            List<Character> data = state.characters;
                            if (v != '') {
                              data = data
                                  .where((element) => element.title
                                      .toUpperCase()
                                      .contains(v.toString().toUpperCase()))
                                  .toList();
                            }
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.only(
                                  left: 15.h,
                                  bottom: 15.v,
                                ),
                                decoration:
                                    AppDecoration.outlineBlueGray.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          data[index].title,
                                          style: CustomTextStyles
                                              .titleMediumCircularStdBluegray90001,
                                        ),
                                        Spacer(),
                                        PopupMenuButton<String>(
                                          onSelected: (v) {},
                                          itemBuilder: (BuildContext context) {
                                            return {'Delete', 'Share', "Send"}
                                                .map((String choice) {
                                              return PopupMenuItem<String>(
                                                onTap: () {
                                                  if (choice == 'Delete') {
                                                    getIt<DatabaseHelper>()
                                                        .deleteCharacter(
                                                            data[index].id!);
                                                    cubit.getCharacterSheets();
                                                  }
                                                  if (choice == "Send") {
                                                    cubit.navigateToShare(
                                                        data[index]);
                                                  }
                                                  if (choice == "Share") {
                                                    cubit.share({
                                                      'TYPE': 'Character Sheet',
                                                      'sheetName':
                                                          data[index].title,
                                                      'level':
                                                          data[index].level,
                                                      'system': data[index]
                                                          .system!
                                                          .title,
                                                      'category': null,
                                                      'subCategory': null,
                                                    }, context);
                                                  }
                                                },
                                                value: choice,
                                                child: Text(choice),
                                              );
                                            }).toList();
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(
                                      data[index].system!.title.toString(),
                                      style: CustomTextStyles
                                          .bodySmallSFProBluegray40001,
                                    ),
                                    Text(
                                      data[index].level.toString() + " Level",
                                      style: CustomTextStyles
                                          .bodySmallSFProBluegray40001
                                          .copyWith(color: appTheme.gray400),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomElevatedButton(
                    text: "Create new",
                    onPressed: () async {
                      late int level;
                      late int systemId;

                      List ls = await getIt<DatabaseHelper>().getAllSystems();
                      if (ls.isNotEmpty) {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.sizeOf(context).height - 100,
                              child: ListView(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Add Character',
                                        style: CustomTextStyles
                                            .titleMediumCircularStdBluegray800,
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  CustomTextFormField(
                                    controller: title,
                                    autofocus: false,
                                    // controller: marketPlaceController,
                                    prefix: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            16.h, 16.v, 12.h, 16.v),
                                        child: Icon(
                                          Icons.person,
                                          color: theme.colorScheme.primary,
                                          size: 20,
                                        )),
                                    prefixConstraints: BoxConstraints(
                                      maxHeight: 56.v,
                                    ),
                                    suffixConstraints: BoxConstraints(
                                      maxHeight: 56.v,
                                    ),
                                    hintText: 'Character Name',
                                  ),
                                  SizedBox(height: 20),
                                  CustomDropdownWidget(
                                    list: state.systems
                                        .map((e) => e.title)
                                        .toList(),
                                    onChanged: (v) {
                                      systemId = state.systems
                                          .singleWhere(
                                              (element) => element.title == v)
                                          .id!;
                                    },
                                    hinttext: 'System',
                                  ),
                                  SizedBox(height: 12),
                                  CustomDropdownWidget(
                                    list: List.generate(
                                        100, (index) => index.toString()),
                                    onChanged: (v) {
                                      level = int.parse(v!);
                                    },
                                    hinttext: 'Level',
                                  ),
                                  SizedBox(height: 30),
                                  CustomElevatedButton(
                                    text: "Confirm",
                                    onPressed: () {
                                      if (level != null && systemId != null) {
                                        getIt<DatabaseHelper>()
                                            .insertCharacter(Character(
                                          title: title.text.trim(),
                                          level: level,
                                          systemId: systemId,
                                        ).toMap());
                                        cubit.getCharacterSheets();
                                        Navigator.pop(context);
                                      }
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        FlushbarDialogue().showFlushbar(
                            context: context,
                            title: 'Error',
                            body:
                                'First add System then try adding character sheets');
                      }
                    },
                  ),
                ),
              );
      },
    );
  }
}
