/// @description range_convert(minrange1,maxrange1,minrange2,maxrange2,value_from_range1)
/// @function range_convert
/// @param minrange1
/// @param maxrange1
/// @param minrange2
/// @param maxrange2
/// @param value_from_range1
function range_convert(argument0, argument1, argument2, argument3, argument4) {
 
	/*
	range_convert(minrange1,maxrange1,minrange2,maxrange2,value)
	Converts and interpolates value from (minrange1,maxrange1) to (minrange2,maxrange2).
	*/
 
	var value,minrange1,maxrange1,minrange2,maxrange2,dec;
 
	minrange1 = argument0;
	maxrange1 = argument1;
	minrange2 = argument2;
	maxrange2 = argument3;
	value = argument4;
 
	dec = (value-minrange1)/(maxrange1-minrange1);
	return dec*(maxrange2-minrange2)+minrange2;


}
