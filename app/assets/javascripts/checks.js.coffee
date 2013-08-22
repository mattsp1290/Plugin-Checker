$(document).ready ->
  ua = navigator.userAgent
  $('h1').html 'Plug-in Checker'
  $('#browser-text').html 'Browser Version'
  app = navigator.appName
  match = ua.match(/(opera|chrome|safari|firefox|msie|trident)\/?\s*([\d\.]+)/i) || []
  tem = ua.match(/(opera|chrome|safari|firefox|msie|trident)\/?\s*([\d\.]+)/i) || []
  if match[2]
    match = [match[1], match[2]]
  else
    match = [app, navigator.appVersion, '-?']
  
  if(match && (tem = ua.match(/version\/([\.\d]+)/i)))
    match[2]= tem[1]
  
  $('#browser-result').append(match.join(' '))
  
  $('#uas-text').html 'User Agent String'
  $('#uas-result').append ua
  
  $('#flash-text').html 'Flash Version'
  if FlashDetect.raw
    $('#flash-result').html(FlashDetect.major + '.' + FlashDetect.minor + '.' + FlashDetect.revision)
  else
    $('#flash-result').html 'disabled'

  $('#java-text').html 'Java Version'
  if deployJava.getJREs().length > 0
    $('#java-result').html deployJava.getJREs()
  else
    $('#java-result').html 'disabled'
  
  
  #windowName = 'userConsole'
  #popUp = window.open('www.google.com', windowName, 'width=100, height=100, left=24, top=24, scrollbars, resizable')
  #if (popUp == null || typeof(popUp)=='undefined') 
  #  ('#popup-result').html('enabled')
  #else
  #  ('#popup-result').html('disabled')
  
  $('#popup-text').html 'JavaScript'
    

  popup = window.open('http://www.google.com')
  setTimeout(
    ->
      if(!popup || popup.outerHeight == 0)
        # First Checking Condition Works For IE & Firefox
        # Second Checking Condition Works For Chrome
        $('#popup-result').html('enabled')
      else
        # Popup Blocker Is Disabled
        popup.close()
        $('#popup-result').html('disabled')
    25)