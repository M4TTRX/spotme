// import 'package:flutter/material.dart';
// import 'package:home_workouts/service/service.dart';
// import 'package:home_workouts/views/shared/padding.dart';
// import 'package:home_workouts/views/shared/scroll_behavior.dart';
// import 'package:home_workouts/views/shared/text/headings.dart';
// import 'package:home_workouts/views/work_in_progress/wip_view.dart';

// class HomeView extends StatefulWidget {
//   HomeView({Key? key}) : super(key: key);
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   AppService service = AppService();

//   @override
//   Widget build(BuildContext context) {
//     return _buildHomeBody();
//   }

//   Widget _buildHomeBody() {
//     List<Widget> homeViewBody = [];
//     homeViewBody.add(
//       Padding(
//         padding: const EdgeInsets.only(top: 16.0),
//         child: Heading1(
//           "Exercises fo the day",
//           color: Colors.indigo,
//         ),
//       ),
//     );
//     homeViewBody.add(Divider(
//       thickness: 2,
//       height: 16,
//     ));
//     homeViewBody.add(Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       color: Colors.grey[200],
//       child: SizedBox(
//         height: 240,
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Body(
//                     "Here you will have an overview of what you gotta do based on your challenges"),
//               ),
//             ]),
//       ),
//     ));

//     // Acitivty of the day

//     homeViewBody.add(
//       Padding(
//         padding: const EdgeInsets.only(top: 16.0),
//         child: Heading1(
//           "Actvity Today",
//           color: Colors.indigo,
//         ),
//       ),
//     );
//     homeViewBody.add(Divider(
//       thickness: 2,
//       height: 16,
//     ));
//     homeViewBody.add(Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       color: Colors.grey[200],
//       child: SizedBox(
//         height: 240,
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Body(
//                     "Here you will see your activity and the one of your friends"),
//               ),
//             ]),
//       ),
//     ));

//     homeViewBody.add(
//       Padding(
//         padding: const EdgeInsets.only(top: 16.0),
//         child: Heading1(
//           "Tips",
//           color: Colors.indigo,
//         ),
//       ),
//     );
//     homeViewBody.add(Divider(
//       thickness: 2,
//       height: 16,
//     ));
//     homeViewBody.add(Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       color: Colors.grey[200],
//       child: SizedBox(
//         height: 240,
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Body("Btw press the + button to add activity"),
//               ),
//             ]),
//       ),
//     ));
//     homeViewBody.add(WorkInProgressView());
//     // Return in Listview
//     return ScrollConfiguration(
//       behavior: BasicScrollBehaviour(),
//       child: ListView(
//         padding: containerPadding,
//         children: homeViewBody,
//       ),
//     );
//   }
// }
