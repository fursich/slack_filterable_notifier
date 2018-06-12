module ExceptionNotifier
  class SlackFilterableNotifier < SlackNotifier
    include ExceptionNotifier::BacktraceCleaner

    # uniquely with slack notifier
    attr_accessor :skipped_exceptions, :simplified_exceptions, :color_for_simplified
    COLOR_FOR_SIMPIFIED_NOTIFICATION = 'good'

    def initialize(options)
      super
      @skipped_exceptions    = options[:skip_notifications_with]
      @simplified_exceptions = options[:simplify_notifications_with]
      @color_for_simplified  = options[:color_for_simplified_notifications] || COLOR_FOR_SIMPIFIED_NOTIFICATION
    end

    def call(exception, options={})
      return false if skipped_exceptions?(exception)

      if simplified_exceptions?(exception)
        clean_message = exception.message.gsub("`", "'")

        text          = simplified_headline(exception, options)
        fields        = [ { title: 'Exception', value: clean_message } ]
        fields.push({ title: 'Hostname', value: Socket.gethostname })
        attchs        = [color: @color_for_simplified, text: text, fields: fields, mrkdwn_in: %w(text fields)]

        if valid?
          send_notice(exception, options, clean_message, attachments: attchs) do |msg, message_opts|
            notifier.ping '', message_opts
          end
          return true
        else
          return false
        end
      end

      super
    end

    protected

    def simplified_headline(exception, options)
      errors_count = options[:accumulated_errors_count_for_simplified].to_i
      measure_word = errors_count > 1 ? errors_count : (exception.class.to_s =~ /^[aeiou]/i ? 'An' : 'A')
      exception_name = "*#{measure_word}* `#{exception.class.to_s}`"

      prefix = '[simplified report] '
      if options[:env].nil?
        text = prefix + "#{exception_name} *occured in background*\n"
      else
        env = options[:env]
        kontroller = env['action_controller.instance']
        request = "#{env['REQUEST_METHOD']} <#{env['REQUEST_URI']}>"
        text = prefix + "#{exception_name} *occurred while* `#{request}`"
        text += " *was processed by* `#{kontroller.controller_name}##{kontroller.action_name}`" if kontroller
        text += "\n"
      end
    end

    def skipped_exceptions?(exception)
      matches_with_exceptions?(exception, skipped_exceptions)
    end

    def simplified_exceptions?(exception)
      matches_with_exceptions?(exception, simplified_exceptions)
    end

    def matches_with_exceptions?(exception, target_exceptions)
      target_exceptions_array  = Array(target_exceptions).map(&:to_s)
      exception_ancestors = exception.class.ancestors.map(&:to_s)
      !(target_exceptions_array & exception_ancestors).empty?
    end
  end
end
