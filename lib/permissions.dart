// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/permissions.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _permissions = ChromePermissions._();

extension ChromePermissionsExtension on Chrome {
  /// Use the `chrome.permissions` API to request [declared optional
  /// permissions](/docs/extensions/develop/concepts/declare-permissions) at run
  /// time rather than install time, so users understand why the permissions are
  /// needed and grant only those that are necessary.
  ChromePermissions get permissions => _permissions;
}

class ChromePermissions {
  ChromePermissions._();

  bool get isAvailable => $js.chrome.permissionsNullable != null && alwaysTrue;

  /// Gets the extension's current set of permissions.
  Future<Permissions> getAll() async {
    var $res = await $js.chrome.permissions.getAll().toDart;
    return Permissions.fromJS($res);
  }

  /// Checks if the extension has the specified permissions.
  Future<bool> contains(Permissions permissions) async {
    var $res = await $js.chrome.permissions.contains(permissions.toJS).toDart;
    return $res.toDart;
  }

  /// Requests access to the specified permissions, displaying a prompt to the
  /// user if necessary. These permissions must either be defined in the
  /// `optional_permissions` field of the manifest or be required permissions
  /// that were withheld by the user. Paths on origin patterns will be ignored.
  /// You can request subsets of optional origin permissions; for example, if
  /// you specify `*://*/*` in the `optional_permissions` section of the
  /// manifest, you can request `http://example.com/`. If there are any problems
  /// requesting the permissions, the promise will be rejected.
  Future<bool> request(Permissions permissions) async {
    var $res = await $js.chrome.permissions.request(permissions.toJS).toDart;
    return $res.toDart;
  }

  /// Removes access to the specified permissions. If there are any problems
  /// removing the permissions, the promise will be rejected.
  Future<bool> remove(Permissions permissions) async {
    var $res = await $js.chrome.permissions.remove(permissions.toJS).toDart;
    return $res.toDart;
  }

  /// Adds a host access request. Request will only be signaled to the user if
  /// extension can be granted access to the host in the request. Request will
  /// be reset on cross-origin navigation. When accepted, grants persistent
  /// access to the site’s top origin
  Future<void> addHostAccessRequest(AddHostAccessRequestRequest request) async {
    await $js.chrome.permissions.addHostAccessRequest(request.toJS).toDart;
  }

  /// Removes a host access request, if existent.
  Future<void> removeHostAccessRequest(
      RemoveHostAccessRequestRequest request) async {
    await $js.chrome.permissions.removeHostAccessRequest(request.toJS).toDart;
  }

  /// Fired when the extension acquires new permissions.
  EventStream<Permissions> get onAdded => $js.chrome.permissions.onAdded
      .asStream(($c) => ($js.Permissions permissions) {
            return $c(Permissions.fromJS(permissions));
          }.toJS);

  /// Fired when access to permissions has been removed from the extension.
  EventStream<Permissions> get onRemoved => $js.chrome.permissions.onRemoved
      .asStream(($c) => ($js.Permissions permissions) {
            return $c(Permissions.fromJS(permissions));
          }.toJS);
}

class Permissions {
  Permissions.fromJS(this._wrapped);

  Permissions({
    /// List of named permissions (does not include hosts or origins).
    List<String>? permissions,

    /// The list of host permissions, including those specified in the
    /// `optional_permissions` or `permissions` keys in the manifest, and those
    /// associated with [Content
    /// Scripts](/docs/extensions/develop/concepts/content-scripts).
    List<String>? origins,
  }) : _wrapped = $js.Permissions(
          permissions: permissions?.toJSArray((e) => e.toJS),
          origins: origins?.toJSArray((e) => e.toJS),
        );

  final $js.Permissions _wrapped;

  $js.Permissions get toJS => _wrapped;

  /// List of named permissions (does not include hosts or origins).
  List<String>? get permissions => _wrapped.permissions?.toDart
      .cast<JSString>()
      .map((e) => e.toDart)
      .toList();

  set permissions(List<String>? v) {
    _wrapped.permissions = v?.toJSArray((e) => e.toJS);
  }

