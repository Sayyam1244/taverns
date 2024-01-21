import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_state.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/widgets/chipview_item_widget.dart';
import '../../widgets/custom_elevated_button.dart';
import 'signup_select_role_cubit.dart';

class SignupSelectRolePage extends StatefulWidget {
  final SignupSelectRoleCubit cubit;

  const SignupSelectRolePage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SignupSelectRolePage> createState() => _SignupSelectRoleState();
}

class _SignupSelectRoleState extends State<SignupSelectRolePage> {
  SignupSelectRoleCubit get cubit => widget.cubit;

  @override
  void initState() {
    cubit.navigator.context = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: BlocBuilder<SignupSelectRoleCubit, SignupSelectRoleState>(
            bloc: cubit,
            builder: (context, state) => Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 5.v),
                    padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 120.v),
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ImageConstant.imgGroup3), fit: BoxFit.cover)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(imagePath: ImageConstant.selectRole, height: 210.v, width: 300.h),
                        SizedBox(height: 81.v),
                        Text("Select Role", style: CustomTextStyles.titleMediumCircularStdBluegray800),
                        SizedBox(height: 29.v),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 1,
                                child: ChipviewItemWidget(
                                  isSelected: state.selectedRoleIndex == 0,
                                  text: state.userType[0],
                                  ontap: () {
                                    cubit.changeRole(0);
                                  },
                                )),
                            SizedBox(width: 10.h),
                            Expanded(
                                flex: 1,
                                child: ChipviewItemWidget(
                                  isSelected: state.selectedRoleIndex == 1,
                                  text: state.userType[1],
                                  ontap: () {
                                    cubit.changeRole(1);
                                  },
                                )),
                          ],
                        ),
                        SizedBox(height: 17.v),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 2,
                                child: ChipviewItemWidget(
                                  isSelected: state.selectedRoleIndex == 2,
                                  text: state.userType[2],
                                  ontap: () {
                                    cubit.changeRole(2);
                                  },
                                )),
                            Expanded(flex: 1, child: Container()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 5.v),
                    child: CustomElevatedButton(text: "Next",onPressed: () {
                      cubit.saveType(context);
                    },),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
