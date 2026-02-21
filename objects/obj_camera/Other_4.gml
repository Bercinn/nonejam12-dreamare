view_enabled = true;
view_visible[0] = true;
camera = view_camera[0];

camera_set_view_size(camera, cam_w, cam_h);
display_set_gui_size(cam_w * scales.gui, cam_h * scales.gui);
