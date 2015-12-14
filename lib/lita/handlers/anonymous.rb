module Lita
  module Handlers
    class Anonymous < Handler
      route(/anonymous to #(\w*): (.*)/, command: true, help: { 'anonymous to #ROOM: YOUR_TEXT' => 'Send an anonymous message to a room' }) do |response|
        room_name = response.matches.flatten.first
        room = Lita::Room.find_by_name(room_name)
        response.reply("Could not find room ##{room_name} or I have not been added to ##{room_name}") and return unless room
        robot.send_message(Source.new(room: room), "From Anonymous: " + response.matches.flatten.last)
      end

      route(/anonymous to @(\w*): (.*)/, command: true) do |response|
        user_name = response.matches.flatten.first
        user = Lita::User.find_by_mention_name(user_name)
        response.reply("Could not find user @#{user_name}") and return unless user
        robot.send_message(Source.new(user: user), "From Anonymous: " + response.matches.flatten.last)
      end

      Lita.register_handler(self)
    end
  end
end
