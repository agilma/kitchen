import 'dart:convert';

// import 'package:bluetooth_print/bluetooth_print_model.dart';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
// import 'package:kontena_pos/core/functions/order.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
// import 'package:kontena_pos/core/functions/serve.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'models/cartitem.dart';

class AppState extends ChangeNotifier {
  static AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal();

  static void reset() {
    _instance = AppState._internal();
  }

  Future initializeState() async {
    prefs = await SharedPreferences.getInstance();

    _safeInit(() {
      if (prefs.containsKey('ff_configUser')) {
        try {
          _configUser = json.decode(prefs.getString('_configUser') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });

    _safeInit(() {
      if (prefs.containsKey('ff_configPrinter')) {
        try {
          _configPrinter = json.decode(prefs.getString('_configPrinter') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });

    _safeInit(() {
      if (prefs.containsKey('ff_selectedPrinter')) {
        try {
          _selectedPrinter =
              json.decode(prefs.getString('_selectedPrinter') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });

    _safeInit(() {
      if (prefs.containsKey('ff_sessionCashier')) {
        try {
          _sessionCashier =
              json.decode(prefs.getString('ff_sessionCashier') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });

    _safeInit(() {
      if (prefs.containsKey('ff_itemGroupSelected')) {
        try {
          _itemGroupSelected =
              json.decode(prefs.getString('ff_itemGroupSelected') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });

    _safeInit(() {
      if (prefs.containsKey('ff_dataCustomer')) {
        try {
          _dataCustomer = json.decode(prefs.getString('ff_dataCustomer') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });

    notifyListeners();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  double _totalPrice = 0.0;
  String _domain = 'https://erp2.hotelkontena.com';
  String get domain => _domain;
  double get totalPrice => _totalPrice;
  set domain(String _value) {
    _domain = _value;
    prefs.setString('ff_domain', _value);
  }

  void resetCart() {
    // _cartItems = [];
    _totalPrice = 0.0;
    notifyListeners();
  }

  List<dynamic> dataCompany = [];
  List<dynamic> dataPOSProfile = [];
  List<dynamic> dataItem = [];
  List<dynamic> dataItemGroup = [];
  List<dynamic> dataItemPrice = [];
  List<dynamic> dataItemAddon = [];
  List<dynamic> listPrinter = [];

  dynamic _configCompany;
  dynamic get configCompany => _configCompany;
  set configCompany(dynamic _value) {
    _configCompany = _value;
  }

  dynamic _configPosProfile;
  dynamic get configPosProfile => _configPosProfile;
  set configPosProfile(dynamic _value) {
    _configPosProfile = _value;
  }

  dynamic _configUser;
  dynamic get configUser => _configUser;
  set configUser(dynamic _value) {
    _configUser = _value;
    prefs.setString('ff_configUser', jsonEncode(_value));
  }

  dynamic _configPrinter;
  dynamic get configPrinter => _configPrinter;
  set configPrinter(dynamic _value) {
    _configPrinter = _value;

    PrintBluetoothThermal.connect(
        macPrinterAddress: _value['selectedMacAddPrinter']);
    prefs.setString('ff_configPrinter', jsonEncode(_value));
  }

  BluetoothInfo? _selectedPrinter;
  BluetoothInfo? get selectedPrinter => _selectedPrinter;
  set selectedPrinter(BluetoothInfo? _value) {
    _selectedPrinter = _value!;
    // prefs.setString('ff_selectedPrinter', jsonEncode(_value));
  }

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  dynamic _sessionCashier;
  dynamic get sessionCashier => _sessionCashier;
  set sessionCashier(dynamic _value) {
    _sessionCashier = _value;
    prefs.setString('ff_sessionCashier', jsonEncode(_value));
  }

  List<dynamic> _itemGroupSelected = [];
  List<dynamic> get itemGroupSelected => _itemGroupSelected;
  set itemGroupSelected(List<dynamic> _value) {
    _itemGroupSelected = _value;
    prefs.setString('ff_itemGroupSelected', jsonEncode(_value));
  }

  List<dynamic> _dataCustomer = [];
  List<dynamic> get dataCustomer => _dataCustomer;
  set dataCustomer(List<dynamic> _value) {
    _dataCustomer = _value;
    prefs.setString('ff_dataCustomer', jsonEncode(_value));
  }

  dynamic _customerSelected;
  dynamic get customerSelected => _customerSelected;
  set customerSelected(dynamic _value) {
    _customerSelected = _value;
  }

  @override
  notifyListeners();

  void setConnectionStatus(bool status) {
    _isConnected = status;
    notifyListeners();
  }

  // void clearPrinter() {
  //   _selectedPrinter = null;
  //   _isConnected = false;
  //   notifyListeners();
  // }

  String typeTransaction = '';
  String tableNumber = '';
  String setCookie = '';

}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}