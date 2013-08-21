$(document).ready ->
  $('#browser-text').append 'Your browser version is '
  $('#browser-result').append navigator.userAgent
  
  $('#flash-text').append 'Your Flash version is '
  $('#flash-result').html FlashDetect.raw

  $('#java-text').append ("Your Java version(s) is ")
  $('#java-result').html deployJava.getJREs()
  
  $('#popup-text').append('Your pop-up blocker is ')
  windowName = 'userConsole'
  popUp = window.open('www.google.com', windowName, 'width=100, height=100, left=24, top=24, scrollbars, resizable')
  if (popUp == null || typeof(popUp)=='undefined') 
    ('#popup-result').html('disabled')
  else
    ('#popup-result').html('enabled')