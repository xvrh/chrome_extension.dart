// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'extension_types.dart';

export 'chrome.dart';

extension JSChromeJSWebRequestExtension on JSChrome {
  @JS('webRequest')
  external JSWebRequest? get webRequestNullable;

  /// Use the `chrome.webRequest` API to observe and analyze traffic and to
  /// intercept, block, or modify requests in-flight.
  JSWebRequest get webRequest {
    var webRequestNullable = this.webRequestNullable;
    if (webRequestNullable == null) {
      throw ApiNotAvailableException('chrome.webRequest');
    }
    return webRequestNullable;
  }
}

@JS()
@staticInterop
class JSWebRequest {}

extension JSWebRequestExtension on JSWebRequest {
  /// Needs to be called when the behavior of the webRequest handlers has
  /// changed to prevent incorrect handling due to caching. This function call
  /// is expensive. Don't call it often.
  external void handlerBehaviorChanged(JSFunction? callback);

  /// Fired when a request is about to occur.
  external Event get onBeforeRequest;

  /// Fired before sending an HTTP request, once the request headers are
  /// available. This may occur after a TCP connection is made to the server,
  /// but before any HTTP data is sent.
  external Event get onBeforeSendHeaders;

  /// Fired just before a request is going to be sent to the server
  /// (modifications of previous onBeforeSendHeaders callbacks are visible by
  /// the time onSendHeaders is fired).
  external Event get onSendHeaders;

  /// Fired when HTTP response headers of a request have been received.
  external Event get onHeadersReceived;

  /// Fired when an authentication failure is received. The listener has three
  /// options: it can provide authentication credentials, it can cancel the
  /// request and display the error page, or it can take no action on the
  /// challenge. If bad user credentials are provided, this may be called
  /// multiple times for the same request. Note, only one of `'blocking'` or
  /// `'asyncBlocking'` modes must be specified in the `extraInfoSpec`
  /// parameter.
  external Event get onAuthRequired;

  /// Fired when the first byte of the response body is received. For HTTP
  /// requests, this means that the status line and response headers are
  /// available.
  external Event get onResponseStarted;

  /// Fired when a server-initiated redirect is about to occur.
  external Event get onBeforeRedirect;

  /// Fired when a request is completed.
  external Event get onCompleted;

  /// Fired when an error occurs.
  external Event get onErrorOccurred;

  /// Fired when an extension's proposed modification to a network request is
  /// ignored. This happens in case of conflicts with other extensions.
  external Event get onActionIgnored;

  /// The maximum number of times that `handlerBehaviorChanged` can be called
  /// per 10 minute sustained interval. `handlerBehaviorChanged` is an expensive
  /// function call that shouldn't be called often.
  external int get MAX_HANDLER_BEHAVIOR_CHANGED_CALLS_PER_10_MINUTES;
}

typedef ResourceType = String;

typedef OnBeforeRequestOptions = String;

typedef OnBeforeSendHeadersOptions = String;

typedef OnSendHeadersOptions = String;

typedef OnHeadersReceivedOptions = String;

typedef OnAuthRequiredOptions = String;

typedef OnResponseStartedOptions = String;

typedef OnBeforeRedirectOptions = String;

typedef OnCompletedOptions = String;

typedef OnErrorOccurredOptions = String;

typedef IgnoredActionType = String;

/// An array of HTTP headers. Each header is represented as a dictionary
/// containing the keys `name` and either `value` or `binaryValue`.
typedef HttpHeaders = JSArray;

@JS()
@staticInterop
@anonymous
class RequestFilter {
  external factory RequestFilter({
    /// A list of URLs or URL patterns. Requests that cannot match any of the URLs
    /// will be filtered out.
    JSArray urls,

    /// A list of request types. Requests that cannot match any of the types will
    /// be filtered out.
    JSArray? types,
    int? tabId,
    int? windowId,
  });
}

extension RequestFilterExtension on RequestFilter {
  /// A list of URLs or URL patterns. Requests that cannot match any of the URLs
  /// will be filtered out.
  external JSArray urls;

  /// A list of request types. Requests that cannot match any of the types will
  /// be filtered out.
  external JSArray? types;

  external int? tabId;

  external int? windowId;
}

