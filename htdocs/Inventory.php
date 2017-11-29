<?php
$db = mysqli_connect('schoolwork.ciehnsgqcnhj.us-east-2.rds.amazonaws.com',  'root',  'Vfkrrozrun',  'final_project_databases');
//session_start();
// TODO You must process the POST data from the form and then set the variables
// below to be inserted in the database

// You should see sucess if you can connect
if(mysqli_connect_errno()){
    echo 'Unable to connect to database [' . mysqli_connect_error() . ']';
}
$HeaderVal = $_GET['HeaderVal'];

if ($HeaderVal == "1")
{
	$query = "SELECT * FROM items_in_kits_vs_individual";
} 
else if ($HeaderVal == "2")
{
	$query = "SELECT * FROM workshops_kit_info";
}
else if ($HeaderVal == "3")
{
	$query = "SELECT * FROM workshop_items_grouped";
}
else if ($HeaderVal == "4")
{
	$query = "SELECT * FROM data_dump";
}
else if ($HeaderVal == "5")
{
	$query = "SELECT * FROM workshop_items_ungrouped";
}
else if ($HeaderVal == "6")
{
	$query = "SELECT * FROM workshops_overusing_inventory";
}
else if ($HeaderVal == "7")
{
	$query = "SELECT * FROM workshops_underusing_inventory";
}
else if ($HeaderVal == "8")
{
	$query = "SELECT * FROM all_items_and_workshops";
}
else if ($HeaderVal == "9")
{
	$query = "SELECT * FROM needed_items_for_kits";
}
else if ($HeaderVal == "10")
{
	$query = "SELECT * FROM total_items";
}

else if ($HeaderVal == "Kit")
{
	$query = "SELECT * FROM Kits";
}
else if ($HeaderVal == "Inventory")
{
	$query = "SELECT * FROM Items";
}
else if ($HeaderVal == "Workshops")
{
	$query = "SELECT * FROM Workshop_Contents";
}
else if ($HeaderVal == "KitContents")
{
	$query = "SELECT * FROM Kit_Contents";
}
if($HeaderVal != NULL)
{
	if($result=mysqli_query($db, $query))
	{
		$items = array();
		while($obj=mysqli_fetch_object($result))
		{
			//printf("%s (%s)", $obj->Name, $obj->Quantity);
			array_push($items, $obj);
		}
		mysqli_free_result($result);
		printf(json_encode($items));
	}
}
else
{
	$Val = $HTTP_RAW_POST_DATA;
	$Ins = json_decode($Val);
	$query = "INSERT INTO Items VALUES ('" . $Ins->name ."' , " . $Ins->Quantity . " )";
	//echo $query;
	if ($result = mysqli_query($db, $query))
	{
		echo ("Insert Successful");
	}
	else
	{
		echo(mysqli_error($db));
	}
	
}

mysqli_close($db);

?>
