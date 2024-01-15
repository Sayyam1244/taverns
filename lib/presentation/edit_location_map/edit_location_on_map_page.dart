import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/edit_location_map/sub_components/search_item.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/custom_search_view.dart';
import 'edit_location_on_map_cubit.dart';
import 'edit_location_on_map_state.dart';

class EditLocationOnMapPage extends StatefulWidget {
  final EditLocationOnMapCubit cubit;

  const EditLocationOnMapPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<EditLocationOnMapPage> createState() => _EditLocationOnMapState();
}

class _EditLocationOnMapState extends State<EditLocationOnMapPage> {
  EditLocationOnMapCubit get cubit => widget.cubit;

  Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  TextEditingController searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    cubit.navigator.context = context;
    searchController.text = cubit.initialParams.userModel.businessAddress!;
    super.initState();

    _focusNode.addListener(() {
      widget.cubit.updateSearchFocus(_focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _mapController.future.then((value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.v,
            backgroundColor: theme.colorScheme.background,
            elevation: 0,
            title: AppbarSubtitleOne(text: "Update your address"),
          ),
          body: Container(
            child: Stack(
              children: [
                Listener(
                  onPointerDown: (_) {
                    if (_focusNode.hasFocus) {
                      _focusNode.unfocus();
                      widget.cubit.updateSearchFocus(false);
                    }
                  },
                  child: IgnorePointer(
                    ignoring: _focusNode.hasFocus,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(cubit.initialParams.userModel.lat!),
                            double.parse(cubit.initialParams.userModel.long!),
                          ),
                          zoom: 14),
                      onCameraMove: (position) {
                        widget.cubit.saveLatlong(position.target);
                      },
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                      },
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.location_on,
                    size: 60.v,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  height: 130.v,
                  decoration: BoxDecoration(color: appTheme.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      SizedBox(height: 10.v),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            Text(
                              "Business Address",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyles.titleMediumGray60001,
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                if (searchController.text.isEmpty) {
                                  cubit.navigateBack(cubit.initialParams.userModel.businessAddress!);
                                } else {
                                  cubit.navigateBack(searchController.text);
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: appTheme.green300,
                                    size: 18,
                                  ),
                                  SizedBox(width: 6.h),
                                  Text(
                                    "Save",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.titleMediumGray60001,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.v),
                      Divider(),
                      SizedBox(height: 10.v),
                      TextFormField(
                        focusNode: _focusNode,
                        controller: searchController,
                        style: CustomTextStyles.titleMediumCircularStdBluegray800,
                        decoration: InputDecoration(
                          hintText: 'Type Your Address here',
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: InputBorder.none,
                        ),
                        onChanged: (v) {
                          if (v.length > 2) {
                            widget.cubit.autocompleteSearchForMap(v);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<EditLocationOnMapCubit, EditLocationOnMapState>(
                  buildWhen: (previous, current) {
                    if (previous.autocompletePlaces != current.autocompletePlaces || previous.isSearchFocused != current.isSearchFocused) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  bloc: widget.cubit,
                  builder: (ctx, state) => state.isSearchFocused
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            margin: EdgeInsets.only(top: 140.v, left: 20, right: 20),
                            decoration: BoxDecoration(color: appTheme.white, borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              // shrinkWrap: true,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ...state.autocompletePlaces.map((e) => SearchItem(
                                    searchText: e.description.toString(),
                                    onTap: () async {
                                      widget.cubit.updateSearchFocus(false);
                                      await widget.cubit.updateMap(e.placeId, context).then((value) async {
                                        final GoogleMapController controller = await _mapController.future;
                                        await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: value!, zoom: 14.4746)));
                                      });
                                      _focusNode.unfocus();
                                      searchController.text = e.description;
                                    }))
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          )),
    );
  }
}
