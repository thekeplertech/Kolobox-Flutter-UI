import '../main.dart';
import 'flavor_config.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.prod,
    baseUrl: "https://api-staging.kolobox.ng/",
  );
  mainDelegate();
}
