jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/ko_KR/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: '<%= ENV["FACEBOOK_APP_ID"] %>', cookie: true)

  $('#login').click (e) ->
    e.preventDefault()
    FB.login (response) ->
      window.location = '/users/auth/facebook/callback' if response.authResponse
    , scope: "email, publish_actions"


  $('#logout').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true

  if $('#logout').length > 0
    FB.getLoginStatus (response) ->
      window.location = $('#logout').attr('href') if !response.authResponse