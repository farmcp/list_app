var options = {
  propertyToSearch: "full_name",
  hintText: "Enter a name in your network",
  theme: "facebook",
  searchingText: "Searching your network...",
};
$(document).ready(function () {
  $("#search-box").tokenInput("/users/syncable_users", options);

  $("input[type=submit]").click(function(){
    //create the array of ids that are returned on the submit
    var syncIds = $(this).siblings("input[type=text]").val().split(',');
    
    //pass in a list of ids to the controller
    var url = '/get_sync?ids='.concat(syncIds);

    document.location.href = url;
    return false;
  });
});
