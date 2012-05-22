# Copyright (c) 2012 by Tracelytics, Inc.
# All rights reserved.

module OboeFu
  module Inst
    module Rails3ActionController
      def process(*args)
        header = request.headers['X-Trace']
        Oboe::API.start_trace_with_target('rails', header, response.headers) do
          super
        end
      end

      def process_action(*args)
        opts = {
          :Controller => self.class.name,
          :Action => self.action_name,
        }

        Oboe::API.log('rails', 'info', opts)
        super
      end

      def render(*args)
        Oboe::API.trace('render', {}) do
          super
        end
      end
    end
  end
end

if defined?(ActionController::Base)
  if Rails::VERSION::MAJOR == 3
    class ActionController::Base
      include OboeFu::Inst::Rails3ActionController
    end
  elsif Rails::VERSION::MAJOR == 2
    ActionController::Base.class_eval do
      alias :perform_action_without_oboe :perform_action
      alias :rescue_action_without_oboe :rescue_action
      alias :process_without_oboe :process

      def process(*args)
        header = args[0].headers['X-Trace']
        Oboe::API.start_trace_with_target('rails', header, args[1].headers) do
          process_without_oboe(*args)
        end
      end

      def perform_action(*arguments)
        opts = {
            'Controller' => @_request.path_parameters['controller'],
            'Action' => @_request.path_parameters['action']
        }

        Oboe::API.log('rails', 'info', opts)
        perform_action_without_oboe(*arguments)
      end

      def rescue_action(exn)
        Oboe::API.log_exception('rails', exn)
        rescue_action_without_oboe(exn)
      end
    end
  end
end
