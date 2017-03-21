# Remoppy Examples
#
# # called when start up
# hello do
#   puts 'successfly connected'
# end
#
# # called when match message
# hear 'foo' do
#   puts 'foo'
# end
#
# hear '^hello, remoppy!' do |event|
#   logger.info 'received message!'
#   say 'hello!!', participation_id: event.participation
# end
