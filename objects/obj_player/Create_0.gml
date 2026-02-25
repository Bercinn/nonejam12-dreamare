// Movimento
hor_speed = 0;
ver_speed = 0;
move_speed = 4;
move_dir = 0;
moving = 0;

// Dash
dash_force = move_speed / 2;
dash_push_x = 0;
dash_push_y = 0;

dash_delay = game_get_speed(gamespeed_fps) * 0.5;
dash_timer = 0;

// Input
inputs = {};
mouse_dir = 0;
interact_delay = game_get_speed(gamespeed_fps) * 0.3
interact_timer = 0;

// Visuais
xscale = abs(image_xscale);
yscale = abs(image_yscale);
anim_yscale = yscale;
rotation = image_angle;
center_y = 0;

knockback_x = 0;
knockback_y = 0;

// Itens
item_held = undefined;
launch_force = 6;
