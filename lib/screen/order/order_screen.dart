import 'package:flutter/material.dart';
import 'package:kitchen/appstate.dart';
import 'package:kitchen/core/theme/theme_helper.dart';
import 'package:kitchen/core/utils/alert.dart';
import 'package:kitchen/core/utils/datetime_ui.dart';
import 'package:kitchen/screen/components/order_card.dart';
import 'package:kitchen/core/api/frappe_kitchen/kitchen_delivery.dart'
    as FrappeFetchDataGetDelivery;
//import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OrderScreen extends StatefulWidget {
  //final String selectedCategory;
  //final List<Map<String, dynamic>> dataOrder;

  const OrderScreen({
    Key? key,
    //required this.selectedCategory,
    //required this.dataOrder,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  double _opacity = 1.0;
  List<dynamic> tempPosServed = [];
  List<dynamic> servedDisplay = [];
  List<dynamic> tempPosCart = [];

  bool isLoadingContent = false;

  //final soLoud = SoLoud.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _initializeAudio();
  //   });
  // }

  @override
  void didUpdateWidget(OrderScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (oldWidget.dataOrder != widget.dataOrder) {
    //   _fadeOutIn();
    // }
  }

  void _fadeOutIn() async {
    setState(() {
      _opacity = 0.0;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _opacity = 1.0;
    });
  }

  // void _initializeAudio() async {
  //   await soLoud.init();
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 300),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
  child: isLoadingContent == false
      ? AlignedGridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: servedDisplay.length,
          itemBuilder: (context, index) {
            final order = servedDisplay[index];
            dynamic orderItemList = order['items'];
            return InkWell(
              onTap: () {
                //addToCartFromOrder(context, order);
              },
              child: Card(
                elevation: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        16.0,
                        16.0,
                        10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order['name'],
                                style: theme.textTheme.titleMedium,
                              ),
                              if (order['table'] != null)
                                Text(
                                  'Table ${order['table']}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                            ],
                          ),
                          Divider(
                            height: 5.0,
                            thickness: 0.5,
                            color: theme.colorScheme.outline,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order['customer_name'].toString(),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              4.0,
                              0.0,
                              4.0,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  dateTimeFormat(
                                    'dateui',
                                    order['date'],
                                  ).toString(),
                                  style: theme.textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 5.0,
                            thickness: 0.5,
                            color: theme.colorScheme.outline,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              4.0,
                              0.0,
                              4.0,
                            ),
                            child: Column(
                              children: [
                                ListView.separated(
                                  primary: false,
                                  separatorBuilder: (context, index) => Divider(
                                    height: 12,
                                    thickness: 0.5,
                                    color: theme.colorScheme.outline,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: orderItemList.length,
                                  itemBuilder: (context, idx) {
                                    dynamic orderItem = orderItemList[idx];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${orderItem['qty']}x",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  "${orderItem['item_name']} - ${orderItem['variant'] ?? ''}",
                                                  style: theme
                                                      .textTheme.titleMedium,
                                                  maxLines: 2,
                                                  minFontSize: 10,
                                                  maxFontSize: 14,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                if ((orderItem.containsKey(
                                                        'note')) &&
                                                    (orderItem['note'] !=
                                                        null) &&
                                                    (orderItem['note'] != ''))
                                                  AutoSizeText(
                                                    "Notes: ${orderItem['note']}",
                                                    style: theme
                                                        .textTheme.labelSmall,
                                                    maxLines: 2,
                                                    minFontSize: 10,
                                                    maxFontSize: 12,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            (orderItem['docstatus'] == 1)
                                                ? 'Confirm'
                                                : (orderItem['docstatus'] == 2)
                                                    ? 'Cancelled'
                                                    : 'Draft',
                                            style:
                                                (orderItem['docstatus'] != 1)
                                                    ? TextStyle(
                                                        color: () {
                                                          if (orderItem[
                                                                  'docstatus'] ==
                                                              1) {
                                                            return theme
                                                                .colorScheme
                                                                .primary;
                                                          } else if (orderItem[
                                                                  'docstatus'] ==
                                                              2) {
                                                            return theme
                                                                .colorScheme
                                                                .error;
                                                          } else {
                                                            return theme
                                                                .colorScheme
                                                                .onPrimaryContainer;
                                                          }
                                                        }(),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                      )
                                                    : TextStyle(
                                                        color: theme
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                      ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      : Container(), // Bisa diganti dengan widget lain jika isLoadingContent == true
      ),
      ),
    );
  }

  onCallDataPosDelivery({String? id}) async {
    final FrappeFetchDataGetDelivery.KitchenDeliveryRequest request =
        FrappeFetchDataGetDelivery.KitchenDeliveryRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: id != null ? '[["name","=","$id"]]' : '[]',
      limit: 2000,
    );

    try {
      final callRequest =
          await FrappeFetchDataGetDelivery.request(requestQuery: request);
      // print('check pos order, $callRequest');
      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosServed = callRequest;
          //loadAndPlayAudio();
        });
      }
    } catch (error) {
      print('error call data pos order, $error');
      if (context.mounted) {
        alertError(context, error.toString());
      }
    }
  }

  reformatServedCart() async {
    List<dynamic> cartNew = [];

    // print('temp cart, ${tempPosCart[0]}');
    print('temp served, ${tempPosServed}');

    if (tempPosCart.isNotEmpty) {
      for (dynamic cartTemp in tempPosCart) {
        dynamic tmp = cartTemp;
        // print('temp order, $tempPosOrder');

        tmp['items'] = tempPosServed
            .where((ord) => ord['pos_cart'] == tmp['name'])
            .toList();
        cartNew.add(tmp);
      }
    }

    // print('check cart new, $cartNew');
    // print('check cart new, ${cartNew.length}');
    setState(() {
      servedDisplay = cartNew;
      isLoadingContent = false;
      //loadAndPlayAudio();
    });
    // onTapRefreshOrder();
  }

  // Future<void> loadAndPlayAudio() async {
  //   final audioSource =
  //       await soLoud.loadAsset('assets/audio/delivery_notif.mp3');
  //   final soundHandle = await soLoud.play(audioSource);
  // }
}
