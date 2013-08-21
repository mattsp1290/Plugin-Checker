$(document).ready ->
  $('.browser').append 'Your browser version is '
  $('.browser').append navigator.userAgent
  
  $('.flash').append 'Your flash version is '
  $('.flash').append FlashDetect.raw

  $('.java').append ("You have the following JREs:")
  $('.java').append deployJava.getJREs()
  
  $('.popup').append('Your pop-up blocker is ')
  windowName = 'userConsole'
  popUp = window.open('www.google.com', windowName, 'width=100, height=100, left=24, top=24, scrollbars, resizable')
  if (popUp == null || typeof(popUp)=='undefined') 
    ('.popup').append('disabled')
  else
    ('.popup').append('enabled')