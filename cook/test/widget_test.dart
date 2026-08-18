// Widget tests for the Cook app.
//
// These tests cover the real app flow: splash → onboarding → location,
// including navigation timing and onboarding page transitions.

import 'package:cook/features/onboarding/pages/onboarding_page.dart';
import 'package:cook/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Convenience helper: find an [Image] widget loaded from a given asset path.
  Finder findImageByAsset(String assetName) {
    return find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName == assetName,
    );
  }

  group('SplashPage', () {
    testWidgets('displays logo and decorative background images', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(findImageByAsset('assets/images/logo.png'), findsOneWidget);
      expect(findImageByAsset('assets/images/circle-grey.png'), findsOneWidget);
      expect(findImageByAsset('assets/images/circle-orange.png'), findsOneWidget);

      // Drain the pending 3-second navigation timer so the test can dispose
      // cleanly without a "Timer is still pending" assertion failure.
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('navigates to OnboardingPage after 3 seconds', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Advance past the 3-second splash delay.
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Onboarding content is now visible.
      expect(find.text('All your favorites'), findsOneWidget);
      expect(find.text('NEXT'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
    });
  });

  group('OnboardingPage', () {
    testWidgets('shows first page with title, NEXT button, and Skip link', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingPage()));
      await tester.pumpAndSettle();

      expect(find.text('All your favorites'), findsOneWidget);
      expect(find.text('NEXT'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
    });

    testWidgets('advances through all pages with the NEXT button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingPage()));
      await tester.pumpAndSettle();

      // Page 1
      expect(find.text('All your favorites'), findsOneWidget);
      expect(find.text('NEXT'), findsOneWidget);

      // Page 2
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
      expect(find.text('Order from chosen chef'), findsOneWidget);
      expect(find.text('NEXT'), findsOneWidget);

      // Page 3 (last page — button changes to GET STARTED)
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
      expect(find.text('Free delivery offers'), findsOneWidget);
      expect(find.text('GET STARTED'), findsOneWidget);
    });

    testWidgets('Skip button navigates to the select-location page', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Skip the splash delay.
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Tap "Skip" on the onboarding page.
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      // Location screen is shown.
      expect(find.text('ACCESS LOCATION'), findsOneWidget);
    });
  });
}
