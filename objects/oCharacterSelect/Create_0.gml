global.selectedCharacters = [];

_index = 0;
cMax = array_length(global.general.characters);

width = 320;
height = 180;

_pointerX = 60;

for (var i = 0; i < cMax; i++)
{
	if (global.general.characters[i].selected) array_push(global.selectedCharacters, i);
}

function SelectedCharacter(value)
{
	var len = array_length(global.selectedCharacters);
	for (var i = 0; i < len; i++)
	{
		if (global.selectedCharacters[i] == value) return true;
	}
	return false;
}

function RemoveItem(value) 
{
	var len = array_length(global.selectedCharacters);
	var arr = [];
	array_copy(arr, 0, global.selectedCharacters, 0, len);
    var index_to_remove = -1;

    // Find index of the value
    for (var i = 0; i < len; i++) {
        if (global.selectedCharacters[i] == value) {
            index_to_remove = i;
            break;
        }
    }

    // If not found, return original array
    if (index_to_remove == -1) {
        return;
    }

    // Build new array without the found index
    global.selectedCharacters = [];
    var j = 0;

    for (var i = 0; i < len; i++) {
        if (i != index_to_remove) {
			array_push(global.selectedCharacters, arr[i]);
            j++;
        }
    }
}