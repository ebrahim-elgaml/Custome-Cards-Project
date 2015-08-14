document.getElementById('file').onchange = function(){
  var fileTypes = ['txt']; 
  /*var file = document.getElementById("file").files[0];
  if (file) {
      var reader = new FileReader();
      reader.readAsText(file, "UTF-8");
      reader.onload = function (evt) {
          document.getElementById("cards").value = evt.target.result;
      }
      reader.onerror = function (evt) {
          document.getElementById("fileContents").innerHTML = "error reading file";
      }
  }
  */
  
  var file = this.files[0];
  var extension = file.name.split('.').pop().toLowerCase();  //file extension from input file
  var isSuccess = fileTypes.indexOf(extension) > -1;
  if (isSuccess){
    var reader = new FileReader();
    reader.onload = function(progressEvent){
      // Entire file
      //console.log(this.result);
      document.getElementById('cards').value = this.result;  
      // By lines
      //var lines = this.result.split('\n');
      //for(var line = 0; line < lines.length; line++){
      //  console.log(lines[line]);
      //}
    };
    reader.readAsText(file);
  }else{
    alert("Support text file only")
  }

};
