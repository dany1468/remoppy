Remoppy.configure do |config|
  ## Remoppy Settings
  #
  # token:
  #   Remotty API Token
  #
  # config.token = ENV['REMOTTY_TOKEN']

  # scripts_path_dir:
  #   Remoppy scripts directory.
  #   Remoppy load scripts in this directory.
  #
  # config.scripts_dir_path = 'remoppy-scripts'

  # logger:
  #   Use logger object.
  #
  # config.logger = Logger.new(STDOUT)

  # logger.level:
  #   Specify logger level.
  #
  # config.logger.level = Logger::INFO

  # dsl:
  #   use dsl
  #
  #   param: :enabled or :disabled
  #
  # config.dsl = :enabled

  # stop_with_error:
  #   Select bot be stop when catch StandardError.
  #   If false, puts stack trace but be not stop when bot catch StandardError.
  #
  # config.stop_with_exception = true

  # channel:
  #   Channel, private group, or IM channel to send message to.
  #   Can be an encoded ID, or a name. See below for more details.
  #
  # config.robot.channel = nil
end
