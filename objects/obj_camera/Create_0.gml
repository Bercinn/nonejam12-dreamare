scales = {
	cam: 3,
	win: 2,
	gui: 1
};

cam_w = display_get_width() / scales.cam;
cam_h = display_get_height() / scales.cam;

view_enabled = true;
view_visible[0] = true;
camera = view_camera[0];

camera_set_view_size(camera, cam_w, cam_h);
display_set_gui_size(cam_w * scales.gui, cam_h * scales.gui);
window_set_size(cam_w * scales.win, cam_h * scales.win);
window_center();
