$(document).ready ->
  
  $('h1').html 'Plug-in Checker'
  
  
  
  OSName="Unknown OS"
  if (navigator.appVersion.indexOf("Win")!=-1)
    OSName="Windows"
  if (navigator.appVersion.indexOf("Mac")!=-1)
    OSName="MacOS"
  if (navigator.appVersion.indexOf("X11")!=-1)
    OSName="UNIX"
  if (navigator.appVersion.indexOf("Linux")!=-1)
    OSName="Linux"
  
  $('#os-text').html 'Operating System'
  $('#os-result').append OSName
  
  
  
  
  
  
  
  ua = navigator.userAgent
  $('#browser-text').html 'Browser Version'
  app = navigator.appName
  match = ua.match(/(opera|chrome|safari|firefox|msie|trident)\/?\s*([\d\.]+)/i) || []
  tem = ua.match(/(opera|chrome|safari|firefox|msie|trident)\/?\s*([\d\.]+)/i) || []
  if match[2]
    match = [match[1], match[2]]
  else
    match = [app, navigator.appVersion, '-?']
    
  if match[0] == 'MSIE'
    match[0] = 'Internet Explorer'
  
  if(match && (tem = ua.match(/version\/([\.\d]+)/i)))
    match[2]= tem[1]
  
  $('#browser-result').append(match.join(' '))
  
  
  
  
  
  
  $('#uas-text').html 'User Agent String'
  $('#uas-result').append ua
  
  
  
  
  
  $('#resolution-text').html 'Screen Resolution'
  $('#resolution-result').append(window.screen.availWidth + ' x ' + window.screen.availHeight)
  
  
  
  
  
  
  $('#cookies-text').html 'Cookies'
  
  if navigator.cookieEnabled
    cookies = true
  else
    cookies = false
    
  if (typeof navigator.cookieEnabled=="undefined" && !cookies)
    document.cookie="testcookie"
    if (document.cookie.indexOf("testcookie")!=-1)
      cookies = true
    else
      cookies = false
  
  
  if cookies
    cookies = 'enabled'
  else
    cookies = 'disabled'
    
  $('#cookies-result').append(cookies)
  
  
  
  
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
    




  $('#reader-text').html 'JavaScript'
  info = getAcrobatInfo()
  if info.acrobat
    info = info.acrobat + " " + info.acrobatVersion
  else
    info = 'disabled'
    
  $('#reader-result').append(info)