@JS()
@staticInterop
@anonymous
class BlockingResponse {
  external factory BlockingResponse({
    /// If true, the request is cancelled. This prevents the request from being
    /// sent. This can be used as a response to the onBeforeRequest,
    /// onBeforeSendHeaders, onHeadersReceived and onAuthRequired events.
    bool? cancel,

    /// Only used as a response to the onBeforeRequest and onHeadersReceived
    /// events. If set, the original request is prevented from being
    /// sent/completed and is instead redirected to the given URL. Redirections to
    /// non-HTTP schemes such as `data:` are allowed. Redirects initiated by a
    /// redirect action use the original request method for the redirect, with one
    /// exception: If the redirect is initiated at the onHeadersReceived stage,
    /// then the redirect will be issued using the GET method. Redirects from URLs
    /// with `ws://` and `wss://` schemes are **ignored**.
    String? redirectUrl,

    /// Only used as a response to the onBeforeSendHeaders event. If set, the
    /// request is made with these request headers instead.
    HttpHeaders? requestHeaders,

    /// Only used as a response to the onHeadersReceived event. If set, the server
    /// is assumed to have responded with these response headers instead. Only
    /// return `responseHeaders` if you really want to modify the headers in order
    /// to limit the number of conflicts (only one extension may modify
    /// `responseHeaders` for each request).
    HttpHeaders? responseHeaders,

    /// Only used as a response to the onAuthRequired event. If set, the request
    /// is made using the supplied credentials.
    BlockingResponseAuthCredentials? authCredentials,
  });
}

extension BlockingResponseExtension on BlockingResponse {
  /// If true, the request is cancelled. This prevents the request from being
  /// sent. This can be used as a response to the onBeforeRequest,
  /// onBeforeSendHeaders, onHeadersReceived and onAuthRequired events.
  external bool? cancel;

  /// Only used as a response to the onBeforeRequest and onHeadersReceived
  /// events. If set, the original request is prevented from being
  /// sent/completed and is instead redirected to the given URL. Redirections to
  /// non-HTTP schemes such as `data:` are allowed. Redirects initiated by a
  /// redirect action use the original request method for the redirect, with one
  /// exception: If the redirect is initiated at the onHeadersReceived stage,
  /// then the redirect will be issued using the GET method. Redirects from URLs
  /// with `ws://` and `wss://` schemes are **ignored**.
  external String? redirectUrl;

  /// Only used as a response to the onBeforeSendHeaders event. If set, the
  /// request is made with these request headers instead.
  external HttpHeaders? requestHeaders;

  /// Only used as a response to the onHeadersReceived event. If set, the server
  /// is assumed to have responded with these response headers instead. Only
  /// return `responseHeaders` if you really want to modify the headers in order
  /// to limit the number of conflicts (only one extension may modify
  /// `responseHeaders` for each request).
  external HttpHeaders? responseHeaders;

  /// Only used as a response to the onAuthRequired event. If set, the request
  /// is made using the supplied credentials.
  external BlockingResponseAuthCredentials? authCredentials;
}

@JS()
@staticInterop
@anonymous
class UploadData {
  external factory UploadData({
    /// An ArrayBuffer with a copy of the data.
    JSAny? bytes,

    /// A string with the file's path and name.
    String? file,
  });
}

extension UploadDataExtension on UploadData {
  /// An ArrayBuffer with a copy of the data.
  external JSAny? bytes;

  /// A string with the file's path and name.
  external String? file;
}

@JS()
@staticInterop
@anonymous
class OnBeforeRequestDetails {
  external factory OnBeforeRequestDetails({
    /// The ID of the request. Request IDs are unique within a browser session. As
    /// a result, they could be used to relate different events of the same
    /// request.
    String requestId,
    String url,

    /// Standard HTTP method.
    String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
    /// not the ID of the outer frame. Frame IDs are unique within a tab.
    int frameId,

    /// ID of frame that wraps the frame which sent the request. Set to -1 if no
    /// parent frame exists.
    int parentFrameId,

    /// The UUID of the document making the request.
    String? documentId,

    /// The UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    DocumentLifecycle? documentLifecycle,

    /// The type of frame the request occurred in.
    FrameType? frameType,

    /// Contains the HTTP request body data. Only provided if extraInfoSpec
    /// contains 'requestBody'.
    OnBeforeRequestDetailsRequestBody? requestBody,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    int tabId,

    /// How the requested resource will be used.
    ResourceType type,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// The time when this signal is triggered, in milliseconds since the epoch.
    double timeStamp,
  });
}

