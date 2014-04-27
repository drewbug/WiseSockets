module Formotion
  module RowType
    class NumberRow < StringRow
      def on_input(&block)
        self.row.text_field.on_change do |text_field|
          block.call text_field.text.to_f
        end
      end

      def on_end_input(&block)
        self.row.text_field.on_end do |text_field|
          block.call text_field.text.to_f
        end
      end
    end
  end
end
