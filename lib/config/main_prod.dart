import '../main.dart';
import 'flavor_config.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.prod,
    baseUrl: "https://www.gidpower.com/api/",
  );
  mainDelegate();
}
