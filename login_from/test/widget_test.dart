import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:login_system/main.dart';

void main() {
  // Setup mock SharedPreferences sebelum test
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('Login Page Widget Tests', () {
    testWidgets('Login page renders correctly', (WidgetTester tester) async {
      // Build our app
      await tester.pumpWidget(const MyApp());

      // Verify that login page is loaded
      expect(find.text('Login System'), findsOneWidget);
      expect(find.text('Masuk ke Akun Anda'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email & Password
      expect(find.text('MASUK'), findsOneWidget);
    });

    testWidgets('Email field validation', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find email field and enter invalid email
      final emailField = find.widgetWithText(TextFormField, 'Alamat Email');
      await tester.enterText(emailField, 'invalid-email');
      await tester.pump();

      // Try to submit form
      final loginButton = find.widgetWithText(ElevatedButton, 'MASUK');
      await tester.tap(loginButton);
      await tester.pump();

      // Should show validation error
      expect(find.text('Format email tidak valid'), findsOneWidget);
    });

    testWidgets('Password field validation', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find password field and enter short password
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      await tester.enterText(passwordField, '123');
      await tester.pump();

      // Try to submit form
      final loginButton = find.widgetWithText(ElevatedButton, 'MASUK');
      await tester.tap(loginButton);
      await tester.pump();

      // Should show validation error
      expect(find.text('Password minimal 6 karakter'), findsOneWidget);
    });

    testWidgets('Show/hide password toggle', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Initially password should be hidden
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      final passwordFieldWidget = tester.widget<TextFormField>(passwordField);
      expect(passwordFieldWidget.obscureText, isTrue);

      // Find and tap the visibility icon
      final visibilityIcon = find.byIcon(Icons.visibility_outlined);
      await tester.tap(visibilityIcon);
      await tester.pump();

      // Password should now be visible
      final updatedPasswordField = tester.widget<TextFormField>(passwordField);
      expect(updatedPasswordField.obscureText, isFalse);
    });

    testWidgets('Remember me checkbox works', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find checkbox
      final checkbox = find.byType(Checkbox);
      expect(checkbox, findsOneWidget);

      // Initially should be unchecked
      final checkboxWidget = tester.widget<Checkbox>(checkbox);
      expect(checkboxWidget.value, isFalse);

      // Tap checkbox
      await tester.tap(checkbox);
      await tester.pump();

      // Now should be checked
      final updatedCheckbox = tester.widget<Checkbox>(checkbox);
      expect(updatedCheckbox.value, isTrue);
    });

    testWidgets('Demo account buttons work', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find demo account chips
      expect(find.text('Admin Account'), findsOneWidget);
      expect(find.text('User Account'), findsOneWidget);
      expect(find.text('Demo Account'), findsOneWidget);

      // Tap Admin account chip
      final adminChip = find.text('Admin Account');
      await tester.tap(adminChip);
      await tester.pump();

      // Should fill email and password fields
      final emailField = find.widgetWithText(TextFormField, 'Alamat Email');
      final emailText = tester.widget<TextFormField>(emailField);
      expect(emailText.controller?.text, 'admin@company.com');
    });

    testWidgets('Login with valid credentials', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Enter valid credentials
      final emailField = find.widgetWithText(TextFormField, 'Alamat Email');
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      
      await tester.enterText(emailField, 'admin@company.com');
      await tester.enterText(passwordField, 'admin123');
      await tester.pump();

      // Tap login button
      final loginButton = find.widgetWithText(ElevatedButton, 'MASUK');
      await tester.tap(loginButton);
      await tester.pump();

      // Should show loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for login process
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should navigate to dashboard
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Welcome to Dashboard'), findsOneWidget);
    });

    testWidgets('Forgot password dialog', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Tap forgot password link
      final forgotPassword = find.text('Lupa Password?');
      await tester.tap(forgotPassword);
      await tester.pumpAndSettle();

      // Should show dialog
      expect(find.text('Lupa Password?'), findsOneWidget);
      expect(find.text('Masukkan email Anda'), findsOneWidget);
    });

    testWidgets('Social login buttons exist', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Should have Google and Microsoft login buttons
      expect(find.text('Google'), findsOneWidget);
      expect(find.text('Microsoft'), findsOneWidget);
    });

    testWidgets('Register link exists', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Should have register link
      expect(find.text('Belum punya akun?'), findsOneWidget);
      expect(find.text('Daftar sekarang'), findsOneWidget);
    });
  });

  group('Dashboard Widget Tests', () {
    testWidgets('Dashboard renders after login', (WidgetTester tester) async {
      // Create dashboard directly
      await tester.pumpWidget(MaterialApp(
        home: DashboardPage(
          email: 'test@example.com',
          role: 'Admin',
        ),
      ));

      // Verify dashboard elements
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.byIcon(Icons.account_circle), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Analytics'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Dashboard navigation works', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DashboardPage(
          email: 'test@example.com',
          role: 'Admin',
        ),
      ));

      // Tap Analytics tab
      final analyticsTab = find.text('Analytics');
      await tester.tap(analyticsTab);
      await tester.pumpAndSettle();

      // Should show Analytics page
      expect(find.text('Analytics Page'), findsOneWidget);

      // Tap Settings tab
      final settingsTab = find.text('Settings');
      await tester.tap(settingsTab);
      await tester.pumpAndSettle();

      // Should show Settings page
      expect(find.text('Settings Page'), findsOneWidget);
    });

    testWidgets('Drawer navigation works', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DashboardPage(
          email: 'test@example.com',
          role: 'Admin',
        ),
      ));

      // Open drawer
      final drawerButton = find.byTooltip('Open navigation menu');
      if (drawerButton.evaluate().isNotEmpty) {
        await tester.tap(drawerButton);
        await tester.pumpAndSettle();
      } else {
        // If app bar doesn't have drawer button, find drawer
        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        if (scaffold.drawer != null) {
          await tester.tap(find.byIcon(Icons.menu));
          await tester.pumpAndSettle();
        }
      }

      // Should have drawer items
      expect(find.text('Dashboard'), findsNWidgets(2));
      expect(find.text('Logout'), findsOneWidget);
    });

    testWidgets('Profile dialog shows user info', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DashboardPage(
          email: 'admin@company.com',
          role: 'Administrator',
        ),
      ));

      // Tap profile icon
      final profileIcon = find.byIcon(Icons.account_circle);
      await tester.tap(profileIcon);
      await tester.pumpAndSettle();

      // Should show profile dialog
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Email: admin@company.com'), findsOneWidget);
      expect(find.text('Role: Administrator'), findsOneWidget);
    });
  });

  group('Form Validation Tests', () {
    testWidgets('Empty email validation', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Leave email empty
      final emailField = find.widgetWithText(TextFormField, 'Alamat Email');
      await tester.enterText(emailField, '');
      await tester.pump();

      // Try to submit
      final loginButton = find.widgetWithText(ElevatedButton, 'MASUK');
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Email tidak boleh kosong'), findsOneWidget);
    });

    testWidgets('Empty password validation', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Leave password empty
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      await tester.enterText(passwordField, '');
      await tester.pump();

      // Try to submit
      final loginButton = find.widgetWithText(ElevatedButton, 'MASUK');
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Password tidak boleh kosong'), findsOneWidget);
    });

    testWidgets('Valid email format accepted', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Enter valid email
      final emailField = find.widgetWithText(TextFormField, 'Alamat Email');
      await tester.enterText(emailField, 'valid@example.com');
      await tester.pump();

      // Try to submit
      final loginButton = find.widgetWithText(ElevatedButton, 'MASUK');
      await tester.tap(loginButton);
      await tester.pump();

      // Should not show email error
      expect(find.text('Format email tidak valid'), findsNothing);
    });

    testWidgets('Valid password length accepted', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Enter valid password
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      await tester.enterText(passwordField, '123456');
      await tester.pump();

      // Try to submit
      final loginButton = find.widgetWithText(ElevatedButton, 'MASUK');
      await tester.tap(loginButton);
      await tester.pump();

      // Should not show password error
      expect(find.text('Password minimal 6 karakter'), findsNothing);
    });
  });

  group('UI Responsiveness Tests', () {
    testWidgets('Desktop layout on wide screen', (WidgetTester tester) async {
      // Set screen to desktop size
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Should show desktop layout features
      expect(find.text('Secure Login System'), findsOneWidget);
      expect(find.text('Platform login yang aman'), findsOneWidget);
    });

    testWidgets('Mobile layout on narrow screen', (WidgetTester tester) async {
      // Set screen to mobile size
      tester.view.physicalSize = const Size(375, 812); // iPhone X size
      tester.view.devicePixelRatio = 3.0;

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Should show mobile layout
      expect(find.text('Login System'), findsOneWidget);
      expect(find.text('Akses sistem dengan aman'), findsOneWidget);
    });
  });

  group('Error Handling Tests', () {
    testWidgets('Invalid credentials error', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Enter invalid credentials
      final emailField = find.widgetWithText(TextFormField, 'Alamat Email');
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      
      await tester.enterText(emailField, 'wrong@email.com');
      await tester.enterText(passwordField, 'wrongpass');
      await tester.pump();

      // Tap login button
      final loginButton = find.widgetWithText(ElevatedButton, 'MASUK');
      await tester.tap(loginButton);
      
      // Wait for error
      await tester.pump(const Duration(seconds: 3));

      // Should show error message
      expect(find.text('Email atau password salah'), findsOneWidget);
    });

    testWidgets('Clear fields button works', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Enter text in fields
      final emailField = find.widgetWithText(TextFormField, 'Alamat Email');
      await tester.enterText(emailField, 'test@example.com');
      await tester.pump();

      // Should show clear button
      expect(find.byIcon(Icons.clear), findsOneWidget);

      // Tap clear button
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      // Field should be empty
      final emailFieldWidget = tester.widget<TextFormField>(emailField);
      expect(emailFieldWidget.controller?.text, isEmpty);
    });
  });
}