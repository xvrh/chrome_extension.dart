// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSPermissionsExtension on JSChrome {
  @JS('permissions')
  external JSPermissions? get permissionsNullable;

  /// Use the `chrome.permissions` API to request [declared optional
  /// permissions](/docs/extensions/develop/concepts/declare-permissions) at run
  /// time rather than install time, so users understand why the permissions are
  /// needed and grant only those that are necessary.
  JSPermissions get permissions {
    var permissionsNullable = this.permissionsNullable;
    if (permissionsNullable == null) {
      throw ApiNotAvailableException('chrome.permissions');
    }
    return permissionsNullable;
  }
}

extension type JSPermissions._(JSObject _) {
  /// Gets the extension's current set of permissions.
  external JSPromise<Permissions> getAll();

  /// Checks if the extension has the specified permissions.
  external JSPromise<JSBoolean> contains(Permissions permissions);

  /// Requests access to the specified permissions, displaying a prompt to the
  /// user if necessary. These permissions must either be defined in the
  /// `optional_permissions` field of the manifest or be required permissions
  /// that were withheld by the user. Paths on origin patterns will be ignored.
  /// You can request subsets of optional origin permissions; for example, if
  /// you specify `*://*/*` in the `optional_permissions` section of the
  /// manifest, you can request `http://example.com/`. If there are any problems
  /// requesting the permissions, the promise will be rejected.
  external JSPromise<JSBoolean> request(Permissions permissions);

  /// Removes access to the specified permissions. If there are any problems
  /// removing the permissions, the promise will be rejected.
  external JSPromise<JSBoolean> remove(Permissions permissions);

  /// Adds a host access request. Request will only be signaled to the user if
  /// extension can be granted access to the host in the request. Request will
  /// be reset on cross-origin navigation. When accepted, grants persistent
  /// access to the site’s top origin
  external JSPromise addHostAccessRequest(AddHostAccessRequestRequest request);

  /// Removes a host access request, if existent.
  external JSPromise removeHostAccessRequest(
      RemoveHostAccessRequestRequest request);

  /// Fired when the extension acquires new permissions.
  external Event get onAdded;

  /// Fired when access to permissions has been removed from the extension.
  external Event get onRemoved;
}
extension type Permissions._(JSObject _) implements JSObject {
  external factory Permissions({
    /// List of named permissions (does not include hosts or origins).
    JSArray? permissions,

    /// The list of host permissions, including those specified in the
    /// `optional_permissions` or `permissions` keys in the manifest, and those
    /// associated with [Content
    /// Scripts](/docs/extensions/develop/concepts/content-scripts).
    JSArray? origins,
  });

  /// List of named permissions (does not include hosts or origins).
  external JSArray? permissions;

  /// The list of host permissions, including those specified in the
  /// `optional_permissions` or `permissions` keys in the manifest, and those
  /// associated with [Content
  /// Scripts](/docs/extensions/develop/concepts/content-scripts).
  external JSArray? origins;
}
extension type AddHostAccessRequestRequest._(JSObject _) implements JSObject {
  external factory AddHostAccessRequestRequest({
    /// The id of a document where host access requests can be shown. Must be the
    /// top-level document within a tab. If provided, the request is shown on the
    /// tab of the specified document and is removed when the document navigates
    /// to a new origin. Adding a new request will override any existent request
    /// for `tabId`. This or `tabId` must be specified.
    String? documentId,

    /// The id of the tab where host access requests can be shown. If provided,
    /// the request is shown on the specified tab and is removed when the tab
    /// navigates to a new origin. Adding a new request will override an existent
    /// request for `documentId`. This or `documentId` must be specified.
    double? tabId,

    /// The URL pattern where host access requests can be shown. If provided, host
    /// access requests will only be shown on URLs that match this pattern.
    String? pattern,
  });

  /// The id of a document where host access requests can be shown. Must be the
  /// top-level document within a tab. If provided, the request is shown on the
  /// tab of the specified document and is removed when the document navigates
  /// to a new origin. Adding a new request will override any existent request
  /// for `tabId`. This or `tabId` must be specified.
  external String? documentId;

  /// The id of the tab where host access requests can be shown. If provided,
  /// the request is shown on the specified tab and is removed when the tab
  /// navigates to a new origin. Adding a new request will override an existent
  /// request for `documentId`. This or `documentId` must be specified.
  external double? tabId;

  /// The URL pattern where host access requests can be shown. If provided, host
  /// access requests will only be shown on URLs that match this pattern.
  external String? pattern;
}
extension type RemoveHostAccessRequestRequest._(JSObject _)
    implements JSObject {
  external factory RemoveHostAccessRequestRequest({
    /// The id of a document where host access request will be removed. Must be
    /// the top-level document within a tab. This or `tabId` must be specified.
    String? documentId,

    /// The id of the tab where host access request will be removed. This or
    /// `documentId` must be specified.
    double? tabId,

    /// The URL pattern where host access request will be removed. If provided,
    /// this must exactly match the pattern of an existing host access request.
    String? pattern,
  });

  /// The id of a document where host access request will be removed. Must be
  /// the top-level document within a tab. This or `tabId` must be specified.
  external String? documentId;

  /// The id of the tab where host access request will be removed. This or
  /// `documentId` must be specified.
  external double? tabId;

  /// The URL pattern where host access request will be removed. If provided,
  /// this must exactly match the pattern of an existing host access request.
  external String? pattern;
}
