module Formotion
  module RowType
    class SliderRow < Base
      def on_slide(&block)
        slideView = self.tableView.cellForRowAtIndexPath(self.row.index_path).accessoryView
        slideView.when(UIControlEventValueChanged) { block.call(slideView.value) }
      end
    end
  end
end
