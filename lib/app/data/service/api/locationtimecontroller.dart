import 'dart:async';
import 'dart:convert';
import 'package:attendanceapp/app/core/utils/constants/string_const.dart';
import 'package:attendanceapp/app/core/utils/formatters/formatter.dart';
import 'package:attendanceapp/app/core/utils/local_storage/storage_utility.dart';
import 'package:attendanceapp/app/data/models/datetime.dart';
import 'package:attendanceapp/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class LocationTimeController extends GetxController {
  final Rx<Datetime?> datetime = Datetime().obs;
  final RxBool isDataFetched = false.obs;
  Timer? _timer;
  final Logger logger = Logger();
  final LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    logger.d("Initializing LocationTimeController");
    _requestLocationPermissionAndFetchTime();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
    logger.d("LocationTimeController closed");
  }

  Future<void> _requestLocationPermissionAndFetchTime() async {
    final permission = await Permission.location.request();
    if (permission.isGranted) {
      logger.d("Location permission granted");
      await _fetchTimeFromAPI();
    } else {
      _handleError('Location permission denied');
    }
  }

  Future<void> _fetchTimeFromAPI() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      logger.d("Fetched current position: $position");

      final url = Uri.parse(
        "https://timeapi.io/api/Time/current/coordinate?latitude=${position.latitude}&longitude=${position.longitude}"
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        datetime.value = Datetime.fromJson(data);
        await localStorage.saveData(StringConst.date, Formatter.formatDatetime(datetime.value!));
        logger.d("Fetched time from API: $data");
        isDataFetched.value = true;
        logger.d("isDataFetched is set to true"); 
        if(localStorage.readData(StringConst.fasttimeloggedin)==null){Get.offAll(()=>const DataFetching());}
        _startTimer();
      } else {
        _handleError('Failed to get location time');
      }
    } catch (e) {
      _handleError('Error fetching time zone data: $e');
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (datetime.value != null) {
        final currentDateTime = DateTime(
          datetime.value!.year!,
          datetime.value!.month!,
          datetime.value!.day!,
          datetime.value!.hour!,
          datetime.value!.minute!,
          datetime.value!.seconds!,
          datetime.value!.milliSeconds!,
        ).add(const Duration(seconds: 1));

        datetime.update((val) {
          val!
            ..year = currentDateTime.year
            ..month = currentDateTime.month
            ..day = currentDateTime.day
            ..hour = currentDateTime.hour
            ..minute = currentDateTime.minute
            ..seconds = currentDateTime.second
            ..milliSeconds = currentDateTime.millisecond
            ..dateTime = currentDateTime.toIso8601String()
            ..date = "${currentDateTime.year}-${currentDateTime.month.toString().padLeft(2, '0')}-${currentDateTime.day.toString().padLeft(2, '0')}"
            ..time = "${currentDateTime.hour.toString().padLeft(2, '0')}:${currentDateTime.minute.toString().padLeft(2, '0')}:${currentDateTime.second.toString().padLeft(2, '0')}";
        });
        logger.d("Updated datetime: $currentDateTime");
      }
    });
  }

  void _handleError(String message) {
    logger.e(message);
    if (kDebugMode) {
      print(message);
    }
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }
}
