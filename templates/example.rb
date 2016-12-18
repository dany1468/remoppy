# Remoppy Examples
#
# # called when start up
# hello do
#   puts 'successfly connected'
# end
#
#
# # called when match message
# hear 'foo' do
#   puts 'foo'
# end
#
#
# # use regexp in string literal
# hear 'bar (.*)' do |event|
#   puts event.matches[1] #=> Event#matches return MatchData object
# end
#
#
# # event object is slack event JSON (convert to Hashie::Mash)
# hear '^bar (.*)' do |event|
#   puts event.channel #=> channel id
#   say 'remoppy!', channel: event.channel #=> to received message channel
#   say 'remoppy!', channel: '#general'
#   say 'remoppy!', username: 'remoppy!', icon_emoji: ':remoppy:'
# end
#
#
# # use regexp literal
# hear /^foobar/ do
#   say 'remoppppy!'
# end
