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
    cookies = 'Enabled'
  else
    cookies = 'Disabled'
    
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
    popups = "Enabled"
  else
    # Popup Blocker Is Disabled
    popup.close()
    popups = "Disabled"   
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
    flash = 'Disabled'
    
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
    java = 'Disabled'
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
    reader = 'Disabled'
  return reader
  
  
  
# zoom_level() returns the current Zoom Level of the user's browser.
# This only works for Internet Explorer  
zoom_level = ->
  # The code for this function was editing from pench's answer on http://stackoverflow.com/questions/1713771/how-to-detect-page-zoom-level-in-all-modern-browsers
  zoom = "Unavailable"
  if(/Internet\sExplorer/.test(browser_name()))
    screen = document.frames.screen
    zoom = (((screen.deviceXDPI / screen.systemXDPI) * 100).toFixed())
  return zoom
  
  
  
# geocomp_view() returns whether or not Compatibility View is enabled on the user's browser
comp_view_status = ->
  comp_view = "Unavailable"
  if(/Internet\sExplorer/.test(browser_name()))
    if (document.documentMode == 7)
      comp_view = 'Enabled'
    else
      comp_view = 'Disabled'
  return comp_view
  
  
        
$(document).ready ->
  # In this function fields in a form and div tags are populated with results from various function calls
  $('.script-disabled').html 'Plug-in Checker'
  $('.hidden').removeClass("hidden")
  
  os = os_name()  
  $('#os-result').html(os)
  $('#check_os').val(os)
  
  
  browser = browser_name()
  $('#browser-result').html(browser)
  $('#check_browser').val(browser)
  
  
  uas = user_agent_string()
  $('#uas-result').html(uas)
  $('#check_uas').val(uas)
  
  
  comp_view = comp_view_status()  
  $('#comp-result').html(comp_view)
  $('#check_comp').val(comp_view)
  
  
  resolution = '' + window.screen.availWidth + ' x ' + window.screen.availHeight
  $('#resolution-result').html(resolution)
  $('#check_resolution').val(resolution)
  
  
  zoom = zoom_level()
  $('#zoom-result').html(zoom)
  $('#check_zoom').val(zoom)
  
  
  cookies = cookies_status()
  $('#cookies-result').html(cookies)
  $('#check_cookies').val(cookies)
  
  
  popup_blocker = popup_blocker_status()
  $('#check_popups').val(popup_blocker)
  $('#popup-result').html(popup_blocker)

  
  flash = flash_version()
  $('#check_flash').val(flash)
  $('#flash-result').html(flash)


  java = java_versions()
  $('#java-result').html(java)
  $('#check_java').val(java)
  
  
  pdf = pdf_reader()
  $('#reader-result').html(pdf)
  $('#check_reader').val(pdf)
      
    

    