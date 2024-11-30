import 'dart:async';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:kitchen/appstate.dart';
import 'package:kitchen/constants.dart';
import 'package:kitchen/core/theme/theme_helper.dart';
import 'package:kitchen/core/utils/alert.dart';
import 'package:kitchen/core/utils/datetime_ui.dart';
import 'package:kitchen/core/utils/print.dart';
import 'package:kitchen/routes/app_routes.dart';
import 'package:kitchen/screen/components/appbar_section.dart';
import 'package:kitchen/core/api/frappe_kitchen/kitchen_cart.dart'
    as FrappeFetchDataGetCart;
import 'package:kitchen/core/api/frappe_kitchen/kitchen_delivery.dart'
    as FrappeFetchDataGetDelivery;
import 'package:kitchen/core/api/send_printer.dart' as sendToPrinter;
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:kitchen/widgets/empty_data.dart';
import 'package:kitchen/widgets/loading_content.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double _opacity = 1.0;
  List<dynamic> tempPosServed = [];
  List<dynamic> servedDisplay = [];
  List<dynamic> tempPosCart = [];
  
  dynamic cartSelected;
  
  DateTime? lastOrderTimestamp;
  Timer? timer;
  bool isLoadingContent = false;

  final soLoud = SoLoud.instance;

  void _fadeOutIn() async {
    setState(() {
      _opacity = 0.0;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _opacity = 1.0;
    });
  }
  void _initializeAudio() async {
     await soLoud.init();
   }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAudio();
    });
    if (servedDisplay.isEmpty) {
      onTapRefreshHistory();
    }
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        //print('halaman di refresh');
        onTapRefreshHistory();
    });
  }
  @override
  Widget build(BuildContext context) {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  final crossAxisCount = isPortrait ? 1 : 2;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
  backgroundColor: HeaderColor,
  leading: IconButton(
    icon: const Icon(Icons.refresh,color: Colors.black,),
    onPressed: () {
      onTapRefreshHistory();
    },
  ),
  title: Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Image.asset(
          "assets/images/logo-kontena.png",
          height: 40,
          width: 70,
        ),
      ),
    ],
  ),
  actions: [
    MaterialButton(
      onPressed: (){
        onLogOut(context);
      },
      child: Icon(Icons.logout,color: Colors.black),
      )
  ],
),

      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                children: [
                    if ( isLoadingContent == false )
                      Padding(padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Align(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          primary: true,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment:MainAxisAlignment.start,
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                  if (servedDisplay.isNotEmpty)
                                            Container(
                                                height: MediaQuery.of(context).size.height * 0.8,
                                                width: MediaQuery.of(context).size.width*0.9,
                                                child: AlignedGridView.count(
                                                  crossAxisCount: crossAxisCount,
                                                  mainAxisSpacing: 2,
                                                  crossAxisSpacing: 6,
                                                  //shrinkWrap: true,
                                                  primary: false,
                                                  physics: const BouncingScrollPhysics(),
                                                  itemCount: servedDisplay.length,
                                                  itemBuilder: (context, index) {
                                                    final order = servedDisplay[index];
                                                    dynamic orderItemList = order['items'];
                                                    //print('Isi orderItemList pada index $index: $orderItemList');
                                                    return InkWell(
                                                      onTap: () {
                                                      },
                                                      child: Card(
                                                        elevation: 2,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB( 10,16.0,16.0, 10.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment.spaceBetween,
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
                                                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        order['customer_name'].toString(),
                                                                        style: theme.textTheme.bodyMedium,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(0.0,4.0,0,4.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          dateTimeFormat('dateui',order['date'],
                                                                          ).toString(),
                                                                          style: theme.textTheme.labelSmall,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Divider(
                                                                    height: 5.0,
                                                                    thickness: 0.5,
                                                                    color: theme
                                                                        .colorScheme
                                                                        .outline,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(0.0,4.0,0.0,4.0,),
                                                                    child: Column(
                                                                      children: [
                                                                        ListView.separated(
                                                                          primary:false,
                                                                          separatorBuilder:
                                                                              (context, index) =>
                                                                                  Divider(
                                                                            height:
                                                                                12,
                                                                            thickness:
                                                                                0.5,
                                                                            color: theme
                                                                                .colorScheme
                                                                                .outline,
                                                                          ),
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount:orderItemList.length,
                                                                          itemBuilder:(context, idx) {
                                                                            dynamic
                                                                                orderItem =
                                                                                orderItemList[idx];
                                                                            return Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  bottom: 8.0),
                                                                              child:
                                                                                  Row(
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
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        AutoSizeText(
                                                                                          "${orderItem['remark']}",
                                                                                          style: theme.textTheme.titleMedium,
                                                                                          maxLines: 2, // Allows up to 2 lines
                                                                                          minFontSize: 10,
                                                                                          maxFontSize: 14,
                                                                                          overflow: TextOverflow.ellipsis, // Ellipsis if it exceeds 2 lines
                                                                                        ),
                                                                                        const SizedBox(height: 4),
                                                                                        if ((orderItem.containsKey('note')) && (orderItem['note'] != null) && (orderItem['note'] != ''))
                                                                                          AutoSizeText(
                                                                                            "Notes: ${orderItem['note']}",
                                                                                            style: theme.textTheme.labelSmall,
                                                                                            maxLines: 2,
                                                                                            minFontSize: 10,
                                                                                            maxFontSize: 12,
                                                                                            overflow: TextOverflow.ellipsis,
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
                                                                                    style: (orderItem['docstatus'] != 1)
                                                                                        ? TextStyle(
                                                                                            color: () {
                                                                                              if (orderItem['docstatus'] == 1) {
                                                                                                return theme.colorScheme.primary;
                                                                                              } else if (orderItem['docstatus'] == 2) {
                                                                                                return theme.colorScheme.error;
                                                                                              } else {
                                                                                                return theme.colorScheme.onPrimaryContainer;
                                                                                              }
                                                                                            }(),
                                                                                            fontWeight: FontWeight.w700,
                                                                                            fontSize: 12,
                                                                                          )
                                                                                        : TextStyle(
                                                                                            color: theme.colorScheme.primary,
                                                                                            fontWeight: FontWeight.w700,
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
                                                ),
                                              ),
                                            
                                          if (servedDisplay.isEmpty)
                                          EmptyData()
                                  ],             
                            ),
                             ),
                        )
                      ),
                    ),
                    if (isLoadingContent)
                              const Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: LoadingContent(),
                              ),
                    ],
              ))
          ],
        ),
      ),
    );
  }
  onTapRefreshHistory() async {
    setState(() {
      isLoadingContent = true;
      servedDisplay.clear();
    });
    await onCallDataPosCart();
    await onCallDataPosDelivery();
    await reformatServedCart();

    //print('check servedDisplay, ${servedDisplay}');
  }
  onCallDataPosCart({String? id}) async {
    final FrappeFetchDataGetCart.PosCartRequest request =
        FrappeFetchDataGetCart.PosCartRequest(
      cookie: AppState().setCookie,
      fields: '["*"]',
      filters: id != null
          ? '[["name","=","$id"]]'
          : '[["closed_at","is","not set"]]',
      limit: 1500,
    );

    try {
      final callRequest =
          await FrappeFetchDataGetCart.requestPosCart(requestQuery: request);
      // print('check pos cart, $callRequest');
      if (callRequest.isNotEmpty) {
        setState(() {
          tempPosCart = callRequest;
        });
      }
    } catch (error) {
      print('error call data pos cart, $error');
    }
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
        onCheckNewOrder();
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
    //print('temp served, ${tempPosServed}');
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

  onPrintChecker(bool reprint) async {
    dynamic docPrint = await printChecker(
      cartSelected,
      AppState().configPrinter,
      AppState().configApplication,
      reprint ? 'reprint' : null,
    );

    print('print, $docPrint');

    final sendToPrinter.ToPrint request =
        sendToPrinter.ToPrint(doc: docPrint, ipAddress: '127.0.0.1');
    try {
      final callRespon = await sendToPrinter.request(requestQuery: request);
      print('call respon, ${callRespon}');
      if (callRespon != null) {
        // setState((){
        //   paymentStatus = true;
        //   invoice = callRespon;
        // });
      }
    } catch (error) {
      print('error pos invoice, ${error}');
      if (mounted) {
        alertError(context, error.toString());
      }
    }
  }

  onPrintCheckerBluetooth(bool reprint) async {
    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    if (connectionStatus) {
      bool result = false;
      List<int> ticket = await printCheckerBluetooth(
        cartSelected,
        AppState().configPrinter,
        AppState().configApplication,
        reprint ? 'reprint' : null,
      );
      result = await PrintBluetoothThermal.writeBytes(ticket);
      print('result print, $result');
    }
  }

  Future<List<int>> testTicket() async {
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    //bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.reset();

    // final ByteData data = await rootBundle.load('assets/mylogo.jpg');
    // final Uint8List bytesImg = data.buffer.asUint8List();
    // img.Image? image = img.decodeImage(bytesImg);

    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes +=
        generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left',
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.row([
      PosColumn(
        text: 'col5',
        width: 6,
        styles: const PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: 'col7',
        width: 6,
        styles: const PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);

    return bytes;
  }
  onCheckNewOrder() async {
  const Duration minOrderAge = Duration(minutes: 2);

  if (tempPosServed.isNotEmpty) {
    List<dynamic> temp = tempPosServed;
    temp.sort((a, b) => b['creation'].compareTo(a['creation']));
    final latestOrder = temp.isNotEmpty ? temp.first : null;

    if (latestOrder != null) {
      bool isNewOrder = lastOrderTimestamp == null ||
          DateTime.parse(latestOrder['creation'])
              .isAfter(lastOrderTimestamp!);
      bool isOlderThanMinAge = DateTime.now()
              .difference(DateTime.parse(latestOrder['creation'])) >=
          minOrderAge;

      if (isNewOrder &&
          (latestOrder['docstatus'] == 0) &&
          (isOlderThanMinAge == false)) {
        lastOrderTimestamp = DateTime.parse(latestOrder['creation']);
        onTapRefreshHistory();
        loadAndPlayAudio();

        // Tambahkan logika untuk mencetak
        try {
          // Pilih metode cetak berdasarkan kebutuhan
          // Menggunakan cetak Bluetooth
          //await onPrintCheckerBluetooth(false);

          // Jika ingin menggunakan metode cetak lain, gunakan berikut:
          // await onPrintChecker(false);

          print("Order printed successfully.");
        } catch (error) {
          print("Failed to print the order: $error");
        }
      }
    }
  }
}
loadAndPlayAudio() async {
    final audioSource =
        await soLoud.loadAsset('assets/audio/delivery_notif.mp3');
    final soundHandle = await soLoud.play(audioSource);
    print('Audio played');
  }

onLogOut(BuildContext context) async {
    // await myMe.removeStoredUser();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.loginScreen,
      (route) => false,
    );
  }
}
