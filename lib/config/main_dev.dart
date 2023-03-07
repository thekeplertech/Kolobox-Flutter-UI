import '../main.dart';
import 'flavor_config.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.dev,
    baseUrl: "https://www.gidpower.com/api/",
  );
  mainDelegate();
}
