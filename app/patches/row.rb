module Formotion
  class Row
    def on_switch(&block)
      self.object.on_switch(&block)
    end

    def on_slide(&block)
      self.object.on_slide(&block)
    end

    def on_input(&block)
      self.object.on_input(&block)
    end

    def on_end_input(&block)
      self.object.on_end_input(&block)
    end
  end
end
