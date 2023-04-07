import '../main.dart';
import 'flavor_config.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.dev,
    baseUrl: "https://api-staging.kolobox.ng/",
    payStackKey: 'pk_test_6ab4aa429d840baeec8966b61aadc1998595a81d',
  );
  mainDelegate();
}
