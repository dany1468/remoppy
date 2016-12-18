module Remoppy
  module DSL
    extend Forwardable

    def_delegators :Remoppy, :hello, :hear, :say, :start, :logger,
                   :schedule, :monitor, :goodnight, :respond
  end
end

extend Remoppy::DSL
