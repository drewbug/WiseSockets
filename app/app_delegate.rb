class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    UI7Kit.patchIfNeeded
    initialize_storage
    initialize_sensors
    initialize_streamers
    open HomeScreen.new(nav_bar: true)
  end

  def initialize_storage
    {compass_enabled: false, compass_port: 5000,
     magnetometer_enabled: false, magnetometer_port: 5001,
     accelerometer_enabled: false, accelerometer_port: 5002}.each do |key, value|
      App::Persistence[key] = value if App::Persistence[key].nil?
    end
  end

  def initialize_sensors
    App.states[:motion_manager] = CMMotionManager.new
    App.states[:location_manager] = CLLocationManager.new
  end

  def initialize_streamers
    App.states[:compass_streamer] = CompassStreamer.new
    App.states[:magnetometer_streamer] = MagnetometerStreamer.new
    App.states[:accelerometer_streamer] = AccelerometerStreamer.new
  end
end
