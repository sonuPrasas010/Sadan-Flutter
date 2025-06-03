// import 'package:flutter/material.dart';

// class DropDown extends StatefulWidget {
//   final List<String> items;
//   const DropDown( this.items,{super.key});

//   @override
//   State<DropDown> createState() => _DropDownState();
// }

// class _DropDownState extends State<DropDown> {
 
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       // mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
       
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: Dimensions.screenwidth * 0.4,
//               color: AppColors.buttonBackgroundColor,
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton2(
//                   selectedItemHighlightColor: Colors.amber[50],
//                   hint: Row(
//                     children: const [
//                       Text(
//                         'select',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           // color: Colors.yellow,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                   items: widget.items
//                       .map((numbers) => DropdownMenuItem(
//                             value: "d",
//                             child: Text(
//                               numbers.toString(),
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ))
//                       .toList(),
//                   value: selectednumber,
//                   onChanged: (value) {
//                     setState(() {
//                       selectednumber = value as int;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             const Spacer(),
//             Container(
//               width: Dimensions.screenwidth * 0.5,
//               color: AppColors.buttonBackgroundColor,
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton2(
//                   // isExpanded: true,
//                   hint: Row(
//                     children: const [
//                       Text(
//                         'Select',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           // color: Colors.yellow,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                   items: duration
//                       .map((durations) => DropdownMenuItem<String>(
//                             value: durations,
//                             child: Text(
//                               durations,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ))
//                       .toList(),
//                   value: selectedDuration,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedDuration = value as String?;
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
