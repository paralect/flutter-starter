// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// /// Scaffold with bottom navigation bar that includes badge indicators.
// ///
// /// [ScaffoldWithNavBar] provides the main navigation structure with badges
// /// on the Gifts and Profile tabs to indicate pending requests that need attention.
// ///
// /// ## Badge Indicators
// /// - **Gifts Tab**: Shows red dot when there are pending split gift requests
// /// - **Profile Tab**: Shows red dot when there are pending contact requests
// ///
// /// The badges help users quickly identify when there are actions required
// /// in different sections of the app.
// class ScaffoldWithNavBar extends ConsumerWidget {
//   const ScaffoldWithNavBar({
//     super.key,
//     required this.navigationShell,
//     required this.pageName,
//   });

//   final StatefulNavigationShell navigationShell;
//   final String pageName;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final hasSplitGiftRequests = ref.watch(hasSplitGiftRequestsProvider);
//     final hasContactRequests = ref.watch(hasContactRequestsProvider);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: navigationShell,
//       bottomNavigationBar: BottomNavigationBar(
//         useLegacyColorScheme: false,
//         type: BottomNavigationBarType.fixed,
//         items: <BottomNavigationBarItem>[
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             label: 'Gifts',
//             icon: _buildIconWithBadge(
//               icon: Icons.card_giftcard,
//               showBadge: hasSplitGiftRequests,
//             ),
//           ),
//           const BottomNavigationBarItem(
//             label: 'Messages',
//             icon: Icon(Icons.message),
//           ),
//           BottomNavigationBarItem(
//             label: 'Profile',
//             icon: _buildIconWithBadge(
//               icon: Icons.account_circle,
//               showBadge: hasContactRequests,
//             ),
//           ),
//         ],
//         currentIndex: navigationShell.currentIndex,
//         onTap: (int index) => navigationShell.goBranch(
//           index,
//           initialLocation: index == navigationShell.currentIndex,
//         ),
//       ),
//     );
//   }

//   /// Builds an icon with an optional red badge indicator.
//   ///
//   /// When [showBadge] is true, displays a small red dot in the top-right
//   /// corner of the icon to indicate pending items that need attention.
//   Widget _buildIconWithBadge({
//     required IconData icon,
//     required bool showBadge,
//   }) {
//     if (!showBadge) {
//       return Icon(icon);
//     }

//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Icon(icon),
//         Positioned(
//           top: -2,
//           right: -2,
//           child: Container(
//             width: 8,
//             height: 8,
//             decoration: const BoxDecoration(
//               color: Colors.red,
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
