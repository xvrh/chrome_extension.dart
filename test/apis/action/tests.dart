import 'package:checks/checks.dart';
import 'package:chrome_extension/action.dart';
import 'package:chrome_extension/tabs.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('title -- global', () async {
    var title = 'test title';
    var details = SetTitleDetails(title: title);
    await chrome.action.setTitle(details);
    var actual = await chrome.action.getTitle(TabDetails());
    check(actual).equals(title);

    var originalTitle = "chrome_ext.dart - test";
    var originalTitleDetails = SetTitleDetails(title: originalTitle);
    await chrome.action.setTitle(originalTitleDetails);
    actual = await chrome.action.getTitle(TabDetails());
    check(actual).equals(originalTitle);
  });

  test('title -- tab', () async {
    var title = 'test title';
    var tab = await chrome.tabs.create(CreateProperties());
    var details = SetTitleDetails(title: title, tabId: tab.id);

    await chrome.action.setTitle(details);
    var getTitleDetails = TabDetails(tabId: tab.id);
    await chrome.action.getTitle(getTitleDetails);
    var originalTitle = "chrome_ext.dart - test";
    var originalTitleDetails =
        SetTitleDetails(title: originalTitle, tabId: tab.id);
    await chrome.action.setTitle(originalTitleDetails);

    var getOriginalTitleDetails = TabDetails(tabId: tab.id);
    var actual = await chrome.action.getTitle(getOriginalTitleDetails);
    expect(actual, equals(originalTitle));
  });

  test('badge text -- global', () async {
    var badgeText = '9999';
    var details = SetBadgeTextDetails(text: badgeText);
    await chrome.action.setBadgeText(details);

    await _addSmallDelay();
    var getBadgedetails = TabDetails();
    var actual = await chrome.action.getBadgeText(getBadgedetails);
    check(actual).equals(badgeText);

    var clearBadgedetails = SetBadgeTextDetails(text: '');
    await chrome.action.setBadgeText(clearBadgedetails);
    await _addSmallDelay();
    actual = await chrome.action.getBadgeText(getBadgedetails);
    check(actual).equals('');
  });

  test('badge text -- tab', () async {
    var badgeText = '9999';
    var tab = await chrome.tabs.create(CreateProperties());

    var details = SetBadgeTextDetails(text: badgeText, tabId: tab.id);
    await chrome.action.setBadgeText(details);

    await _addSmallDelay();
    var getBadgeDetails = TabDetails(tabId: tab.id);
    var actual = await chrome.action.getBadgeText(getBadgeDetails);
    check(actual).equals(badgeText);

    var clearBadgedetails = SetBadgeTextDetails(text: '', tabId: tab.id);
    await chrome.action.setBadgeText(clearBadgedetails);

    await _addSmallDelay();
    actual = await chrome.action.getBadgeText(getBadgeDetails);
    check(actual).equals('');
  });

  test('badge background color -- global', () async {
    var colorList = [192, 134, 76, 255];
    var badgeColor = SetBadgeBackgroundColorDetails(color: colorList);
    var originalColor = SetBadgeBackgroundColorDetails(color: [0, 0, 0, 0]);

    await chrome.action.setBadgeBackgroundColor(badgeColor);
    var actual = await chrome.action.getBadgeBackgroundColor(TabDetails());
    check(actual[0]).equals(colorList[0]);
    check(actual[1]).equals(colorList[1]);
    check(actual[2]).equals(colorList[2]);
    check(actual[3]).equals(colorList[3]);

    await chrome.action.setBadgeBackgroundColor(originalColor);
    actual = await chrome.action.getBadgeBackgroundColor(TabDetails());
    check(actual[0]).equals(0);
    check(actual[1]).equals(0);
    check(actual[2]).equals(0);
    check(actual[3]).equals(0);
  });

  test('badge background color -- tab', () async {
    var tab = await chrome.tabs.create(CreateProperties());
    var colorList = [192, 134, 76, 255];
    var badgeColor =
        SetBadgeBackgroundColorDetails(color: colorList, tabId: tab.id);
    var originalColor =
        SetBadgeBackgroundColorDetails(color: [0, 0, 0, 0], tabId: tab.id);

    await chrome.action.setBadgeBackgroundColor(badgeColor);
    var actual =
        await chrome.action.getBadgeBackgroundColor(TabDetails(tabId: tab.id));
    check(actual).isNotNull();
    await chrome.action.setBadgeBackgroundColor(originalColor);
    actual =
        await chrome.action.getBadgeBackgroundColor(TabDetails(tabId: tab.id));
    check(actual[0]).equals(0);
    check(actual[1]).equals(0);
    check(actual[2]).equals(0);
    check(actual[3]).equals(0);
  });

  test('set icon image', () async {
    var osc = web.OffscreenCanvas(200, 200);
    var ctx = osc.getContext('2d')! as web.CanvasRenderingContext2D;
    ctx.fillRect(0, 0, 200, 200);
    var imageData = ctx.getImageData(0, 0, osc.width, osc.height);

    await chrome.action.setIcon(SetIconDetails(imageData: imageData));
  });

  test('set icon image map', () async {
    var osc = web.OffscreenCanvas(200, 200);
    var ctx = osc.getContext('2d')! as web.CanvasRenderingContext2D;
    ctx.fillRect(0, 0, 200, 200);
    var imageData = ctx.getImageData(0, 0, osc.width, osc.height);

    await chrome.action.setIcon(SetIconDetails(imageData: {200: imageData}));
  });

  test('popup -- global', () async {
    var popupFile = 'sample.html';
    var popupParams = SetPopupDetails(popup: popupFile);
    await chrome.action.setPopup(popupParams);
    var getPopupParams = TabDetails();
    var actual = await chrome.action.getPopup(getPopupParams);
    check(actual).endsWith(popupFile); // adds extension prefix

    var clearPopupParams = SetPopupDetails(popup: "");
    await chrome.action.setPopup(clearPopupParams);
    actual = await chrome.action.getPopup(getPopupParams);
    check(actual).equals('');
  });

  test('popup -- tab', () async {
    var popupFile = "sample.html";
    var tab = await chrome.tabs.create(CreateProperties());
    var popupParams = SetPopupDetails(popup: popupFile, tabId: tab.id);

    var clearPopupParams = SetPopupDetails(popup: "", tabId: tab.id);

    var getPopupParams = TabDetails(tabId: tab.id);

    await chrome.action.setPopup(popupParams);
    var actual = await chrome.action.getPopup(getPopupParams);
    check(actual).endsWith(popupFile); // adds extension prefix
    await chrome.action.setPopup(clearPopupParams);
    actual = await chrome.action.getPopup(getPopupParams);
    check(actual).equals('');
  });

  test('disable/enable -- global', () async {
    await chrome.action.disable(null);
    await chrome.action.enable(null);
    // TODO: need to figure out a way to check if this is working.
  });

  test('disable/enable -- tab', () async {
    var tab = await chrome.tabs.create(CreateProperties());
    await chrome.action.disable(tab.id);
    await chrome.action.enable(tab.id);
    // TODO: need to figure out a way to check if this is working.
  });

  test('onClicked', () async {
    await chrome.action.onClicked.first;
    // TODO: need to figure out a way to fire this event.
  }, skip: 'need to figure out a way to fire this event.');
}

Future<void> _addSmallDelay() async {
  // On some version of chrome we need a small delay between a "Set" and a "Get"
  await Future.delayed(const Duration(milliseconds: 100));
}
