# os_name() returns the name of the OS
os_name = ->
  # The code for this fucntion was modified from http://www.javascripter.net/faq/operatin.htm
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



# user_agent_string() returns the user agent string
user_agent_string = ->
  return navigator.userAgent



# browser_name() returns the browser name and version
browser_name = ->
  # The code for this function was modified from http://stackoverflow.com/questions/2400935/browser-detection-in-javascript
  # I used the answer from kennebec and converted it to CoffeeScript and added my own check to make MSIE more readable.
  ua = user_agent_string()
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
  
  
  
# cookies_status() will return whether or not cookies are enabled int he browser
cookies_status = ->
  # The code for this function was modified from http://stackoverflow.com/questions/4603289/how-to-detect-that-javascript-and-or-cookies-are-disabled
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
    
  return cookies



# popup_blocker_status() will return whether or not pop-up blockers are enabled in the browser
popup_blocker_status = ->
  # This function is modified from the code found at http://stackoverflow.com/questions/16538991/how-do-i-detect-popup-blocker-in-chrome
  popup = window.open('http://www.google.com')
  popups = "Unavailable"
  timeout = ->
  setTimeout(timeout, 25)
  if(!popup || popup.outerHeight == 0)
      # First Checking Condition Works For IE & Firefox
      # Second Checking Condition Works For Chrome
    popups = "enabled"
  else
    # Popup Blocker Is Disabled
    popup.close()
    popups = "disabled"   
  return popups


# flash_version() will return the version of Flash the user has installed or disabled if flash is not found
flash_version = ->
  # This used the JavaScript library called FlashDetect
  # FlashDetect can be found at
  # http://www.featureblend.com/javascript-flash-detection-library.html
  flash = 'Unavailable'
  if FlashDetect.raw
    flash = (FlashDetect.major + '.' + FlashDetect.minor + '.' + FlashDetect.revision)
  else
    flash = 'disabled'
    
  return flash
    
    
# java_versions() will return all of the JREs that the user installed. It will return "disbled" if no JREs are installed
java_versions = ->
  # This uses the Deployment Toolkit Script from Oracle
  # You can find this at
  # http://docs.oracle.com/javase/6/docs/technotes/guides/jweb/deployment_advice.html#deplToolkit
  java = 'Unavailable'
  if deployJava.getJREs().length > 0
    java = deployJava.getJREs()
  else
    java = 'disabled'
  return java


# pdf_reader() returns information about the PDF reader that the user currently has installed
pdf_reader = ->
  # This uses the AcrobatInfo JavaScript library
  # The library can be found at
  # http://thecodeabode.blogspot.com/2011/01/detect-adobe-reader-plugin.html
  reader = getAcrobatInfo()
  if reader.acrobat
    reader = reader.acrobatVersion
  else
    reader = 'disabled'
  return reader
  
  
  
# zoom_level() returns the current Zoom Level of the user's browser.
# This only works for Internet Explorer  
zoom_level = ->
  # The code for this function was editing from pench's answer on http://stackoverflow.com/questions/1713771/how-to-detect-page-zoom-level-in-all-modern-browsers
  screen = document.frames.screen
  zoom = (((screen.deviceXDPI / screen.systemXDPI) * 100).toFixed())
  return zoom
  
  
  
# geocomp_view() returns whether or not Compatibility View is enabled on the user's browser
comp_view_status = ->
  comp_view = 'disabled'
  alert 'disabled'
  if (document.documentMode == 7) 
    comp_view = 'enabled'
  alert 'enabled'
  return comp_view
  
  
        
$(document).ready ->
  # In this function fields in a form and div tags are populated with results from various function calls
  $('.script-disabled').html 'Plug-in Checker'
  $('.hidden').removeClass("hidden")
    
  $('#os-text').html 'Operating System'
  $('#os-result').append(os_name())
  $('#check_os').val(os_name())
  
  
  $('#browser-text').html 'Browser Version'
  $('#browser-result').append(browser_name())
  $('#check_browser').val(browser_name())
  
  
  $('#uas-text').html 'User Agent String'
  $('#uas-result').append(user_agent_string())
  $('#check_uas').val(user_agent_string())
  
  
  $('#resolution-text').html 'Screen Resolution'
  resolution = '' + window.screen.availWidth + ' x ' + window.screen.availHeight
  $('#resolution-result').append(resolution)
  $('#check_resolution').val(resolution)
  
  
  $('#cookies-text').html 'Cookies'
  $('#cookies-result').append(cookies_status())
  $('#check_cookies').val(cookies_status())
  
  
  $('#popup-text').html 'Pop-up Blocker'
  $('#check_popups').val(popup_blocker_status())
  $('#popup-result').html(popup_blocker_status())

  
  $('#flash-text').html 'Flash Version'
  $('#check_flash').val(flash_version())
  $('#flash-result').html(flash_version())


  $('#java-text').html 'Java Version'
  $('#java-result').html(java_versions())
  $('#check_java').val(java_versions())
  
  
  $('#reader-text').html 'Acrobat Reader'    
  $('#reader-result').append(pdf_reader())
  $('#check_reader').val(pdf_reader())
  
  
  if(/Internet\sExplorer/.test(browser_name()))    
    zoom_html = $('<div class="span3">Zoom Level</div><div class="span9">' + zoom_level() + '</div>')
    alert "Adding zoom html"
    $('#zoom-level').html(zoom_html())
    $('#check_zoom').val(zoom_level())
   
      
    comp_html = $('<div class="span3">Compatibility View</div><div class="span9">' + comp_view_status() + '</div>')
    $('#comp-view').html(comp_html)
    $('#check_comp').val(comp_view_status())
    

    