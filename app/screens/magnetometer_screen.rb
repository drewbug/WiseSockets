class MagnetometerScreen < PM::FormotionScreen
  title "Magnetometer"

  def self.new(args = {})
    super.tap do |s|
      s.form.sections[0].rows[0].on_switch { |v| s.enabled_switched(v) }
      s.form.sections[1].rows[0].on_end_input { |v| s.port_input(v) }
      s.form.sections[1].rows[0].text_field.setUserInteractionEnabled(false) if App::Persistence[:magnetometer_enabled]
      App.states[:magnetometer_streamer].on_update do |field|
        s.form.sections[2].rows[0].value = field.x
        s.form.sections[2].rows[1].value = field.y
        s.form.sections[2].rows[2].value = field.z
      end
    end
  end

  def on_load
    set_attributes self.view, { background_color: hex_color("EFEFF4") }
  end

  def will_dismiss
    App.states[:magnetometer_streamer].stop_updates
  end

  def table_data
    hash = { sections: [] }

    hash[:sections][0] = { rows: [] }
    hash[:sections][0][:rows][0] = { title: 'Enabled?', key: :enabled, type: :switch, value: App::Persistence[:magnetometer_enabled] }

    hash[:sections][1] = { rows: [] }
    hash[:sections][1][:rows][0] = { title: 'TCP Port', key: :volume, type: :number, range: (0..1), value: App::Persistence[:magnetometer_port] }

    hash[:sections][2] = { rows: [] }
    hash[:sections][2][:rows][0] = { title: 'X', key: :field_x, type: :static }
    hash[:sections][2][:rows][1] = { title: 'Y', key: :field_y, type: :static }
    hash[:sections][2][:rows][2] = { title: 'Z', key: :field_z, type: :static }

    return hash
  end

  def enabled_switched(value)
    App.states[:magnetometer_streamer].enabled = value
    self.form.sections[1].rows[0].text_field.setUserInteractionEnabled !value
  end

  def port_input(value)
    App.states[:magnetometer_streamer].port = value.to_i unless value.to_i < 1024
    self.form.sections[1].rows[0].value = App.states[:magnetometer_streamer].port.to_s
  end
end