extension OnBeforeRequestDetailsExtension on OnBeforeRequestDetails {
  /// The ID of the request. Request IDs are unique within a browser session. As
  /// a result, they could be used to relate different events of the same
  /// request.
  external String requestId;

  external String url;

  /// Standard HTTP method.
  external String method;

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
  /// not the ID of the outer frame. Frame IDs are unique within a tab.
  external int frameId;

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  external int parentFrameId;

  /// The UUID of the document making the request.
  external String? documentId;

  /// The UUID of the parent document owning this frame. This is not set if
  /// there is no parent.
  external String? parentDocumentId;

  /// The lifecycle the document is in.
  external DocumentLifecycle? documentLifecycle;

  /// The type of frame the request occurred in.
  external FrameType? frameType;

  /// Contains the HTTP request body data. Only provided if extraInfoSpec
  /// contains 'requestBody'.
  external OnBeforeRequestDetailsRequestBody? requestBody;

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  external int tabId;

  /// How the requested resource will be used.
  external ResourceType type;

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  external String? initiator;

  /// The time when this signal is triggered, in milliseconds since the epoch.
  external double timeStamp;
}

@JS()
@staticInterop
@anonymous
class OnBeforeSendHeadersDetails {
  external factory OnBeforeSendHeadersDetails({
    /// The ID of the request. Request IDs are unique within a browser session. As
    /// a result, they could be used to relate different events of the same
    /// request.
    String requestId,
    String url,

    /// Standard HTTP method.
    String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
    /// not the ID of the outer frame. Frame IDs are unique within a tab.
    int frameId,

    /// ID of frame that wraps the frame which sent the request. Set to -1 if no
    /// parent frame exists.
    int parentFrameId,

    /// The UUID of the document making the request.
    String documentId,

    /// The UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    DocumentLifecycle documentLifecycle,

    /// The type of frame the request occurred in.
    FrameType frameType,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    int tabId,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// How the requested resource will be used.
    ResourceType type,

    /// The time when this signal is triggered, in milliseconds since the epoch.
    double timeStamp,

    /// The HTTP request headers that are going to be sent out with this request.
    HttpHeaders? requestHeaders,
  });
}

extension OnBeforeSendHeadersDetailsExtension on OnBeforeSendHeadersDetails {
  /// The ID of the request. Request IDs are unique within a browser session. As
  /// a result, they could be used to relate different events of the same
  /// request.
  external String requestId;

  external String url;

  /// Standard HTTP method.
  external String method;

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
  /// not the ID of the outer frame. Frame IDs are unique within a tab.
  external int frameId;

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  external int parentFrameId;

  /// The UUID of the document making the request.
  external String documentId;

  /// The UUID of the parent document owning this frame. This is not set if
  /// there is no parent.
  external String? parentDocumentId;

  /// The lifecycle the document is in.
  external DocumentLifecycle documentLifecycle;

  /// The type of frame the request occurred in.
  external FrameType frameType;

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  external int tabId;

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  external String? initiator;

  /// How the requested resource will be used.
  external ResourceType type;

  /// The time when this signal is triggered, in milliseconds since the epoch.
  external double timeStamp;

  /// The HTTP request headers that are going to be sent out with this request.
  external HttpHeaders? requestHeaders;
}

@JS()
@staticInterop
@anonymous
class OnSendHeadersDetails {
  external factory OnSendHeadersDetails({
    /// The ID of the request. Request IDs are unique within a browser session. As
    /// a result, they could be used to relate different events of the same
    /// request.
    String requestId,
    String url,

    /// Standard HTTP method.
    String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
    /// not the ID of the outer frame. Frame IDs are unique within a tab.
    int frameId,

    /// ID of frame that wraps the frame which sent the request. Set to -1 if no
    /// parent frame exists.
    int parentFrameId,

    /// The UUID of the document making the request.
    String documentId,

    /// The UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    DocumentLifecycle documentLifecycle,

    /// The type of frame the request occurred in.
    FrameType frameType,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    int tabId,

    /// How the requested resource will be used.
    ResourceType type,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// The time when this signal is triggered, in milliseconds since the epoch.
    double timeStamp,

    /// The HTTP request headers that have been sent out with this request.
    HttpHeaders? requestHeaders,
  });
}

