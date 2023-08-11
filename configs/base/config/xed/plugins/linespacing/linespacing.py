from gi.repository import GObject, Gtk, Xed

UI_XML = """<ui>
<menubar name="MenuBar">
    <menu name="ToolsMenu" action="Tools">
      <placeholder name="ToolsOps_3">
        <menuitem name="LineSpacingAction2" action="LineSpacingAction2"/>
        <menuitem name="LineSpacingAction1" action="LineSpacingAction1"/>
        <menuitem name="LineSpacingAction0" action="LineSpacingAction0"/>
      </placeholder>
    </menu>
</menubar>
</ui>"""

class LineSpacing(GObject.Object, Xed.WindowActivatable):
    __gtype_name__ = "LineSpacing"
    window = GObject.property(type=Xed.Window)
    __default_spacing = 5

    def __init__(self):
        GObject.Object.__init__(self)
            
    def _add_ui(self):
        manager = self.window.get_ui_manager()
        self._actions = Gtk.ActionGroup("LineSpacingActions")
        self._actions.add_actions([
            ('LineSpacingAction2', Gtk.STOCK_INFO, "Larger Line Spacing", 
                "<Control><Alt>9", "Larger Line Spacing", 
                self.on_linespacing_action_activate2),
            ('LineSpacingAction1', Gtk.STOCK_INFO, "Smaller Line Spacing", 
                "<Control><Alt>8", "Smaller Line spacing", 
                self.on_linespacing_action_activate1),
            ('LineSpacingAction0', Gtk.STOCK_INFO, "Reset Line Spacing", 
                "<Control><Alt>0", "Reset Line Spacing",
                self.on_linespacing_action_activate0),
        ])
        manager.insert_action_group(self._actions)
        self._ui_merge_id = manager.add_ui_from_string(UI_XML)
        manager.ensure_update()
        
    def set_line_height(self, height):
        view = self.window.get_active_view()
        if view:
            view.set_pixels_below_lines(height)
            view.set_pixels_inside_wrap(height)    

    def do_activate(self):
        self._add_ui()

    def do_deactivate(self):
        self._remove_ui()

    def do_update_state(self):
        self.set_line_height(self.__default_spacing)

    def on_linespacing_action_activate0(self, action, data=None):
        view = self.window.get_active_view()
        if view:
            view.set_pixels_below_lines(0)
            view.set_pixels_inside_wrap(0)

    def on_linespacing_action_activate1(self, action, data=None):
        view = self.window.get_active_view()
        if view:
            if view.get_pixels_below_lines() >= 0:
                view.set_pixels_below_lines(view.get_pixels_below_lines() - 1)
            if view.get_pixels_inside_wrap() >= 0:
                view.set_pixels_inside_wrap(view.get_pixels_inside_wrap() - 1)

    def on_linespacing_action_activate2(self, action, data=None):
        view = self.window.get_active_view()
        if view:
            view.set_pixels_below_lines(view.get_pixels_below_lines() + 1)
            view.set_pixels_inside_wrap(view.get_pixels_inside_wrap() + 1)

    def _remove_ui(self):
        manager = self.window.get_ui_manager()
        manager.remove_ui(self._ui_merge_id)
        manager.remove_action_group(self._actions)
        manager.ensure_update()
