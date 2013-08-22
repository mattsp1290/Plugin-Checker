$(document).ready ->
  $('#browser-result').append navigator.userAgent
  
  $('#flash-result').html FlashDetect.raw

  $('#java-result').html deployJava.getJREs()
  
  
  
  #windowName = 'userConsole'
  #popUp = window.open('www.google.com', windowName, 'width=100, height=100, left=24, top=24, scrollbars, resizable')
  #if (popUp == null || typeof(popUp)=='undefined') 
  #  ('#popup-result').html('enabled')
  #else
  #  ('#popup-result').html('disabled')
    

  popup = window.open(winPath,winName,winFeature,true)
  setTimeout(
    ->
      if(!popup || popup.outerHeight == 0)
        # First Checking Condition Works For IE & Firefox
        # Second Checking Condition Works For Chrome
        $('#popup-result').html('enabled')
      else
        # Popup Blocker Is Disabled
        $('#popup-result').html('disabled')
    25)