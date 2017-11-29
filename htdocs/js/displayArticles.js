function displayArticles()
{
  var category = document.getElementById('category').value;
  var table;
  var articleData;

  /* generates the article table if it doesn't exist yet, and sets var table
   * to hold the id of the article table */
  if (!document.getElementById("article-table"))
  {
    document.getElementById("article-table-container").innerHTML = "<table id=\"article-table\" class=\"table table-responsive table-bordered\"></table>";
    table = document.getElementById("article-table");
  }
  /* if the article table already exists, sets the var table to the id of the
   * article table */
  else
  {
    table = document.getElementById("article-table");
  }

  //displays articles based on category given on the form
  if (category == "Hardware")
  {
    $(table).load( "article-database/hardware.html" );
  }
  else if (category == "Programming")
  {
    $(table).load( "article-database/programming.html" );
  }
  else if (category == "Gaming")
  {
    $(table).load( "article-database/gaming.html" );
  }
  else if (category == "Hot Topics")
  {
    $(table).load( "article-database/hot-topics.html" );
  }
}

$(document).ready ( displayArticles() );
