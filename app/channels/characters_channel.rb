class CharactersChannel < ApplicationCable::Channel
  def follow
    stop_all_streams
    stream_from 'characters'
  end

  def unfollow
    stop_all_streams
  end
end