extension OnSendHeadersDetailsExtension on OnSendHeadersDetails {
  /// The ID of the request. Request IDs are unique within a browser session. As
  /// a result, they could be used to relate different events of the same
  /// request.
  external String requestId;

  external String url;

  /// Standard HTTP method.
  external String method;

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
  /// not the ID of the outer frame. Frame IDs are unique within a tab.
  external int frameId;

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  external int parentFrameId;

  /// The UUID of the document making the request.
  external String documentId;

  /// The UUID of the parent document owning this frame. This is not set if
  /// there is no parent.
  external String? parentDocumentId;

  /// The lifecycle the document is in.
  external DocumentLifecycle documentLifecycle;

  /// The type of frame the request occurred in.
  external FrameType frameType;

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  external int tabId;

  /// How the requested resource will be used.
  external ResourceType type;

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  external String? initiator;

  /// The time when this signal is triggered, in milliseconds since the epoch.
  external double timeStamp;

  /// The HTTP request headers that have been sent out with this request.
  external HttpHeaders? requestHeaders;
}

@JS()
@staticInterop
@anonymous
class OnHeadersReceivedDetails {
  external factory OnHeadersReceivedDetails({
    /// The ID of the request. Request IDs are unique within a browser session. As
    /// a result, they could be used to relate different events of the same
    /// request.
    String requestId,
    String url,

    /// Standard HTTP method.
    String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
    /// not the ID of the outer frame. Frame IDs are unique within a tab.
    int frameId,

    /// ID of frame that wraps the frame which sent the request. Set to -1 if no
    /// parent frame exists.
    int parentFrameId,

    /// The UUID of the document making the request.
    String documentId,

    /// The UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    DocumentLifecycle documentLifecycle,

    /// The type of frame the request occurred in.
    FrameType frameType,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    int tabId,

    /// How the requested resource will be used.
    ResourceType type,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// The time when this signal is triggered, in milliseconds since the epoch.
    double timeStamp,

    /// HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
    /// HTTP/0.9 responses (i.e., responses that lack a status line).
    String statusLine,

    /// The HTTP response headers that have been received with this response.
    HttpHeaders? responseHeaders,

    /// Standard HTTP status code returned by the server.
    int statusCode,
  });
}

extension OnHeadersReceivedDetailsExtension on OnHeadersReceivedDetails {
  /// The ID of the request. Request IDs are unique within a browser session. As
  /// a result, they could be used to relate different events of the same
  /// request.
  external String requestId;

  external String url;

  /// Standard HTTP method.
  external String method;

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
  /// not the ID of the outer frame. Frame IDs are unique within a tab.
  external int frameId;

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  external int parentFrameId;

  /// The UUID of the document making the request.
  external String documentId;

  /// The UUID of the parent document owning this frame. This is not set if
  /// there is no parent.
  external String? parentDocumentId;

  /// The lifecycle the document is in.
  external DocumentLifecycle documentLifecycle;

  /// The type of frame the request occurred in.
  external FrameType frameType;

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  external int tabId;

  /// How the requested resource will be used.
  external ResourceType type;

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  external String? initiator;

  /// The time when this signal is triggered, in milliseconds since the epoch.
  external double timeStamp;

  /// HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
  /// HTTP/0.9 responses (i.e., responses that lack a status line).
  external String statusLine;

  /// The HTTP response headers that have been received with this response.
  external HttpHeaders? responseHeaders;

  /// Standard HTTP status code returned by the server.
  external int statusCode;
}

@JS()
@staticInterop
@anonymous
class OnAuthRequiredDetails {
  external factory OnAuthRequiredDetails({
    /// The ID of the request. Request IDs are unique within a browser session. As
    /// a result, they could be used to relate different events of the same
    /// request.
    String requestId,
    String url,

    /// Standard HTTP method.
    String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
    /// not the ID of the outer frame. Frame IDs are unique within a tab.
    int frameId,

    /// ID of frame that wraps the frame which sent the request. Set to -1 if no
    /// parent frame exists.
    int parentFrameId,

    /// The UUID of the document making the request.
    String documentId,

    /// The UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    DocumentLifecycle documentLifecycle,

    /// The type of frame the request occurred in.
    FrameType frameType,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    int tabId,

    /// How the requested resource will be used.
    ResourceType type,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// The time when this signal is triggered, in milliseconds since the epoch.
    double timeStamp,

    /// The authentication scheme, e.g. Basic or Digest.
    String scheme,

    /// The authentication realm provided by the server, if there is one.
    String? realm,

    /// The server requesting authentication.
    OnAuthRequiredDetailsChallenger challenger,

    /// True for Proxy-Authenticate, false for WWW-Authenticate.
    bool isProxy,

    /// The HTTP response headers that were received along with this response.
    HttpHeaders? responseHeaders,

    /// HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
    /// HTTP/0.9 responses (i.e., responses that lack a status line) or an empty
    /// string if there are no headers.
    String statusLine,

    /// Standard HTTP status code returned by the server.
    int statusCode,
  });
}

