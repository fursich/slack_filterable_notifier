require 'test_helper'

class DummyException < StandardError;end

module ExceptionNotifier
  class DummyNotifier
    def initialize(initial_options = {})
      @@initial_options = initial_options
    end

    def call(exception, options={})
    end

    def self.initial_options
      @@initial_options
    end
  end
end

class ExceptionNotifierTest < ActiveSupport::TestCase
  setup do
    @notifier_calls = 0
    @test_notifier = lambda { |exception, options| @notifier_calls += 1 }
  end

  teardown do
    ExceptionNotifier.error_grouping = false
    ExceptionNotifier.notification_trigger = nil
    ExceptionNotifier.class_eval("@@notifiers.delete_if { |k, _| k.to_s != \"email\"}")  # reset notifiers
  end

  test "should pass the options to notifiers" do
    ExceptionNotifier.register_exception_notifier(:dummy, {some_option: :value})
    assert_equal ExceptionNotifier.notifiers, [:dummy]
    assert_equal ExceptionNotifier::DummyNotifier.initial_options, {some_option: :value}
  end

  test "should pass deep nested options as they are" do
    ExceptionNotifier.register_exception_notifier(:dummy, {parent_option: {child_option: {grand_parent_option: :value}}})
    assert_equal ExceptionNotifier.notifiers, [:dummy]
    assert_equal ExceptionNotifier::DummyNotifier.initial_options, {parent_option: {child_option: {grand_parent_option: :value}}}
  end
end
