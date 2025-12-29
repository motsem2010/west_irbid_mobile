// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';

// // import 'package:ftpconnect/ftpconnect.dart';

// class FtpHelper {
//   static final FtpHelper _instance = FtpHelper._internal();

//   static FTPConnect ftpConnect = FTPConnect(
//     "ftp.stackcp.com",
//     port: 21,
//     user: "mts111@testcommerce.com",
//     pass: "motsem.2010",
//     timeout: 3600,
//     showLog: true,
//   );

//   factory FtpHelper() {
//     return _instance;
//   }

//   FtpHelper._internal() {
//     // connectToFTP();
//   }

//   Future<bool?> connectToFTP() async {
//     bool? isConnected = await ftpConnect.connect();
//     return isConnected;
//   }

//   Future<bool> uploadFile(
//       {required File fileToUpload,
//       required String directory,
//       String? remoteFileName,
//       Function(double, int, int)? onProgress}) async {
//     // await ftpConnect?.changeDirectory('/c1');
//     // if (ftpConnect?.connect())
//     await ftpConnect.connect();
//     String? currentPath = await ftpConnect.currentDirectory();
//     log(currentPath);
//     if (currentPath != directory) await ftpConnect.changeDirectory(directory);
//     ftpConnect.setTransferType(TransferType.auto);
//     bool? res = await ftpConnect.uploadFile(fileToUpload,
//         sRemoteName: remoteFileName ?? '', onProgress: onProgress
//         // (double progressInPercent, int totalReceived, int fileSize) {

//         // },
//         );
//     await ftpConnect.disconnect();
//     return res;
//   }

//   static Future<File?> downloadFiles(
//       String remoteFilePath, String localFileName) async {
//     File returnFile = File('C:\\s\\' + localFileName);
//     try {
//       await ftpConnect.connect();
//       await ftpConnect.downloadFile(remoteFilePath, returnFile);
//       await ftpConnect.disconnect();
//       return returnFile;
//     } catch (c) {
//       return null;
//     }
//   }

//   Future<void> closeConnection() async {
//     await ftpConnect.disconnect();
//     ;
//   }
// }
