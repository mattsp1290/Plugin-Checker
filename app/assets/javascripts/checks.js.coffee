$(document).ready ->
  $('.browser').html navigator.userAgent
  $('.flash').html FlashDetect.raw
  $('.javaapplet').append ('<applet code="Tester.class" codebase="." align="baseline" width="0" height="0">No Java installed</applet>')
  $('.java').append ("You have the following JREs:")
  $('.java').append deployJava.getJREs()