extension OnAuthRequiredDetailsExtension on OnAuthRequiredDetails {
  /// The ID of the request. Request IDs are unique within a browser session. As
  /// a result, they could be used to relate different events of the same
  /// request.
  external String requestId;

  external String url;

  /// Standard HTTP method.
  external String method;

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
  /// not the ID of the outer frame. Frame IDs are unique within a tab.
  external int frameId;

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  external int parentFrameId;

  /// The UUID of the document making the request.
  external String documentId;

  /// The UUID of the parent document owning this frame. This is not set if
  /// there is no parent.
  external String? parentDocumentId;

  /// The lifecycle the document is in.
  external DocumentLifecycle documentLifecycle;

  /// The type of frame the request occurred in.
  external FrameType frameType;

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  external int tabId;

  /// How the requested resource will be used.
  external ResourceType type;

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  external String? initiator;

  /// The time when this signal is triggered, in milliseconds since the epoch.
  external double timeStamp;

  /// The authentication scheme, e.g. Basic or Digest.
  external String scheme;

  /// The authentication realm provided by the server, if there is one.
  external String? realm;

  /// The server requesting authentication.
  external OnAuthRequiredDetailsChallenger challenger;

  /// True for Proxy-Authenticate, false for WWW-Authenticate.
  external bool isProxy;

  /// The HTTP response headers that were received along with this response.
  external HttpHeaders? responseHeaders;

  /// HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
  /// HTTP/0.9 responses (i.e., responses that lack a status line) or an empty
  /// string if there are no headers.
  external String statusLine;

  /// Standard HTTP status code returned by the server.
  external int statusCode;
}

@JS()
@staticInterop
@anonymous
class OnResponseStartedDetails {
  external factory OnResponseStartedDetails({
    /// The ID of the request. Request IDs are unique within a browser session. As
    /// a result, they could be used to relate different events of the same
    /// request.
    String requestId,
    String url,

    /// Standard HTTP method.
    String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
    /// not the ID of the outer frame. Frame IDs are unique within a tab.
    int frameId,

    /// ID of frame that wraps the frame which sent the request. Set to -1 if no
    /// parent frame exists.
    int parentFrameId,

    /// The UUID of the document making the request.
    String documentId,

    /// The UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    DocumentLifecycle documentLifecycle,

    /// The type of frame the request occurred in.
    FrameType frameType,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    int tabId,

    /// How the requested resource will be used.
    ResourceType type,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// The time when this signal is triggered, in milliseconds since the epoch.
    double timeStamp,

    /// The server IP address that the request was actually sent to. Note that it
    /// may be a literal IPv6 address.
    String? ip,

    /// Indicates if this response was fetched from disk cache.
    bool fromCache,

    /// Standard HTTP status code returned by the server.
    int statusCode,

    /// The HTTP response headers that were received along with this response.
    HttpHeaders? responseHeaders,

    /// HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
    /// HTTP/0.9 responses (i.e., responses that lack a status line) or an empty
    /// string if there are no headers.
    String statusLine,
  });
}

extension OnResponseStartedDetailsExtension on OnResponseStartedDetails {
  /// The ID of the request. Request IDs are unique within a browser session. As
  /// a result, they could be used to relate different events of the same
  /// request.
  external String requestId;

  external String url;

  /// Standard HTTP method.
  external String method;

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
  /// not the ID of the outer frame. Frame IDs are unique within a tab.
  external int frameId;

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  external int parentFrameId;

  /// The UUID of the document making the request.
  external String documentId;

  /// The UUID of the parent document owning this frame. This is not set if
  /// there is no parent.
  external String? parentDocumentId;

  /// The lifecycle the document is in.
  external DocumentLifecycle documentLifecycle;

