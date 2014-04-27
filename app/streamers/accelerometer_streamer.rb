class AccelerometerStreamer < BaseStreamer
  def __key__
    :accelerometer
  end

  def on_init
    if App.states[:motion_manager].isAccelerometerAvailable
      handler = lambda { |data, error| update(data.acceleration) }
      App.states[:motion_manager].startAccelerometerUpdatesToQueue NSOperationQueue.mainQueue, withHandler: handler
    end
  end

  def jsonify(value)
    BW::JSON.generate({'acceleration' => {'x' => value.x, 'y' => value.y, 'z' => value.z}}) + "\n"
  end
end
