<style>
table, th, td, tr {
	border: 1px solid white;
	border-collapse: collapse;
}
#content > div {display:none;)
</style>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
  <title>StringScape</title>
  <!-- jquery import -->
  <script src="js/jquery.min.js"></script>
  <!--<script src="js/jquery.min.js"></script>-->
  <!-- Bootstrap Stylesheets-->
  <link href="css/bootstrap.css" rel="stylesheet">
  <link href="css/formValidation.min.css" rel="stylesheet">
  <link href="css/morris.css" rel="stylesheet">
  <!-- Bootstrap scripts -->
  <script src="js/bootstrap.min.js"></script>
  <script src="js/formValidation.min.js"></script>
  <script src="js/raphael-min.js"></script>
  <script src="js/morris.min.js"></script>

  <!-- custom stylesheet -->
  <link href="css/custom-stylesheet.css" rel="stylesheet">
  <!-- javascript sets header-image-container height to window height,
    sizing the image to the user's browser window -->
  <script type="text/javascript" language="Javascript" src="js/set-header-height.js"></script>
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
          <li class="active"><a href="load2.php">Select</a></li>
          <li><a href="save2.php">Upload</a></li>
        </ul>
      </div><!--/.nav-collapse -->
    </div>
  </nav>
  <div class="container" style="margin-top:10%;">
	<h2> UOIT C_Wonder Inventory Management System </h1>
	<h3 id="ViewName"></h3>
	<table class="table table-condensed" style="width:40%">
		<tr id="HeadBoy">
		</tr>
		<tbody id="TableData">
		</tbody>
	</table>
	<br>
	<div class="form-group">
		<label class="col-sm-2">View Select</label>
		<div class="col-sm-3">
			<select id="ViewSelect" class="form-control">
				<option value="Inventory">Inventory</option>
				<option value="Kit">Kit</option>
				<option value="KitContents">Kit Contents</option>
				<option value="Workshops">Workshops</option>
				<option value="1">View 1 - Item Breakdown</option>
				<option value="2">View 2 - Workshop Kit Info</option>
				<option value="3">View 3 - Total Items per Workshop</option>
				<option value="4">View 4 - Data Dump </option>
				<option value="5">View 5 - Workshop Item Breakdown</option>
				<option value="6">View 6 - Workshops Over Inventory Budget</option>
				<option value="7">View 7 - Workshops within Inventory Budget</option>
				<option value="8">View 8 - All items and Workshops</option>
				<option value="9">View 9 - Needed Items for Kits</option>
				<option value="10">View 10 - Total Items Count in Workshops</option>
			</select>
		</div>
		<div class="col-sm-1">
			<button class="btn btn-default" onclick="ChangeView();">Load</button>
		</div>
    </div>
	<br>
	<br>
	<p> View 1 - Join of 3 Tables</p>
	<p> View 2 - Uses Any Operator</p>
	<p> View 3 - A Correlated Nested Query</p>
	<p> View 4 - Uses a Full Join</p>
	<p> View 5 - Uses Nested Queries with Union Operator</p>
	<br>
	<br>
	<p> Modules Used: Bootstrap, JSON, PHP </p>
	</div>
</body>


<script>
var divState = {};
function ChangeView(id = ViewSelect.value)
{
	document.getElementById("ViewName").innerHTML = "View " + id;
	fetch('Inventory.php?HeaderVal=' + id)
	.then(r => r.json())
	.then(data => {
		console.log(data)
		changeTable(data)
	})
	.catch(err => {throw err});
	/*
	if (document.getElementById)
	{
		var divid = document.getElementById(id);
		divState[id] = (divState[id]) ? false : true;
		for (var div in divState)
		{
			if(divState[div] && div != id)
			{
				document.getElementById(div).style.display = 'none';
				divState[div] = false;
			}
		}
		divid.style.display = (divid.style.display == 'block' ? 'none' : 'block');
	}*/
}



var xmlhttp = new XMLHttpRequest();
var table = document.getElementById("TableData");
var tablehead = document.getElementById("HeadBoy");
xmlhttp.onreadystatechange = function() 
{
    if (this.readyState == 4 && this.status == 200) {
        var myObj = JSON.parse(this.responseText);
		for (key in myObj[0])
		{
			var cell = tablehead.insertCell(key);
			cell.innerHTML = key;
		}
		for (x in myObj)
		{
			var row = table.insertRow(x);
			for (key in myObj[x])
			{
				var cell = row.insertCell(key);
				cell.innerHTML = myObj[x][key];
				
			}
		}
    }
};

function changeTable(myObj)
{
		table.innerHTML = "";
		tablehead.innerHTML = "";
		for (key in myObj[0])
		{
			var cell = tablehead.insertCell(key);
			cell.innerHTML = key;
		}
		for (x in myObj)
		{
			var row = table.insertRow(x);
			for (key in myObj[x])
			{
				var cell = row.insertCell(key);
				cell.innerHTML = myObj[x][key];
				
			}
		}
}

xmlhttp.open("GET", "Inventory.php", true);
xmlhttp.send();

</script>
</html>
