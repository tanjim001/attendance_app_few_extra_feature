
import 'package:attendanceapp/app/core/constant/string_const.dart';
import 'package:attendanceapp/app/core/utils/formatters/formatter.dart';
import 'package:attendanceapp/app/core/utils/local_storage/storage_utility.dart';
import 'package:attendanceapp/app/data/models/attendancerecord.dart';
import 'package:attendanceapp/app/data/models/datetime.dart';
import 'package:attendanceapp/app/data/service/api/locationtimecontroller.dart';
import 'package:attendanceapp/app/data/service/repository/authrepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AttendanceController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<AttendanceRecord> attendanceRecords = <AttendanceRecord>[].obs;
  final firebaseRepo = Get.put(FirebaseRepo());
  final timeController = Get.put(LocationTimeController());
  final box = LocalStorage();
  final Logger _logger = Logger();
  // final homeController = Get.put(HomeController());

  var isDataFetched = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocalAttendanceRecords();
  }

  Future<void> fetchAttendanceRecords() async {
    try {
      _logger.i("Fetching attendance records for user: ${firebaseRepo.currenuser!.uid}");
      QuerySnapshot querySnapshot = await _firestore
          .collection(StringConst.userdata)
          .doc(firebaseRepo.currenuser!.uid)
          .collection(StringConst.attendancerecord)
          .get();

      final List<AttendanceRecord> fetchedRecords = querySnapshot.docs
          .map((doc) =>
              AttendanceRecord.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
       
      _logger.d(
          "Fetched records: ${fetchedRecords.map((record) => record.checkIn).toList()}");
      attendanceRecords.assignAll(fetchedRecords);
      box.saveData(StringConst.attendancerecord, attendanceRecords.last);
      saveLocalAttendanceRecords(fetchedRecords);
      isDataFetched.value = true;
    } catch (e) {
      _logger.e("Failed to fetch attendance records: $e");
      Get.snackbar('Error', 'Failed to fetch attendance records: $e');
      isDataFetched.value =true;
    }
  }

  void saveLocalAttendanceRecords(List<AttendanceRecord> records) {
    try {
      _logger.i("Saving ${records.length} attendance records locally.");
      List<Map<String, dynamic>> jsonRecords =
          records.map((record) => record.toJson()).toList();
      box.saveData(StringConst.listofrec, jsonRecords);
    } catch (e) {
      _logger.e("Failed to save attendance records locally: $e");
    }
  }

  void loadLocalAttendanceRecords() async {
    try {
      _logger.i("Loading local attendance records.");
      List<dynamic> jsonRecords = box.readData(StringConst.listofrec) ?? [];
      if (jsonRecords.isEmpty) {
        _logger.i("No local records found, fetching from Firebase.");
        fetchAttendanceRecords();
      } else {
        final List<AttendanceRecord> localRecords =
            jsonRecords.map((json) => AttendanceRecord.fromJson(json)).toList();
        attendanceRecords.assignAll(localRecords);
        box.saveData(StringConst.attendancerecord, attendanceRecords.last);
        _logger.d(
            "Loaded records: ${localRecords.map((record) => record.checkIn).toList()}");
        isDataFetched.value = true;
      }
    } catch (e) {
      _logger.e("Failed to load local attendance records: $e");
      isDataFetched.value = false;
    }
  }

  void checkIn(Datetime checkInTime) async {
    try {
      _logger.i("Checking in at: $checkInTime");
      AttendanceRecord newRecord = AttendanceRecord(
          checkIn: checkInTime, checkOut: null, totalHours: '');

      box.saveData(StringConst.attendancerecord, newRecord);
      attendanceRecords.add(newRecord);
      attendanceRecords.refresh();
      saveLocalAttendanceRecords(attendanceRecords);
      
      await firebaseRepo.createSubCollection(
          StringConst.userdata,
          StringConst.attendancerecord,
          firebaseRepo.currenuser!.uid,
          checkInTime.date!.trim(),
          newRecord.toJson());
    } catch (e) {
      _logger.e("Failed to check in: $e");
      Get.snackbar('Error', 'Failed to check in: $e');
    }
  }

  void checkOut(Datetime checkOutTime, String totalHours) async {
    try {
      _logger.i("Checking out at: $checkOutTime");
      if (attendanceRecords.isNotEmpty) {
        AttendanceRecord latestRecord = attendanceRecords.last;
        _logger.d("latest record date ${latestRecord.checkOut!.date}");
        _logger.d("current date ${Formatter.formatDatetime(timeController.datetime.value!)}");
        if (latestRecord.checkIn!.date!.trim()==Formatter.formatDatetime(timeController.datetime.value!).trim()) {
          _logger.d("work started");
          latestRecord.checkOut = checkOutTime;
          latestRecord.totalHours = totalHours;
          attendanceRecords[attendanceRecords.length - 1] = latestRecord;
          box.saveData(StringConst.attendancerecord,latestRecord);
          saveLocalAttendanceRecords(attendanceRecords);
          await firebaseRepo.updateSubcollectionData(
              StringConst.userdata,
              firebaseRepo.currenuser!.uid,
              latestRecord.checkIn!.date!,
              StringConst.attendancerecord,
              latestRecord.toJson());
        } else {
          _logger.e("Already checked out.");
          Get.snackbar('Error', 'Already checked out.');
        }
      } else {
        _logger.e("No check-in record found.");
        Get.snackbar('Error', 'No check-in record found.');
      }
    } catch (e) {
      _logger.e("Failed to check out: $e");
      Get.snackbar('Error', 'Failed to check out: $e');
    }
  }

  AttendanceRecord? getLastAttendanceRecord() {
    
    return attendanceRecords.isNotEmpty ? attendanceRecords.last : null;
  }
}
