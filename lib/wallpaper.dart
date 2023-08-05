// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'dart:typed_data';
import 'src/internal_helpers.dart';
import 'src/js/wallpaper.dart' as $js;

export 'src/chrome.dart' show chrome;

final _wallpaper = ChromeWallpaper._();

extension ChromeWallpaperExtension on Chrome {
  /// Use the `chrome.wallpaper` API to change the ChromeOS wallpaper.
  ChromeWallpaper get wallpaper => _wallpaper;
}

class ChromeWallpaper {
  ChromeWallpaper._();

  bool get isAvailable => $js.chrome.wallpaperNullable != null && alwaysTrue;

  /// Sets wallpaper to the image at _url_ or _wallpaperData_ with the specified
  /// _layout_
  Future<ByteBuffer?> setWallpaper(SetWallpaperDetails details) async {
    var $res = await promiseToFuture<JSArrayBuffer?>(
        $js.chrome.wallpaper.setWallpaper(details.toJS));
    return $res?.toDart;
  }
}

/// The supported wallpaper layouts.
enum WallpaperLayout {
  stretch('STRETCH'),
  center('CENTER'),
  centerCropped('CENTER_CROPPED');

  const WallpaperLayout(this.value);

  final String value;

  String get toJS => value;
  static WallpaperLayout fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class SetWallpaperDetails {
  SetWallpaperDetails.fromJS(this._wrapped);

  SetWallpaperDetails({
    /// The jpeg or png encoded wallpaper image as an ArrayBuffer.
    ByteBuffer? data,

    /// The URL of the wallpaper to be set (can be relative).
    String? url,

    /// The supported wallpaper layouts.
    required WallpaperLayout layout,

    /// The file name of the saved wallpaper.
    required String filename,

    /// True if a 128x60 thumbnail should be generated. Layout and ratio are not
    /// supported yet.
    bool? thumbnail,
  }) : _wrapped = $js.SetWallpaperDetails(
          data: data?.toJS,
          url: url,
          layout: layout.toJS,
          filename: filename,
          thumbnail: thumbnail,
        );

  final $js.SetWallpaperDetails _wrapped;

  $js.SetWallpaperDetails get toJS => _wrapped;

  /// The jpeg or png encoded wallpaper image as an ArrayBuffer.
  ByteBuffer? get data => _wrapped.data?.toDart;
  set data(ByteBuffer? v) {
    _wrapped.data = v?.toJS;
  }

  /// The URL of the wallpaper to be set (can be relative).
  String? get url => _wrapped.url;
  set url(String? v) {
    _wrapped.url = v;
  }

  /// The supported wallpaper layouts.
  WallpaperLayout get layout => WallpaperLayout.fromJS(_wrapped.layout);
  set layout(WallpaperLayout v) {
    _wrapped.layout = v.toJS;
  }

  /// The file name of the saved wallpaper.
  String get filename => _wrapped.filename;
  set filename(String v) {
    _wrapped.filename = v;
  }

  /// True if a 128x60 thumbnail should be generated. Layout and ratio are not
  /// supported yet.
  bool? get thumbnail => _wrapped.thumbnail;
  set thumbnail(bool? v) {
    _wrapped.thumbnail = v;
  }
}
