class CompassStreamer < BaseStreamer
  def __key__
    :compass
  end

  def on_init
    App.states[:location_manager].delegate = self
    if App.states[:location_manager].headingAvailable
      App.states[:location_manager].startUpdatingHeading
    end
  end

  def locationManager(_, didUpdateHeading: heading); update(heading.magneticHeading); end

  def jsonify(value)
    BW::JSON.generate({'magneticHeading' => value}) + "\n"
  end
end
