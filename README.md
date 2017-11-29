# c_wonder
Group 12's final project for SOFE 3700U

Since 2014, the Faculty of Engineering and Applied Science at the University of Ontario Institute of Technology (UOIT) began an ambitious
initiative to deliver Kindergarten to Grade 12 engineering outreach programs to youth in Durham Region. After a concerted, multi-faceted
effort over the past three years, the program has grown to reach over 4,000 students annually. The goal is to inspire youth to ask
questions and empower them to develop solutions to everyday problems using the engineering design process.
The initiative of this group is to develop and implement a resource management database. The purpose of this database is to keep track of
all supplies and resources available to the instructors. The instructors must have control over what they are able to bring to each
program as well as be able to replace items that have become defective or have been broken. Furthermore, the administrator must be able to
change the contents of the inventory and of the contents of the predetermined kits. Finally, the Database must be able to easily output a
readable table that defines the collection of metrics.

----------
SETUP
----------
To setup the database and application, a web server application such as xampp, wamp, or lamp should be used. Download one of these 
server packages. Once the server package is installed, use the create_database.sql file to load the database information into a new
mysql database. Once finished, the Inventory.php file will need to have a few values changed. On line 2, change the mysqli_connect file
arguments to connect to your newly created database. Connect to the given index.php file in the htdocs folder and setup is complete!
