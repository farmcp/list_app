var options = {
  propertyToSearch: "full_name",
  theme: "facebook",
  hintText: "Enter a name in your network",
  searchingText: "Searching your network...",
};
$(document).ready(function () {
  $("#search-box").tokenInput("/users/syncable_users", options);
});
