import '../main.dart';
import 'flavor_config.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.prod,
    baseUrl: "https://api-staging.kolobox.ng/",
    payStackKey: 'pk_live_378b706593bd2d885b9bc12720740bb79d72de4d',
  );
  mainDelegate();
}
