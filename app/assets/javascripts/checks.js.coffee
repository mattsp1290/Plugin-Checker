getOSName = ->
  # The following code was modified from http://www.javascripter.net/faq/operatin.htm
  if (navigator.appVersion.indexOf("Win")!=-1)
    return "Windows"
  else if (navigator.appVersion.indexOf("Mac")!=-1)
    return "MacOS"
  else if (navigator.appVersion.indexOf("X11")!=-1)
    return "UNIX"
  else if (navigator.appVersion.indexOf("Linux")!=-1)
    return "Linux"
  else
    return "Unkown OS"

getUAS = ->
  return navigator.userAgent

getBrowser = ->
  ua = getUAS()
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
  
  return match.join(' ')


$(document).ready ->
  
  $('.script-disabled').html 'Plug-in Checker'
  
  ie = false
  
  # Get the name of the OS and display it
  $('#os-text').html 'Operating System'
  $('#os-result').append(getOSName())
  $('#check_os').val(getOSName())
  
  
  
  
  
  
  $('#browser-text').html 'Browser Version'
  $('#browser-result').append(getBrowser())
  $('#check_browser').val(getBrowser())
  
  
  
  
  
  $('#uas-text').html 'User Agent String'
  $('#uas-result').append(getUAS())
  $('#check_uas').val(getUAS())
  
  
  
  
  
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
  popups = "Unavailable"
  $('#check_popups').val(popups)
  $('#popup-result').html(popups)
  setTimeout(
    ->
      if(!popup || popup.outerHeight == 0)
        # First Checking Condition Works For IE & Firefox
        # Second Checking Condition Works For Chrome
        popups = 'enabled'
        $('#check_popups').val('enabled')
        $('#popup-result').html('enabled')
      else
        # Popup Blocker Is Disabled
        popup.close()
        popups = 'disabled'
        $('#check_popups').val('disabled')
        $('#popup-result').html('disabled')
    25)
    
    
  




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
    
    
  console.log("Match IE")
  console.log(/Internet\sExplorer/.test(getBrowser()))
  console.log("Match FF")
  console.log(/Firefox/.test(getBrowser()))
    

    