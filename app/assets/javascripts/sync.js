var options = {
  propertyToSearch: "full_name",
  hintText: "Enter a name in your network",
  theme: "facebook", 
  searchingText: "Searching your network...",
};
$(document).ready(function () {
  $("#search-box").tokenInput("/users/syncable_users", options);
});
