$(document).ready ->
  
  $('h1').html 'Plug-in Checker'
  
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
  
  
  
  
  $('#popup-text').html 'Pop-up Blocker'
    

  popup = window.open('http://www.google.com')
  functionRan = false
  setTimeout(
    ->
      if(!popup || popup.outerHeight == 0)
        # First Checking Condition Works For IE & Firefox
        # Second Checking Condition Works For Chrome
        $('#popup-result').html('enabled ')
        functionRan = true
      else
        # Popup Blocker Is Disabled
        popup.close()
        $('#popup-result').html('disabled ')
        functionRan = true
    25)
    
  if(!(functionRan))
    $('#popup-result').html('enabled ')
    




  $('#reader-text').html 'Acrobat Reader'
  info = getAcrobatInfo()
  if info.acrobat
    info = info.acrobatVersion
  else
    info = 'disabled'
    
  $('#reader-result').append(info)
  
  if(ie)
    screen = document.frames.screen
    zoom = (((screen.deviceXDPI / screen.systemXDPI) * 100 + 0.9).toFixed())
    zoomLevel = $('<div class="span3">Zoom Level</div><div class="span9">' + zoom + '</div>')
    $('#zoom-level').html(zoomLevel)
    
    compView = 'disabled'
    if (document.documentMode == 7) 
      compView = 'enabled'
      
    comp = $('<div class="span3">Compatibility View</div><div class="span9">' + compView + '</div>')
    $('#comp-view').html(comp)
    
    
  if FlashDetect.raw
    copyButton = $('<div class="span12"><input type="button" id="copy" name="copy" value="Copy to Clipboard" /></div>')
    $('#copy').html(copyButton)
    # set path
    ZeroClipboard.setMoviePath('ZeroClipboard.swf')
    # create client
    clip = new ZeroClipboard.Client()
    #event
    clip.addEventListener('mousedown',->
      clip.setText('Hello World')
    )
    clip.addEventListener('complete',(client,text) ->
      alert('copied: ' + text)
    )
    
    #glue it to the button
    clip.glue()