  /// The type of frame the request occurred in.
  external FrameType frameType;

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  external int tabId;

  /// How the requested resource will be used.
  external ResourceType type;

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  external String? initiator;

  /// The time when this signal is triggered, in milliseconds since the epoch.
  external double timeStamp;

  /// The server IP address that the request was actually sent to. Note that it
  /// may be a literal IPv6 address.
  external String? ip;

  /// Indicates if this response was fetched from disk cache.
  external bool fromCache;

  /// Standard HTTP status code returned by the server.
  external int statusCode;

  /// The HTTP response headers that were received along with this response.
  external HttpHeaders? responseHeaders;

  /// HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
  /// HTTP/0.9 responses (i.e., responses that lack a status line) or an empty
  /// string if there are no headers.
  external String statusLine;
}

@JS()
@staticInterop
@anonymous
class OnBeforeRedirectDetails {
  external factory OnBeforeRedirectDetails({
    /// The ID of the request. Request IDs are unique within a browser session. As
    /// a result, they could be used to relate different events of the same
    /// request.
    String requestId,
    String url,

    /// Standard HTTP method.
    String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
    /// not the ID of the outer frame. Frame IDs are unique within a tab.
    int frameId,

    /// ID of frame that wraps the frame which sent the request. Set to -1 if no
    /// parent frame exists.
    int parentFrameId,

    /// The UUID of the document making the request.
    String documentId,

    /// The UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    DocumentLifecycle documentLifecycle,

    /// The type of frame the request occurred in.
    FrameType frameType,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    int tabId,

    /// How the requested resource will be used.
    ResourceType type,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// The time when this signal is triggered, in milliseconds since the epoch.
    double timeStamp,

    /// The server IP address that the request was actually sent to. Note that it
    /// may be a literal IPv6 address.
    String? ip,

    /// Indicates if this response was fetched from disk cache.
    bool fromCache,

    /// Standard HTTP status code returned by the server.
    int statusCode,

    /// The new URL.
    String redirectUrl,

    /// The HTTP response headers that were received along with this redirect.
    HttpHeaders? responseHeaders,

    /// HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
    /// HTTP/0.9 responses (i.e., responses that lack a status line) or an empty
    /// string if there are no headers.
    String statusLine,
  });
}

extension OnBeforeRedirectDetailsExtension on OnBeforeRedirectDetails {
  /// The ID of the request. Request IDs are unique within a browser session. As
  /// a result, they could be used to relate different events of the same
  /// request.
  external String requestId;

  external String url;

  /// Standard HTTP method.
  external String method;

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
  /// not the ID of the outer frame. Frame IDs are unique within a tab.
  external int frameId;

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  external int parentFrameId;

  /// The UUID of the document making the request.
  external String documentId;

  /// The UUID of the parent document owning this frame. This is not set if
  /// there is no parent.
  external String? parentDocumentId;

  /// The lifecycle the document is in.
  external DocumentLifecycle documentLifecycle;

  /// The type of frame the request occurred in.
  external FrameType frameType;

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  external int tabId;

  /// How the requested resource will be used.
  external ResourceType type;

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  external String? initiator;

  /// The time when this signal is triggered, in milliseconds since the epoch.
  external double timeStamp;

  /// The server IP address that the request was actually sent to. Note that it
  /// may be a literal IPv6 address.
  external String? ip;

  /// Indicates if this response was fetched from disk cache.
  external bool fromCache;

  /// Standard HTTP status code returned by the server.
  external int statusCode;

  /// The new URL.
  external String redirectUrl;

  /// The HTTP response headers that were received along with this redirect.
  external HttpHeaders? responseHeaders;

  /// HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
  /// HTTP/0.9 responses (i.e., responses that lack a status line) or an empty
  /// string if there are no headers.
  external String statusLine;
}

