class MagnetometerStreamer < BaseStreamer
  def __key__
    :magnetometer
  end

  def on_init
    if App.states[:motion_manager].isMagnetometerAvailable
      handler = lambda { |data, error| update(data.magneticField) }
      App.states[:motion_manager].startMagnetometerUpdatesToQueue NSOperationQueue.mainQueue, withHandler: handler
    end
  end

  def jsonify(value)
    BW::JSON.generate({'magneticField' => {'x' => value.x, 'y' => value.y, 'z' => value.z}}) + "\n"
  end
end
