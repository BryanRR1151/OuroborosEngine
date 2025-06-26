randomize();

var files = ["Dialogues.dat", "General.dat", "Questions.dat"];

for (var i = 0; i < array_length(files); i++) {
    var source = program_directory + files[i];
    var dest = files[i];
    
    if (file_exists(source) && !file_exists(dest)) {
        file_copy(source, dest);
    }
}