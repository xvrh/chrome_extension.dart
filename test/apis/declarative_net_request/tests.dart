import 'package:checks/checks.dart';
import 'package:chrome_apis/declarative_net_request.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('updateDynamicRules', () async {
    await chrome.declarativeNetRequest
        .updateDynamicRules(UpdateRuleOptions(addRules: [
      Rule(
        id: 1,
        condition: RuleCondition(domains: ['google.com']),
        action: RuleAction(type: RuleActionType.allow),
      )
    ]));

    var rules = await chrome.declarativeNetRequest
        .getDynamicRules(GetRulesFilter(ruleIds: [1]));
    check(rules).length.equals(1);
    var rule = rules.first;
    check(rule.id).equals(1);
    check(rule.condition.domains!).deepEquals(['google.com']);
    check(rule.action.type).equals(RuleActionType.allow);

    await chrome.declarativeNetRequest
        .updateDynamicRules(UpdateRuleOptions(removeRuleIds: [1]));
  });

  test('getAvailableStaticRuleCount', () async {
    var count =
        await chrome.declarativeNetRequest.getAvailableStaticRuleCount();
    check(count).isGreaterThan(0);
  });

  test('properties', () async {
    check(chrome.declarativeNetRequest.getmatchedrulesQuotaInterval)
        .isGreaterThan(0);
    check(chrome.declarativeNetRequest.guaranteedMinimumStaticRules)
        .isGreaterThan(0);
    check(chrome.declarativeNetRequest.maxGetmatchedrulesCallsPerInterval)
        .isGreaterThan(0);
    check(chrome.declarativeNetRequest.maxNumberOfDynamicAndSessionRules)
        .isGreaterThan(0);
    check(chrome.declarativeNetRequest.maxNumberOfStaticRulesets)
        .isGreaterThan(0);
  });

  test('Rulesets', () async {
    await chrome.declarativeNetRequest
        .updateEnabledRulesets(UpdateRulesetOptions());
    var set = await chrome.declarativeNetRequest.getEnabledRulesets();
    check(set).isEmpty();
  });

  test('testMatchOutcome', () async {
    await chrome.declarativeNetRequest
        .updateDynamicRules(UpdateRuleOptions(addRules: [
      Rule(
        id: 1,
        condition: RuleCondition(
            urlFilter: 'google.com', resourceTypes: [ResourceType.mainFrame]),
        action: RuleAction(type: RuleActionType.block),
      )
    ]));

    var result = await chrome.declarativeNetRequest.testMatchOutcome(
        TestMatchRequestDetails(
            url: 'https://google.com/index.html',
            type: ResourceType.mainFrame));
    check(result.matchedRules).length.equals(1);
    check(result.matchedRules.first.ruleId).equals(1);

    await chrome.declarativeNetRequest
        .updateDynamicRules(UpdateRuleOptions(removeRuleIds: [1]));
  });
}
