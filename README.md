# PS3drome

A homebrew [Subsonic](https://www.subsonic.org/)/[Navidrome](https://www.navidrome.org/) music streaming client for the PlayStation 3, built with PSL1GHT.

Browse your self-hosted music library on the XMB, stream it to your PS3 over Wi-Fi, and let the server transcode everything into formats the console actually understands.

## Status

**Early development.** Nothing runs yet.

## How it works

PS3drome talks to any server implementing the [Subsonic API](http://www.subsonic.org/pages/api.jsp) (Navidrome, Airsonic, Gonic, original Subsonic, etc.) and requests server-side transcoding to MP3, so the PS3 doesn't need to decode formats it can't handle natively. The heavy lifting stays on the server.

### Features (planned)

- Browse by artist, album, genre, playlist, and favourites
- Search across the library
- Album art display
- Streaming playback with server-side transcoding (request MP3/AAC)
- Play queue with shuffle and repeat
- Scrobbling support (last.fm via Subsonic API)
- Configuration stored on HDD

## Requirements

- A PS3 running custom firmware (tested on Evilnat PEX)
- A Subsonic-compatible music server reachable from the PS3's network
- Server-side transcoding enabled (Navidrome does this out of the box)

## Building

Requires the [ps3toolchain](https://github.com/ps3dev/ps3toolchain) and [PSL1GHT](https://github.com/ps3dev/PSL1GHT).

```sh
export PS3DEV=/usr/local/ps3dev
export PSL1GHT=$PS3DEV
export PATH=$PS3DEV/bin:$PS3DEV/ppu/bin:$PS3DEV/spu/bin:$PATH

make
```

Produces `ps3drome.pkg` - install via Package Manager on your PS3.

## License

MIT
