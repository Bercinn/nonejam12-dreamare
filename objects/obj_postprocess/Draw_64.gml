var _w = display_get_gui_width();
var _h = display_get_gui_height();

if(global.nightmare){
	shader_set(shader);
	shader_set_uniform_f(u_time, current_time / 1000);
	shader_set_uniform_f(u_chroma, 0.003);
	shader_set_uniform_f(u_vignette, 0.67);
	shader_set_uniform_f(u_filter, 1.25, 0.65, 0.6);

	draw_surface_stretched(application_surface, 0, 0, _w, _h);
	shader_reset();
}else{
	draw_surface_stretched(application_surface, 0, 0, _w, _h);
}
