module Formotion
  module RowType
    class SwitchRow < Base
      def on_switch(&block)
        switchView = self.tableView.cellForRowAtIndexPath(self.row.index_path).accessoryView
        switchView.when(UIControlEventValueChanged) { block.call(switchView.isOn) }
      end
    end
  end
end
