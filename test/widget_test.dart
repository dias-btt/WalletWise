import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_wise/app.dart';

void main() {
  testWidgets('App renders WalletWise title', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('WalletWise'), findsOneWidget);
  });
}
