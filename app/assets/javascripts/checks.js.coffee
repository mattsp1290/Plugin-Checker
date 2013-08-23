$(document).ready ->
  
  $('.script-disabled').html 'Plug-in Checker'
  
  ie = false
  
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
  $('#check_os').val(OSName)
  
  
  
  
  
  
  
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
    ie = true
  
  if(match && (tem = ua.match(/version\/([\.\d]+)/i)))
    match[2]= tem[1]
  
  browser_result = match.join(' ')
  $('#browser-result').append(browser_result)
  $('#check_browser').val(browser_result)
  
  
  
  
  
  $('#uas-text').html 'User Agent String'
  $('#uas-result').append ua
  $('#check_uas').val(ua)
  
  
  
  
  
  $('#resolution-text').html 'Screen Resolution'
  resolution = '' + window.screen.availWidth + ' x ' + window.screen.availHeight
  $('#resolution-result').append(resolution)
  $('#check_resolution').val(resolution)
  
  
  
  
  
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
  $('#check_cookies').val(cookies)
  
  
  
  
  $('#flash-text').html 'Flash Version'
  flash = 'Unavailable'
  if FlashDetect.raw
    flash = (FlashDetect.major + '.' + FlashDetect.minor + '.' + FlashDetect.revision)
  else
    flash = 'disabled'

  $('#check_flash').val(flash)
  $('#flash-result').html(flash)


  $('#java-text').html 'Java Version'
  java = 'Unavailable'
  if deployJava.getJREs().length > 0
    java = deployJava.getJREs()
  else
    java = 'disabled'
  
  $('#java-result').html(java)
  $('#check_java').val(java)
  
  $('#popup-text').html 'Pop-up Blocker'
    

  popup = window.open('http://www.google.com')
  functionRan = false
  popups = "Unavailable"
  setTimeout(
    ->
      if(!popup || popup.outerHeight == 0)
        # First Checking Condition Works For IE & Firefox
        # Second Checking Condition Works For Chrome
        popups = 'enabled'
        functionRan = true
      else
        # Popup Blocker Is Disabled
        popup.close()
        popups = 'disabled'
        functionRan = true
    25)
    
  if(!(functionRan))
    popups = 'enabled'
    
  $('#check_popups').val(popups)
  $('#popup-result').html(popups)




  $('#reader-text').html 'Acrobat Reader'
  info = getAcrobatInfo()
  if info.acrobat
    info = info.acrobatVersion
  else
    info = 'disabled'
    
  $('#reader-result').append(info)
  $('#check_reader').val(info)
  
  if(ie)
    screen = document.frames.screen
    zoom = (((screen.deviceXDPI / screen.systemXDPI) * 100).toFixed())
    zoomLevel = $('<div class="span3">Zoom Level</div><div class="span9">' + zoom + '</div>')
    $('#zoom-level').html(zoomLevel)
    $('#check_zoom').val(zoom)
    
    compView = 'disabled'
    if (document.documentMode == 7) 
      compView = 'enabled'
      
    comp = $('<div class="span3">Compatibility View</div><div class="span9">' + compView + '</div>')
    $('#comp-view').html(comp)
    $('#check_comp').val(compView)
    