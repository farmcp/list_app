$(document).ready(function () {
  //need to figure out how to get the current_user.id in here and how to search the full_name
    $("#search-box").tokenInput("/users/1/followers.json", {propertyToSearch:"first_name", theme:"facebook"});
});