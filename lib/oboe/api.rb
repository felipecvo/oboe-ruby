# Copyright (c) 2013 AppNeta, Inc.
# All rights reserved.

module Oboe
  module API
    def self.extend_with_tracing
      extend Oboe::API::Logging
      extend Oboe::API::Tracing
      extend Oboe::API::Profiling
      extend Oboe::API::LayerInit
    end
    extend Oboe::API::Util
  end
end
