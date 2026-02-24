persistent = true;

application_surface_draw_enable(false);

shader = shd_nightmare;

u_time = shader_get_uniform(shader, "u_time");
u_chroma = shader_get_uniform(shader, "u_chroma_intensity");
u_vignette = shader_get_uniform(shader, "u_vignette_amount");
u_filter = shader_get_uniform(shader, "u_filter_color");
