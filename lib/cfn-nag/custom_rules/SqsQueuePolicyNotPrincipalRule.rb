require 'cfn-nag/violation'
require_relative 'base'

class SqsQueuePolicyNotPrincipalRule < BaseRule

  def rule_text
    'SQS Queue policy should not allow Allow+NotPrincipal'
  end

  def rule_type
    Violation::FAILING_VIOLATION
  end

  def rule_id
    'F7'
  end

  def audit_impl(cfn_model)
    violating_policies = cfn_model.resources_by_type('AWS::SQS::QueuePolicy').select do |policy|
      !policy.policy_document.allows_not_principal.empty?
    end

    violating_policies.map { |policy| policy.logical_resource_id }
  end
end
