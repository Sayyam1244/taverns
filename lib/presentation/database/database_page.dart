import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
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
import 'package:taverns/widgets/custom_text_form_field.dart';
import 'database_cubit.dart';
import 'database_state.dart';

class DatabasePage extends StatefulWidget {
  final DatabaseCubit cubit;

  const DatabasePage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<DatabasePage> createState() => _DatabaseState();
}

class _DatabaseState extends State<DatabasePage> {
  DatabaseCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        title: AppbarSubtitleOne(text: "Database"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          ExpansionTile(
            backgroundColor: appTheme.yellow50,
            collapsedBackgroundColor: appTheme.yellow50,
            title: Text(
              'TTRPG',
              style: CustomTextStyles.titleMedium16,
            ),
            children: [
              ListTile(
                onTap: () {
                  cubit.navigateToCharacterSheets();
                },
                title: Text(
                  'Character Sheets',
                  style: CustomTextStyles.titleSmallMulishGray800,
                ),
              ),
              ListTile(
                onTap: () {
                  cubit.navigateToCompendium();
                },
                title: Text(
                  'Compendium',
                  style: CustomTextStyles.titleSmallMulishGray800,
                ),
              ),
              // ListTile(
              //   onTap: () {},
              //   title: Text(
              //     'Homebrew',
              //     style: CustomTextStyles.titleSmallMulishGray800,
              //   ),
              // ),
              ListTile(
                onTap: () {
                  TextEditingController title = TextEditingController();
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) {
                      return Container(
                        height: MediaQuery.sizeOf(context).height - 100,
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Add System',
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
                              autofocus: false,
                              controller: title,
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
                              hintText: 'System Name',
                            ),
                            SizedBox(height: 20),
                            CustomElevatedButton(
                              text: "Add",
                              onPressed: () {
                                getIt<DatabaseHelper>().insertSystem(
                                    System(title: title.text.trim()).toMap());
                                Navigator.pop(context);
                                FlushbarDialogue().showFlushbar(
                                    context: context,
                                    title: 'System',
                                    body: 'Entry Added successfully');
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                title: Text(
                  'System',
                  style: CustomTextStyles.titleSmallMulishGray800,
                ),
              ),
              ListTile(
                onTap: () {
                  TextEditingController title = TextEditingController();
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) {
                      return Container(
                        height: MediaQuery.sizeOf(context).height - 100,
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Add Category',
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
                              autofocus: false,
                              controller: title,
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
                              hintText: 'Category Name',
                            ),
                            SizedBox(height: 20),
                            CustomElevatedButton(
                              text: "Add",
                              onPressed: () {
                                getIt<DatabaseHelper>().insertCategory(
                                    Category(title: title.text.trim()).toMap());
                                Navigator.pop(context);
                                FlushbarDialogue().showFlushbar(
                                    context: context,
                                    title: 'Category',
                                    body: 'Entry Added successfully');
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                title: Text(
                  'Category',
                  style: CustomTextStyles.titleSmallMulishGray800,
                ),
              ),
              ListTile(
                onTap: () async {
                  int? categoryId;
                  List<Category> ls = await getIt<DatabaseHelper>()
                      .getAllCategories()
                      .then((value) =>
                          value.map((e) => Category.fromMap(e)).toList());
                  if (ls.isNotEmpty) {
                    TextEditingController title = TextEditingController();

                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) {
                        return Container(
                          height: MediaQuery.sizeOf(context).height - 100,
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Add Sub Category',
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
                              SizedBox(height: 20),
                              CustomTextFormField(
                                autofocus: false,
                                controller: title,
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
                                hintText: 'Category Name',
                              ),
                              SizedBox(height: 10),
                              CustomDropdownWidget(
                                  onChanged: (v) async {
                                    log(v.toString());
                                    categoryId = ls
                                        .firstWhere(
                                            (element) => element.title == v!)
                                        .id;
                                  },
                                  hinttext: 'Select Category',
                                  list: ls.map((e) => e.title).toList()),
                              SizedBox(height: 20),
                              CustomElevatedButton(
                                text: "Add",
                                onPressed: () {
                                  getIt<DatabaseHelper>().insertSubCategory(
                                      SubCategory(
                                              categoryId: categoryId!,
                                              title: title.text)
                                          .toMap());
                                  Navigator.pop(context);
                                  FlushbarDialogue().showFlushbar(
                                      context: context,
                                      title: 'Sub Category',
                                      body: 'Entry Added successfully');
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
                            'First add atleast 1 Category then try adding sheets');
                  }
                },
                title: Text(
                  'Sub-Category',
                  style: CustomTextStyles.titleSmallMulishGray800,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ExpansionTile(
            backgroundColor: appTheme.yellow50,
            collapsedBackgroundColor: appTheme.yellow50,
            title: Text(
              'TCGS',
              style: CustomTextStyles.titleMedium16,
            ),
          ),
          SizedBox(height: 20),
          ExpansionTile(
            backgroundColor: appTheme.yellow50,
            collapsedBackgroundColor: appTheme.yellow50,
            title: Text(
              'Board Games',
              style: CustomTextStyles.titleMedium16,
            ),
          ),
        ],
      ),
    );
  }
}