@JS()
@staticInterop
@anonymous
class OnCompletedDetails {
  external factory OnCompletedDetails({
    /// The ID of the request. Request IDs are unique within a browser session. As
    /// a result, they could be used to relate different events of the same
    /// request.
    String requestId,
    String url,

    /// Standard HTTP method.
    String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
    /// not the ID of the outer frame. Frame IDs are unique within a tab.
    int frameId,

    /// ID of frame that wraps the frame which sent the request. Set to -1 if no
    /// parent frame exists.
    int parentFrameId,

    /// The UUID of the document making the request.
    String documentId,

    /// The UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    DocumentLifecycle documentLifecycle,

    /// The type of frame the request occurred in.
    FrameType frameType,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    int tabId,

    /// How the requested resource will be used.
    ResourceType type,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// The time when this signal is triggered, in milliseconds since the epoch.
    double timeStamp,

    /// The server IP address that the request was actually sent to. Note that it
    /// may be a literal IPv6 address.
    String? ip,

    /// Indicates if this response was fetched from disk cache.
    bool fromCache,

    /// Standard HTTP status code returned by the server.
    int statusCode,

    /// The HTTP response headers that were received along with this response.
    HttpHeaders? responseHeaders,

    /// HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
    /// HTTP/0.9 responses (i.e., responses that lack a status line) or an empty
    /// string if there are no headers.
    String statusLine,
  });
}

extension OnCompletedDetailsExtension on OnCompletedDetails {
  /// The ID of the request. Request IDs are unique within a browser session. As
  /// a result, they could be used to relate different events of the same
  /// request.
  external String requestId;

  external String url;

  /// Standard HTTP method.
  external String method;

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
  /// not the ID of the outer frame. Frame IDs are unique within a tab.
  external int frameId;

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  external int parentFrameId;

  /// The UUID of the document making the request.
  external String documentId;

  /// The UUID of the parent document owning this frame. This is not set if
  /// there is no parent.
  external String? parentDocumentId;

  /// The lifecycle the document is in.
  external DocumentLifecycle documentLifecycle;

  /// The type of frame the request occurred in.
  external FrameType frameType;

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  external int tabId;

  /// How the requested resource will be used.
  external ResourceType type;

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  external String? initiator;

  /// The time when this signal is triggered, in milliseconds since the epoch.
  external double timeStamp;

  /// The server IP address that the request was actually sent to. Note that it
  /// may be a literal IPv6 address.
  external String? ip;

  /// Indicates if this response was fetched from disk cache.
  external bool fromCache;

  /// Standard HTTP status code returned by the server.
  external int statusCode;

  /// The HTTP response headers that were received along with this response.
  external HttpHeaders? responseHeaders;

  /// HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
  /// HTTP/0.9 responses (i.e., responses that lack a status line) or an empty
  /// string if there are no headers.
  external String statusLine;
}

@JS()
@staticInterop
@anonymous
class OnErrorOccurredDetails {
  external factory OnErrorOccurredDetails({
    /// The ID of the request. Request IDs are unique within a browser session. As
    /// a result, they could be used to relate different events of the same
    /// request.
    String requestId,
    String url,

    /// Standard HTTP method.
    String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
    /// not the ID of the outer frame. Frame IDs are unique within a tab.
    int frameId,

    /// ID of frame that wraps the frame which sent the request. Set to -1 if no
    /// parent frame exists.
    int parentFrameId,

    /// The UUID of the document making the request. This value is not present if
    /// the request is a navigation of a frame.
    String documentId,

    /// The UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    DocumentLifecycle documentLifecycle,

    /// The type of frame the request occurred in.
    FrameType frameType,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    int tabId,

    /// How the requested resource will be used.
    ResourceType type,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// The time when this signal is triggered, in milliseconds since the epoch.
    double timeStamp,

    /// The server IP address that the request was actually sent to. Note that it
    /// may be a literal IPv6 address.
    String? ip,

    /// Indicates if this response was fetched from disk cache.
    bool fromCache,

    /// The error description. This string is _not_ guaranteed to remain backwards
    /// compatible between releases. You must not parse and act based upon its
    /// content.
    String error,
  });
}

extension OnErrorOccurredDetailsExtension on OnErrorOccurredDetails {
  /// The ID of the request. Request IDs are unique within a browser session. As
  /// a result, they could be used to relate different events of the same
  /// request.
  external String requestId;

  external String url;