  /// The list of host permissions, including those specified in the
  /// `optional_permissions` or `permissions` keys in the manifest, and those
  /// associated with [Content
  /// Scripts](/docs/extensions/develop/concepts/content-scripts).
  List<String>? get origins =>
      _wrapped.origins?.toDart.cast<JSString>().map((e) => e.toDart).toList();

  set origins(List<String>? v) {
    _wrapped.origins = v?.toJSArray((e) => e.toJS);
  }
}

class AddHostAccessRequestRequest {
  AddHostAccessRequestRequest.fromJS(this._wrapped);

  AddHostAccessRequestRequest({
    /// The id of a document where host access requests can be shown. Must be
    /// the top-level document within a tab. If provided, the request is shown
    /// on the tab of the specified document and is removed when the document
    /// navigates to a new origin. Adding a new request will override any
    /// existent request for `tabId`. This or `tabId` must be specified.
    String? documentId,

    /// The id of the tab where host access requests can be shown. If provided,
    /// the request is shown on the specified tab and is removed when the tab
    /// navigates to a new origin. Adding a new request will override an
    /// existent request for `documentId`. This or `documentId` must be
    /// specified.
    double? tabId,

    /// The URL pattern where host access requests can be shown. If provided,
    /// host access requests will only be shown on URLs that match this pattern.
    String? pattern,
  }) : _wrapped = $js.AddHostAccessRequestRequest(
          documentId: documentId,
          tabId: tabId,
          pattern: pattern,
        );

  final $js.AddHostAccessRequestRequest _wrapped;

  $js.AddHostAccessRequestRequest get toJS => _wrapped;

  /// The id of a document where host access requests can be shown. Must be the
  /// top-level document within a tab. If provided, the request is shown on the
  /// tab of the specified document and is removed when the document navigates
  /// to a new origin. Adding a new request will override any existent request
  /// for `tabId`. This or `tabId` must be specified.
  String? get documentId => _wrapped.documentId;

  set documentId(String? v) {
    _wrapped.documentId = v;
  }

  /// The id of the tab where host access requests can be shown. If provided,
  /// the request is shown on the specified tab and is removed when the tab
  /// navigates to a new origin. Adding a new request will override an existent
  /// request for `documentId`. This or `documentId` must be specified.
  double? get tabId => _wrapped.tabId;

  set tabId(double? v) {
    _wrapped.tabId = v;
  }

  /// The URL pattern where host access requests can be shown. If provided, host
  /// access requests will only be shown on URLs that match this pattern.
  String? get pattern => _wrapped.pattern;

  set pattern(String? v) {
    _wrapped.pattern = v;
  }
}

class RemoveHostAccessRequestRequest {
  RemoveHostAccessRequestRequest.fromJS(this._wrapped);

  RemoveHostAccessRequestRequest({
    /// The id of a document where host access request will be removed. Must be
    /// the top-level document within a tab. This or `tabId` must be specified.
    String? documentId,

    /// The id of the tab where host access request will be removed. This or
    /// `documentId` must be specified.
    double? tabId,

    /// The URL pattern where host access request will be removed. If provided,
    /// this must exactly match the pattern of an existing host access request.
    String? pattern,
  }) : _wrapped = $js.RemoveHostAccessRequestRequest(
          documentId: documentId,
          tabId: tabId,
          pattern: pattern,
        );

  final $js.RemoveHostAccessRequestRequest _wrapped;

  $js.RemoveHostAccessRequestRequest get toJS => _wrapped;

  /// The id of a document where host access request will be removed. Must be
  /// the top-level document within a tab. This or `tabId` must be specified.
  String? get documentId => _wrapped.documentId;

  set documentId(String? v) {
    _wrapped.documentId = v;
  }

  /// The id of the tab where host access request will be removed. This or
  /// `documentId` must be specified.
  double? get tabId => _wrapped.tabId;

  set tabId(double? v) {
    _wrapped.tabId = v;
  }

  /// The URL pattern where host access request will be removed. If provided,
  /// this must exactly match the pattern of an existing host access request.
  String? get pattern => _wrapped.pattern;

  set pattern(String? v) {
    _wrapped.pattern = v;
  }
}
