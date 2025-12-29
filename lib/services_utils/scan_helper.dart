import 'dart:io';

Future<String?> scanDocumentSave() async {
  try {
    // Define the path where the scanned file will be saved
    String outputFilePath = 'C:/scan_file/scanned_image.jpeg';

    // Run the scanimage command
    ProcessResult result = await Process.run(
      'scanimage',
      [
        '--format=jpeg', // Output format (PNM is a simple format)
        '--output-file=$outputFilePath', // Output file path
      ],
    );

    // Check if the command was successful
    if (result.exitCode == 0) {
      print('Scan successful. File saved at: $outputFilePath');
      return outputFilePath;
    } else {
      print('Scan failed. Error: ${result.stderr}');
      return null;
    }
  } catch (e) {
    print('Error during scanning: $e');
    return null;
  }
}

// void main() async {
//   String? filePath = await scanDocument();
//   if (filePath != null) {
//     print('Scanned file path: $filePath');
//   } else {
//     print('Failed to scan document.');
//   }
// }
