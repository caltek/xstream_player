import 'package:xstream_player/xstream_player.dart';

class BetterPlayerMockController extends BetterPlayerController {
  BetterPlayerMockController(
    BetterPlayerConfiguration betterPlayerConfiguration, {
    BetterPlayerPlaylistConfiguration betterPlayerPlaylistConfiguration =
        const BetterPlayerPlaylistConfiguration(),
  }) : super(betterPlayerConfiguration,
            betterPlayerPlaylistConfiguration:
                betterPlayerPlaylistConfiguration);
}
