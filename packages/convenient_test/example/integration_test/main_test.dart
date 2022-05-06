import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:convenient_test_example/home_page.dart';
import 'package:convenient_test_example/main.dart' as app;
import 'package:convenient_test_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  convenientTestMain(MyConvenientTestSlot(), () {
    group('quickstart tests', () {
      tTestWidgets('choose some fruits', (t) async {
        await t.get(HomePageMark.fetchFruits).tap();
        await t.get(find.textContaining('HomePage')).should(findsOneWidget);
        await t.get(find.textContaining('You chose nothing')).should(findsOneWidget);

        await t.get(find.textContaining('Cherry')).tap();
        await t.get(find.textContaining('You chose: Cherry')).should(findsOneWidget);

        await t.tester.scrollUntilVisible(find.textContaining('Orange'), 100);
        await t.get(find.textContaining('Orange')).tap();
        await t.get(find.textContaining('You chose: Cherry, Orange')).should(findsOneWidget);

        await t.get(HomePageMark.fab).tap();
        await t.get(find.textContaining('HomePage')).should(findsNothing);
        await t.get(find.textContaining('SecondPage')).should(findsOneWidget);
        await t.get(find.textContaining('See fruits: Cherry, Orange')).should(findsOneWidget);

        await t.pageBack();
        await t.get(find.textContaining('HomePage')).should(findsOneWidget);
      });
    });

    // TODO
    // group('other tests', () {
    //   tTestWidgets('deliberately failing test', (t) async {
    //     expect(1, 0, reason: 'this expect should deliberately fail');
    //   });
    //
    //   tTestWidgets('deliberately flaky test', (t) async {
    //     final shouldFailThisTime = !_deliberatelyFlakyTestHasRun;
    //     _deliberatelyFlakyTestHasRun = true;
    //
    //     await t.get(HomePageMark.button).tap();
    //
    //     if (shouldFailThisTime) {
    //       await t.get(find.textContaining('NotExistString')).should(findsOneWidget);
    //     } else {
    //       await t.get(find.textContaining('1 tap')).should(findsOneWidget);
    //     }
    //   });
    //
    //   tTestWidgets('tap and assert text', (t) async {
    //     await t.get(find.textContaining('No tap')).should(findsOneWidget);
    //     await t.get(HomePageMark.button).tap();
    //     await t.get(find.textContaining('1 tap')).should(findsOneWidget);
    //     await t.get(HomePageMark.button).tap();
    //     await t.get(find.textContaining('2 taps')).should(findsOneWidget);
    //   });
    //
    //   tTestWidgets('locate an element deep in the tree', (t) async {
    //     await t.get(find.get([HomePageMark.row, HomePageMark.star]).last).tap();
    //
    //     await t.get(find.textContaining('Row 3 [Starred]')).should(findsOneWidget);
    //   });
    //
    //   tTestWidgets('navigation', (t) async {
    //     await t.visit('/second');
    //     await t.get(find.textContaining('I am home page')).should(findsNothing);
    //     await t.get(find.textContaining('I am second page')).should(findsOneWidget);
    //
    //     await t.pageBack();
    //     await t.get(find.textContaining('I am home page')).should(findsOneWidget);
    //     await t.get(find.textContaining('I am second page')).should(findsNothing);
    //   });
    //
    //   tTestWidgets('custom logging and snapshotting', (t) async {
    //     // suppose you do something normal...
    //     await t.get(find.textContaining('No tap')).should(findsOneWidget);
    //
    //     // then you want to log and snapshot
    //     final log = t.log('HELLO', 'Just a demonstration of custom logging');
    //     await log.snapshot();
    //   });
    //
    //   tTestWidgets('custom commands', (t) async {
    //     await t.myCustomCommand();
    //   });
    //
    //   tTestWidgets('sections', (t) async {
    //     t.section('sample section one');
    //
    //     // do something
    //     await t.get(find.textContaining('I am home page')).should(findsOneWidget);
    //
    //     t.section('sample section two');
    //
    //     // do something
    //     await t.get(find.textContaining('I am home page')).should(findsOneWidget);
    //   });
    //
    //   tTestWidgets('timer page', (t) async {
    //     await t.visit('/timer');
    //
    //     for (var iter = 0; iter < 5; ++iter) {
    //       final log = t.log('HELLO', 'Wait a second to have a look (#$iter)');
    //       await log.snapshot(name: 'before');
    //
    //       final stopwatch = Stopwatch()..start();
    //       while (stopwatch.elapsed < const Duration(seconds: 1)) {
    //         await t.tester.pump();
    //       }
    //
    //       await log.snapshot(name: 'after');
    //     }
    //
    //     await t.pageBack();
    //   });
    // group('sample sub-group', () {
    //   tTestWidgets('empty test', (t) async {});
    //
    //   group('sample sub-sub-group', () {
    //     tTestWidgets('another empty test', (t) async {});
    //   });
    // });
    // });
  });
}

var _deliberatelyFlakyTestHasRun = false;

class MyConvenientTestSlot extends ConvenientTestSlot {
  @override
  Future<void> appMain(AppMainExecuteMode mode) async => app.main();

  @override
  BuildContext? getNavContext(ConvenientTest t) => MyApp.navigatorKey.currentContext;
}

extension on ConvenientTest {
  Future<void> myCustomCommand() async {
    // Do anything you like... This is just a normal function
    debugPrint('Hello, world!');
  }
}
