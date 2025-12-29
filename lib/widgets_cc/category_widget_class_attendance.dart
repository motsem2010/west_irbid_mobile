// import 'package:eschool/eschool.dart';
// import 'package:flutter/material.dart';

// class CustomClassAttendance extends StatelessWidget {
//   final String? image;
//   final String? title;
//   final bool fitText;
//   final ClassAttendanceConfig? classAttendanceConfig;

//   final TextStyle textStyle = const TextStyle(
//       color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold);

//   const CustomClassAttendance(
//       {Key? key,
//       this.image,
//       this.title,
//       this.fitText = true,
//       this.classAttendanceConfig})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: SizedBox(
//         height: width / 3.2,
//         width: width / 2.6,
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.white,
//               // border: Border.all(width: 1, color: Colors.grey),
//               borderRadius: BorderRadius.all(Radius.circular(15)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.25),
//                   blurRadius: 10,
//                   spreadRadius: -5,
//                   blurStyle: BlurStyle.outer,
//                 )
//               ]),
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Colors.white,
//             ),
//             onPressed: () => Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => ClassAttendanceView(
//                       title: title,
//                       classAttendanceConfig: classAttendanceConfig,
//                     ))),
//             child: SizedBox(
//                 width: width / 2.4,
//                 child: Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       if (image!.substring(image!.length - 3, image!.length) !=
//                           'png')
//                         SvgPicture.asset(
//                           image!,
//                           color: Theme.of(context).primaryColor,
//                         )
//                       else
//                         Image.asset(
//                           image!,
//                           color: Theme.of(context).primaryColor,
//                           width: 35,
//                         ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       if (!fitText) getText(),
//                       if (fitText)
//                         FittedBox(
//                           child: getText(),
//                         ),
//                     ],
//                   ),
//                 )),
//           ),
//         ),
//       ),
//     );
//   }

//   Text getText() => Text(
//         title!,
//         style: TextStyle(color: Colors.black, fontSize: 16),
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         textAlign: TextAlign.center,
//       );
// }
