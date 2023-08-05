// ignore_for_file: unnecessary_parenthesis

library;

import 'src/internal_helpers.dart';
import 'src/js/audio.dart' as $js;

export 'src/chrome.dart' show chrome;

final _audio = ChromeAudio._();

extension ChromeAudioExtension on Chrome {
  /// The `chrome.audio` API is provided to allow users to
  /// get information about and control the audio devices attached to the
  /// system.
  /// This API is currently only available in kiosk mode for ChromeOS.
  ChromeAudio get audio => _audio;
}

class ChromeAudio {
  ChromeAudio._();

  bool get isAvailable => $js.chrome.audioNullable != null && alwaysTrue;

  /// Gets a list of audio devices filtered based on |filter|.
  /// |filter|: Device properties by which to filter the list of returned
  ///     audio devices. If the filter is not set or set to `{}`,
  ///     returned device list will contain all available audio devices.
  /// |callback|: Reports the requested list of audio devices.
  Future<List<AudioDeviceInfo>> getDevices(DeviceFilter? filter) {
    var $completer = Completer<List<AudioDeviceInfo>>();
    $js.chrome.audio.getDevices(
      filter?.toJS,
      (JSArray devices) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(devices.toDart
              .cast<$js.AudioDeviceInfo>()
              .map((e) => AudioDeviceInfo.fromJS(e))
              .toList());
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Sets lists of active input and/or output devices.
  /// |ids|: Specifies IDs of devices that should be active. If either the
  ///     input or output list is not set, devices in that category are
  ///     unaffected.
  ///
  ///     It is an error to pass in a non-existent device ID.
  Future<void> setActiveDevices(DeviceIdLists ids) {
    var $completer = Completer<void>();
    $js.chrome.audio.setActiveDevices(
      ids.toJS,
      () {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(null);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Sets the properties for the input or output device.
  Future<void> setProperties(
    String id,
    DeviceProperties properties,
  ) {
    var $completer = Completer<void>();
    $js.chrome.audio.setProperties(
      id,
      properties.toJS,
      () {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(null);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Gets the system-wide mute state for the specified stream type.
  /// |streamType|: Stream type for which mute state should be fetched.
  /// |callback|: Callback reporting whether mute is set or not for specified
  /// stream type.
  Future<bool> getMute(StreamType streamType) {
    var $completer = Completer<bool>();
    $js.chrome.audio.getMute(
      streamType.toJS,
      (bool value) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(value);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Sets mute state for a stream type. The mute state will apply to all audio
  /// devices with the specified audio stream type.
  /// |streamType|: Stream type for which mute state should be set.
  /// |isMuted|: New mute value.
  Future<void> setMute(
    StreamType streamType,
    bool isMuted,
  ) {
    var $completer = Completer<void>();
    $js.chrome.audio.setMute(
      streamType.toJS,
      isMuted,
      () {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(null);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Fired when sound level changes for an active audio device.
  EventStream<LevelChangedEvent> get onLevelChanged =>
      $js.chrome.audio.onLevelChanged
          .asStream(($c) => ($js.LevelChangedEvent event) {
                return $c(LevelChangedEvent.fromJS(event));
              });

  /// Fired when the mute state of the audio input or output changes.
  /// Note that mute state is system-wide and the new value applies to every
  /// audio device with specified stream type.
  EventStream<MuteChangedEvent> get onMuteChanged =>
      $js.chrome.audio.onMuteChanged
          .asStream(($c) => ($js.MuteChangedEvent event) {
                return $c(MuteChangedEvent.fromJS(event));
              });

  /// Fired when audio devices change, either new devices being added, or
  /// existing devices being removed.
  /// |devices|: List of all present audio devices after the change.
  EventStream<List<AudioDeviceInfo>> get onDeviceListChanged =>
      $js.chrome.audio.onDeviceListChanged.asStream(($c) => (JSArray devices) {
            return $c(devices.toDart
                .cast<$js.AudioDeviceInfo>()
                .map((e) => AudioDeviceInfo.fromJS(e))
                .toList());
          });
}

/// Type of stream an audio device provides.
enum StreamType {
  input('INPUT'),
  output('OUTPUT');

  const StreamType(this.value);

  final String value;

  String get toJS => value;
  static StreamType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Available audio device types.
enum DeviceType {
  headphone('HEADPHONE'),
  mic('MIC'),
  usb('USB'),
  bluetooth('BLUETOOTH'),
  hdmi('HDMI'),
  internalSpeaker('INTERNAL_SPEAKER'),
  internalMic('INTERNAL_MIC'),
  frontMic('FRONT_MIC'),
  rearMic('REAR_MIC'),
  keyboardMic('KEYBOARD_MIC'),
  hotword('HOTWORD'),
  lineout('LINEOUT'),
  postMixLoopback('POST_MIX_LOOPBACK'),
  postDspLoopback('POST_DSP_LOOPBACK'),
  alsaLoopback('ALSA_LOOPBACK'),
  other('OTHER');

  const DeviceType(this.value);

  final String value;

  String get toJS => value;
  static DeviceType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class AudioDeviceInfo {
  AudioDeviceInfo.fromJS(this._wrapped);

  AudioDeviceInfo({
    /// The unique identifier of the audio device.
    required String id,

    /// Stream type associated with this device.
    required StreamType streamType,

    /// Type of the device.
    required DeviceType deviceType,

    /// The user-friendly name (e.g. "USB Microphone").
    required String displayName,

    /// Device name.
    required String deviceName,

    /// True if this is the current active device.
    required bool isActive,

    /// The sound level of the device, volume for output, gain for input.
    required int level,

    /// The stable/persisted device id string when available.
    String? stableDeviceId,
  }) : _wrapped = $js.AudioDeviceInfo(
          id: id,
          streamType: streamType.toJS,
          deviceType: deviceType.toJS,
          displayName: displayName,
          deviceName: deviceName,
          isActive: isActive,
          level: level,
          stableDeviceId: stableDeviceId,
        );

  final $js.AudioDeviceInfo _wrapped;

  $js.AudioDeviceInfo get toJS => _wrapped;

  /// The unique identifier of the audio device.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// Stream type associated with this device.
  StreamType get streamType => StreamType.fromJS(_wrapped.streamType);
  set streamType(StreamType v) {
    _wrapped.streamType = v.toJS;
  }

  /// Type of the device.
  DeviceType get deviceType => DeviceType.fromJS(_wrapped.deviceType);
  set deviceType(DeviceType v) {
    _wrapped.deviceType = v.toJS;
  }

  /// The user-friendly name (e.g. "USB Microphone").
  String get displayName => _wrapped.displayName;
  set displayName(String v) {
    _wrapped.displayName = v;
  }

  /// Device name.
  String get deviceName => _wrapped.deviceName;
  set deviceName(String v) {
    _wrapped.deviceName = v;
  }

  /// True if this is the current active device.
  bool get isActive => _wrapped.isActive;
  set isActive(bool v) {
    _wrapped.isActive = v;
  }

  /// The sound level of the device, volume for output, gain for input.
  int get level => _wrapped.level;
  set level(int v) {
    _wrapped.level = v;
  }

  /// The stable/persisted device id string when available.
  String? get stableDeviceId => _wrapped.stableDeviceId;
  set stableDeviceId(String? v) {
    _wrapped.stableDeviceId = v;
  }
}

class DeviceFilter {
  DeviceFilter.fromJS(this._wrapped);

  DeviceFilter({
    /// If set, only audio devices whose stream type is included in this list
    /// will satisfy the filter.
    List<StreamType>? streamTypes,

    /// If set, only audio devices whose active state matches this value will
    /// satisfy the filter.
    bool? isActive,
  }) : _wrapped = $js.DeviceFilter(
          streamTypes: streamTypes?.toJSArray((e) => e.toJS),
          isActive: isActive,
        );

  final $js.DeviceFilter _wrapped;

  $js.DeviceFilter get toJS => _wrapped;

  /// If set, only audio devices whose stream type is included in this list
  /// will satisfy the filter.
  List<StreamType>? get streamTypes => _wrapped.streamTypes?.toDart
      .cast<$js.StreamType>()
      .map((e) => StreamType.fromJS(e))
      .toList();
  set streamTypes(List<StreamType>? v) {
    _wrapped.streamTypes = v?.toJSArray((e) => e.toJS);
  }

  /// If set, only audio devices whose active state matches this value will
  /// satisfy the filter.
  bool? get isActive => _wrapped.isActive;
  set isActive(bool? v) {
    _wrapped.isActive = v;
  }
}

class DeviceProperties {
  DeviceProperties.fromJS(this._wrapped);

  DeviceProperties(
      {
      ///
      ///   The audio device's desired sound level. Defaults to the device's
      ///   current sound level.
      ///
      /// If used with audio input device, represents audio device gain.
      /// If used with audio output device, represents audio device volume.
      int? level})
      : _wrapped = $js.DeviceProperties(level: level);

  final $js.DeviceProperties _wrapped;

  $js.DeviceProperties get toJS => _wrapped;

  ///
  ///   The audio device's desired sound level. Defaults to the device's
  ///   current sound level.
  ///
  /// If used with audio input device, represents audio device gain.
  /// If used with audio output device, represents audio device volume.
  int? get level => _wrapped.level;
  set level(int? v) {
    _wrapped.level = v;
  }
}

class DeviceIdLists {
  DeviceIdLists.fromJS(this._wrapped);

  DeviceIdLists({
    /// List of input devices specified by their ID.
    /// To indicate input devices should be unaffected, leave this property
    ///   unset.
    List<String>? input,

    /// List of output devices specified by their ID.
    /// To indicate output devices should be unaffected, leave this property
    ///   unset.
    List<String>? output,
  }) : _wrapped = $js.DeviceIdLists(
          input: input?.toJSArray((e) => e),
          output: output?.toJSArray((e) => e),
        );

  final $js.DeviceIdLists _wrapped;

  $js.DeviceIdLists get toJS => _wrapped;

  /// List of input devices specified by their ID.
  /// To indicate input devices should be unaffected, leave this property
  ///   unset.
  List<String>? get input =>
      _wrapped.input?.toDart.cast<String>().map((e) => e).toList();
  set input(List<String>? v) {
    _wrapped.input = v?.toJSArray((e) => e);
  }

  /// List of output devices specified by their ID.
  /// To indicate output devices should be unaffected, leave this property
  ///   unset.
  List<String>? get output =>
      _wrapped.output?.toDart.cast<String>().map((e) => e).toList();
  set output(List<String>? v) {
    _wrapped.output = v?.toJSArray((e) => e);
  }
}

class MuteChangedEvent {
  MuteChangedEvent.fromJS(this._wrapped);

  MuteChangedEvent({
    /// The type of the stream for which the mute value changed. The updated
    /// mute
    /// value applies to all devices with this stream type.
    required StreamType streamType,

    /// Whether or not the stream is now muted.
    required bool isMuted,
  }) : _wrapped = $js.MuteChangedEvent(
          streamType: streamType.toJS,
          isMuted: isMuted,
        );

  final $js.MuteChangedEvent _wrapped;

  $js.MuteChangedEvent get toJS => _wrapped;

  /// The type of the stream for which the mute value changed. The updated mute
  /// value applies to all devices with this stream type.
  StreamType get streamType => StreamType.fromJS(_wrapped.streamType);
  set streamType(StreamType v) {
    _wrapped.streamType = v.toJS;
  }

  /// Whether or not the stream is now muted.
  bool get isMuted => _wrapped.isMuted;
  set isMuted(bool v) {
    _wrapped.isMuted = v;
  }
}

class LevelChangedEvent {
  LevelChangedEvent.fromJS(this._wrapped);

  LevelChangedEvent({
    /// ID of device whose sound level has changed.
    required String deviceId,

    /// The device's new sound level.
    required int level,
  }) : _wrapped = $js.LevelChangedEvent(
          deviceId: deviceId,
          level: level,
        );

  final $js.LevelChangedEvent _wrapped;

  $js.LevelChangedEvent get toJS => _wrapped;

  /// ID of device whose sound level has changed.
  String get deviceId => _wrapped.deviceId;
  set deviceId(String v) {
    _wrapped.deviceId = v;
  }

  /// The device's new sound level.
  int get level => _wrapped.level;
  set level(int v) {
    _wrapped.level = v;
  }
}
