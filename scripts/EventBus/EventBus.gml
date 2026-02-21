function EventBus() constructor {
    listeners   = ds_map_create();
    event_queue = ds_queue_create();

    static subscribe = function (_event_type, _inst) {
        if (!instance_exists(_inst)) return;

        if (!ds_map_exists(listeners, _event_type)) {
            listeners[? _event_type] = ds_list_create();
        }

        var _list = listeners[? _event_type];

        if (ds_list_find_index(_list, _inst) == -1) {
            ds_list_add(_list, _inst);
        }
    };

    static unsubscribe = function (_event_type, _inst) {
        if (!ds_map_exists(listeners, _event_type)) return;

        var _list = listeners[? _event_type];
        var _i    = ds_list_find_index(_list, _inst);

        if (_i == -1) return;

        ds_list_delete(_list, _i);

        if (ds_list_size(_list) == 0) {
            ds_list_destroy(_list);
            ds_map_delete(listeners, _event_type);
        }
    };

    static publish = function (_event) {
        if (!is_struct(_event)) return;
        ds_queue_enqueue(event_queue, _event);
    };

    static dispatch = function (_event) {
        if (!is_struct(_event)) return;
        if (!variable_struct_exists(_event, "get_type")) return;

        var _type = _event.get_type();
        if (!ds_map_exists(listeners, _type)) return;

        var _list = listeners[? _type];
        var _i    = 0;

        while (_i < ds_list_size(_list)) {
            var _inst = _list[| _i];

            if (!instance_exists(_inst)) {
                ds_list_delete(_list, _i);
                continue;
            }

			var _method = "on_" + _type;
            if (variable_instance_exists(_inst, _method)) {
                with (_inst) {
                    method(other, variable_instance_get(id, _method))(_event);
                }
            }

            _i++;
        }

        if (ds_list_size(_list) == 0) {
            ds_list_destroy(_list);
            ds_map_delete(listeners, _type);
        }
    };

    static process = function (_max_events_per_frame = 100) {
        var _processed = 0;

        while (ds_queue_size(event_queue) > 0
        &&     _processed < _max_events_per_frame) {

            var _event = ds_queue_dequeue(event_queue);
            dispatch(_event);
            _processed++;
        }
    };

    static clear = function () {
        var _keys = ds_map_keys_to_array(listeners);

        for (var _i = 0; _i < array_length(_keys); _i++) {
            var _list = listeners[? _keys[_i]];
            ds_list_destroy(_list);
        }

        ds_map_clear(listeners);
        ds_queue_clear(event_queue);
		
		show_debug_message("limpo");
    };
	
    static dispose = function () {
        if (listeners != undefined) {
            clear();
            ds_map_destroy(listeners);
            listeners = undefined;
        }

        if (event_queue != undefined) {
            ds_queue_destroy(event_queue);
            event_queue = undefined;
        }
		
		show_debug_message("destruido");
    };
}
