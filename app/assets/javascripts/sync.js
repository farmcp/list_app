$(document).ready(function () {
  //need to figure out how to get the current_user.id in here and how to search the full_name
  $("#search-box").tokenInput("/users/"+ $('#current_user_id').val() +"/following_followers.json", {propertyToSearch:"full_name", theme:"facebook"});
});