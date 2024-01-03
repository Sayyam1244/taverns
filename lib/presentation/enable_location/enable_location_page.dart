import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'enable_location_cubit.dart';

class EnableLocationPage extends StatefulWidget {
  final EnableLocationCubit cubit;

  const EnableLocationPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<EnableLocationPage> createState() => _EnableLocationState();
}

class _EnableLocationState extends State<EnableLocationPage> {
  EnableLocationCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(imagePath: ImageConstant.enableLocation),
            SizedBox(height: 40.v),
            Text(
              'Location Permissions\n(For Nearby Events)',
              textAlign: TextAlign.center,
              style: CustomTextStyles.headlineLargeGrey,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 20.v),
        child: CustomElevatedButton(
          text: "Enable location",
          onPressed: () {
            cubit.saveUserLocation(context);
          },
        ),
      ),
    );
  }
}
