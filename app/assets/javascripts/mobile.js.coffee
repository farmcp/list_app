# Normalized hide address bar for iOS & Android
# (c) Scott Jehl, scottjehl.com
# MIT License
window.hideAddressBar = (win) ->
  doc = win.document

  # If there's a hash, or addEventListener is undefined, stop here
  if !location.hash && win.addEventListener
    # scroll to 1
    window.scrollTo 0, 1
    scrollTop = 1
    getScrollTop = () ->
      win.pageYOffset || doc.compatMode == "CSS1Compat" && doc.documentElement.scrollTop || doc.body.scrollTop || 0

    # reset to 0 on bodyready, if needed
    bCheck = () ->
      if doc.body
        clearInterval bodycheck
        scrollTop = getScrollTop()
        win.scrollTo 0, scrollTop == 1 ? 0 : 1
    bodycheck = setInterval bCheck, 15

    onLoad = () ->
      setTimeout () ->
        # at load, if user hasn't scrolled more than 20 or so...
        if getScrollTop() < 20
          # reset to hide addr bar at onload
          win.scrollTo 0, scrollTop == 1 ? 0 : 1

    win.addEventListener "load", onLoad, 0
