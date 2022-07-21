/// @func trace
/// @desc {void} enhanced debug printing
/// @arg {string} str
function trace(){
	// https://yal.cc/gamemaker-trace-function/
	if (TRACE_ALLOW){
		var _str = string(argument[0]);
		for (var i = 1; i < argument_count; i++) {
		    _str += "| " + string(argument[i]);
		}
		if (TRACE_WHOIS){
			_str += ", Obj/ID " + string(object_get_name(object_index)) + "/" + string(id);	
		}
		if (TRACE_NOTCH){
			_str = string_insert("   ",_str, 1);	
		}
		show_debug_message(_str);
	}
}