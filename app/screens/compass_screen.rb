class CompassScreen < PM::FormotionScreen
  title "Compass"

  def self.new(args = {})
    super.tap do |s|
      s.form.sections[0].rows[0].on_switch { |v| s.enabled_switched(v) }
      s.form.sections[1].rows[0].on_end_input { |v| s.port_input(v) }
      s.form.sections[1].rows[0].text_field.setUserInteractionEnabled(false) if App::Persistence[:compass_enabled]
      App.states[:compass_streamer].on_update do |heading|
        s.form.sections[2].rows[0].value = heading
      end
    end
  end

  def on_load
    set_attributes self.view, { background_color: hex_color("EFEFF4") }
  end

  def will_dismiss
    App.states[:compass_streamer].stop_updates
  end

  def table_data
    hash = { sections: [] }

    hash[:sections][0] = { rows: [] }
    hash[:sections][0][:rows][0] = { title: 'Enabled?', key: :enabled, type: :switch, value: App::Persistence[:compass_enabled] }

    hash[:sections][1] = { rows: [] }
    hash[:sections][1][:rows][0] = { title: 'TCP Port', key: :volume, type: :number, range: (0..1), value: App::Persistence[:compass_port] }

    hash[:sections][2] = { rows: [] }
    hash[:sections][2][:rows][0] = { title: 'Heading', key: :heading, type: :static, value: App.states[:location_manager].heading }

    return hash
  end

  def enabled_switched(value)
    App.states[:compass_streamer].enabled = value
    self.form.sections[1].rows[0].text_field.setUserInteractionEnabled !value
  end

  def port_input(value)
    App.states[:compass_streamer].port = value.to_i unless value.to_i < 1024
    self.form.sections[1].rows[0].value = App.states[:compass_streamer].port.to_s
  end
end