  /// Standard HTTP method.
  external String method;

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId` indicates the ID of this frame,
  /// not the ID of the outer frame. Frame IDs are unique within a tab.
  external int frameId;

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  external int parentFrameId;

  /// The UUID of the document making the request. This value is not present if
  /// the request is a navigation of a frame.
  external String documentId;

  /// The UUID of the parent document owning this frame. This is not set if
  /// there is no parent.
  external String? parentDocumentId;

  /// The lifecycle the document is in.
  external DocumentLifecycle documentLifecycle;

  /// The type of frame the request occurred in.
  external FrameType frameType;

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  external int tabId;

  /// How the requested resource will be used.
  external ResourceType type;

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  external String? initiator;

  /// The time when this signal is triggered, in milliseconds since the epoch.
  external double timeStamp;

  /// The server IP address that the request was actually sent to. Note that it
  /// may be a literal IPv6 address.
  external String? ip;

  /// Indicates if this response was fetched from disk cache.
  external bool fromCache;

  /// The error description. This string is _not_ guaranteed to remain backwards
  /// compatible between releases. You must not parse and act based upon its
  /// content.
  external String error;
}

@JS()
@staticInterop
@anonymous
class OnActionIgnoredDetails {
  external factory OnActionIgnoredDetails({
    /// The ID of the request. Request IDs are unique within a browser session. As
    /// a result, they could be used to relate different events of the same
    /// request.
    String requestId,

    /// The proposed action which was ignored.
    IgnoredActionType action,
  });
}

extension OnActionIgnoredDetailsExtension on OnActionIgnoredDetails {
  /// The ID of the request. Request IDs are unique within a browser session. As
  /// a result, they could be used to relate different events of the same
  /// request.
  external String requestId;

  /// The proposed action which was ignored.
  external IgnoredActionType action;
}

@JS()
@staticInterop
@anonymous
class HttpHeadersItems {
  external factory HttpHeadersItems({
    /// Name of the HTTP header.
    String name,

    /// Value of the HTTP header if it can be represented by UTF-8.
    String? value,

    /// Value of the HTTP header if it cannot be represented by UTF-8, stored as
    /// individual byte values (0..255).
    JSArray? binaryValue,
  });
}

extension HttpHeadersItemsExtension on HttpHeadersItems {
  /// Name of the HTTP header.
  external String name;

  /// Value of the HTTP header if it can be represented by UTF-8.
  external String? value;

  /// Value of the HTTP header if it cannot be represented by UTF-8, stored as
  /// individual byte values (0..255).
  external JSArray? binaryValue;
}

@JS()
@staticInterop
@anonymous
class BlockingResponseAuthCredentials {
  external factory BlockingResponseAuthCredentials({
    String username,
    String password,
  });
}

extension BlockingResponseAuthCredentialsExtension
    on BlockingResponseAuthCredentials {
  external String username;

  external String password;
}

@JS()
@staticInterop
@anonymous
class OnBeforeRequestDetailsRequestBody {
  external factory OnBeforeRequestDetailsRequestBody({
    /// Errors when obtaining request body data.
    String? error,

    /// If the request method is POST and the body is a sequence of key-value
    /// pairs encoded in UTF8, encoded as either multipart/form-data, or
    /// application/x-www-form-urlencoded, this dictionary is present and for each
    /// key contains the list of all values for that key. If the data is of
    /// another media type, or if it is malformed, the dictionary is not present.
    /// An example value of this dictionary is {'key': ['value1', 'value2']}.
    JSAny? formData,

    /// If the request method is PUT or POST, and the body is not already parsed
    /// in formData, then the unparsed request body elements are contained in this
    /// array.
    JSArray? raw,
  });
}

extension OnBeforeRequestDetailsRequestBodyExtension
    on OnBeforeRequestDetailsRequestBody {
  /// Errors when obtaining request body data.
  external String? error;

  /// If the request method is POST and the body is a sequence of key-value
  /// pairs encoded in UTF8, encoded as either multipart/form-data, or
  /// application/x-www-form-urlencoded, this dictionary is present and for each
  /// key contains the list of all values for that key. If the data is of
  /// another media type, or if it is malformed, the dictionary is not present.
  /// An example value of this dictionary is {'key': ['value1', 'value2']}.
  external JSAny? formData;

  /// If the request method is PUT or POST, and the body is not already parsed
  /// in formData, then the unparsed request body elements are contained in this
  /// array.
  external JSArray? raw;
}

@JS()
@staticInterop
@anonymous
class OnAuthRequiredDetailsChallenger {
  external factory OnAuthRequiredDetailsChallenger({
    String host,
    int port,
  });
}

extension OnAuthRequiredDetailsChallengerExtension
    on OnAuthRequiredDetailsChallenger {
  external String host;

  external int port;
}
