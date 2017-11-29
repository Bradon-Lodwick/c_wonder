<head>
  <link href="css/bootstrap.css" rel="stylesheet">
  <link href="css/formValidation.min.css" rel="stylesheet">
  <link href="css/morris.css" rel="stylesheet">

  <!-- custom stylesheet -->
  <link href="css/custom-stylesheet.css" rel="stylesheet">
</head>

<body>
	<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="load2.php">C_Wonder</a>
      </div>
      <div id="navbar" class="collapse navbar-collapse">
        <ul class="nav navbar-nav">
          <li><a href="load2.php">Select</a></li>
          <li class="active"><a href="save2.php">Upload</a></li>
        </ul>
      </div>
    </div>
  </nav>
  <div class="container" style="margin-top:10%;">
	<h1>Upload New Inventory Items:</h1>
	<div class="form-group">
		<label for="name" class="col-sm-2">Name</label>
		<div class="col-sm-10">
			<input id="N" type="text" class="form-control" />
		</div>
	</div>
	<div class="form-group">
		<label for="quantity" class="col-sm-2">Quantity</label>
		<div class="col-sm-10">
			<input id="Q" type="text" class="form-control" />
		</div>
	</div>
	<br>
	<div class="col-sm-2"></div>
	<div class="col-sm-1">
	<button class="btn btn-default" onclick="UploadData();">Submit</button>
	</div>
  </div>
  
</body>

<script>



var xmlhttp = new XMLHttpRequest();

xmlhttp.onreadystatechange = function() 
{
    if (this.readyState == 4 && this.status == 200) {
        var myObj = JSON.parse(this.responseText);
    }
};

function UploadData()
{
	var xmlhttp = new XMLHttpRequest();
	var Input = {"name" : document.getElementById("N").value, "Quantity" : document.getElementById("Q").value};
	//var myObj = JSON.parse(Input);
	//var myObj = JSON.parse(this.responseText);
	//myObj.push(Input);
	JsonString =JSON.stringify(Input);
	//console.log(JsonString);
	fetch("Inventory.php", 
	{
		method: "post",
		headers: {
			'Accept' : 'application/json',
			'Content-Type': 'application/json',
		},
		body : JsonString
	})
	.then ( (Response) => {
		Response.text()
		.then ( (text) =>
		{
			alert(text)
		})
	})
	/*else
	{
		fetch('Inventory.php?HeaderVal=Inventory')
		.then(r => r.json())
		.then(data => {
		//console.log(data)
	})
	.catch(err => {throw err});
	}*/
	xmlhttp.open("POST", "Inventory.php", true);
	xmlhttp.send();
}
</script>