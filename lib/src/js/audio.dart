// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

@JS()
library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSAudioExtension on JSChrome {
  @JS('audio')
  external JSAudio? get audioNullable;

  /// The `chrome.audio` API is provided to allow users to
  /// get information about and control the audio devices attached to the
  /// system.
  /// This API is currently only available in kiosk mode for ChromeOS.
  JSAudio get audio {
    var audioNullable = this.audioNullable;
    if (audioNullable == null) {
      throw ApiNotAvailableException('chrome.audio');
    }
    return audioNullable;
  }
}

extension type JSAudio._(JSObject _) {
  /// Gets a list of audio devices filtered based on |filter|.
  /// |filter|: Device properties by which to filter the list of returned
  ///     audio devices. If the filter is not set or set to `{}`,
  ///     returned device list will contain all available audio devices.
  /// |callback|: Reports the requested list of audio devices.
  external JSPromise getDevices(DeviceFilter? filter);

  /// Sets lists of active input and/or output devices.
  /// |ids|: Specifies IDs of devices that should be active. If either the
  ///     input or output list is not set, devices in that category are
  ///     unaffected.
  ///
  ///     It is an error to pass in a non-existent device ID.
  external JSPromise setActiveDevices(DeviceIdLists ids);

  /// Sets the properties for the input or output device.
  external JSPromise setProperties(
    String id,
    DeviceProperties properties,
  );

  /// Gets the system-wide mute state for the specified stream type.
  /// |streamType|: Stream type for which mute state should be fetched.
  /// |callback|: Callback reporting whether mute is set or not for specified
  /// stream type.
  external JSPromise getMute(StreamType streamType);

  /// Sets mute state for a stream type. The mute state will apply to all audio
  /// devices with the specified audio stream type.
  /// |streamType|: Stream type for which mute state should be set.
  /// |isMuted|: New mute value.
  external JSPromise setMute(
    StreamType streamType,
    bool isMuted,
  );

  /// Fired when sound level changes for an active audio device.
  external Event get onLevelChanged;

  /// Fired when the mute state of the audio input or output changes.
  /// Note that mute state is system-wide and the new value applies to every
  /// audio device with specified stream type.
  external Event get onMuteChanged;

  /// Fired when audio devices change, either new devices being added, or
  /// existing devices being removed.
  /// |devices|: List of all present audio devices after the change.
  external Event get onDeviceListChanged;
}

/// Type of stream an audio device provides.
typedef StreamType = String;

/// Available audio device types.
typedef DeviceType = String;
extension type AudioDeviceInfo._(JSObject _) implements JSObject {
  external factory AudioDeviceInfo({
    /// The unique identifier of the audio device.
    String id,

    /// Stream type associated with this device.
    StreamType streamType,

    /// Type of the device.
    DeviceType deviceType,

    /// The user-friendly name (e.g. "USB Microphone").
    String displayName,

    /// Device name.
    String deviceName,

    /// True if this is the current active device.
    bool isActive,

    /// The sound level of the device, volume for output, gain for input.
    int level,

    /// The stable/persisted device id string when available.
    String? stableDeviceId,
  });

  /// The unique identifier of the audio device.
  external String id;

  /// Stream type associated with this device.
  external StreamType streamType;

  /// Type of the device.
  external DeviceType deviceType;

  /// The user-friendly name (e.g. "USB Microphone").
  external String displayName;

  /// Device name.
  external String deviceName;

  /// True if this is the current active device.
  external bool isActive;

  /// The sound level of the device, volume for output, gain for input.
  external int level;

  /// The stable/persisted device id string when available.
  external String? stableDeviceId;
}
extension type DeviceFilter._(JSObject _) implements JSObject {
  external factory DeviceFilter({
    /// If set, only audio devices whose stream type is included in this list
    /// will satisfy the filter.
    JSArray? streamTypes,

    /// If set, only audio devices whose active state matches this value will
    /// satisfy the filter.
    bool? isActive,
  });

  /// If set, only audio devices whose stream type is included in this list
  /// will satisfy the filter.
  external JSArray? streamTypes;

  /// If set, only audio devices whose active state matches this value will
  /// satisfy the filter.
  external bool? isActive;
}
extension type DeviceProperties._(JSObject _) implements JSObject {
  external factory DeviceProperties(
      {
      ///
      ///   The audio device's desired sound level. Defaults to the device's
      ///   current sound level.
      ///
      /// If used with audio input device, represents audio device gain.
      /// If used with audio output device, represents audio device volume.
      int? level});

  ///
  ///   The audio device's desired sound level. Defaults to the device's
  ///   current sound level.
  ///
  /// If used with audio input device, represents audio device gain.
  /// If used with audio output device, represents audio device volume.
  external int? level;
}
extension type DeviceIdLists._(JSObject _) implements JSObject {
  external factory DeviceIdLists({
    /// List of input devices specified by their ID.
    /// To indicate input devices should be unaffected, leave this property
    ///   unset.
    JSArray? input,

    /// List of output devices specified by their ID.
    /// To indicate output devices should be unaffected, leave this property
    ///   unset.
    JSArray? output,
  });

  /// List of input devices specified by their ID.
  /// To indicate input devices should be unaffected, leave this property
  ///   unset.
  external JSArray? input;

  /// List of output devices specified by their ID.
  /// To indicate output devices should be unaffected, leave this property
  ///   unset.
  external JSArray? output;
}
extension type MuteChangedEvent._(JSObject _) implements JSObject {
  external factory MuteChangedEvent({
    /// The type of the stream for which the mute value changed. The updated mute
    /// value applies to all devices with this stream type.
    StreamType streamType,

    /// Whether or not the stream is now muted.
    bool isMuted,
  });

  /// The type of the stream for which the mute value changed. The updated mute
  /// value applies to all devices with this stream type.
  external StreamType streamType;

  /// Whether or not the stream is now muted.
  external bool isMuted;
}
extension type LevelChangedEvent._(JSObject _) implements JSObject {
  external factory LevelChangedEvent({
    /// ID of device whose sound level has changed.
    String deviceId,

    /// The device's new sound level.
    int level,
  });

  /// ID of device whose sound level has changed.
  external String deviceId;

  /// The device's new sound level.
  external int level;
}
