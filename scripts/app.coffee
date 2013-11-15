---
---

jQuery ->
  thumbs = jQuery('.thumb')
  imageContainer = jQuery('<div class="image"></div>')
  image = jQuery('<img />').appendTo(imageContainer)

  closeImage = ->
    thumbs.removeClass('current')
    jQuery('body').removeClass('show-image')

  nextImage = ->
    jQuery('.thumb.current').nextAll('.thumb').first().click()

  prevImage = ->
    jQuery('.thumb.current').prev().click()

  markLastInRow = ->
    thumbs.removeClass('last-in-row')
    theTop = 0
    thumbs.each ->
      elementTop = jQuery(@).position().top
      if theTop != elementTop
        jQuery(@).prev().addClass('last-in-row')
        theTop = elementTop
    thumbs.last().addClass('last-in-row')

  markLastInRow()
  jQuery(window).resize ->
    closeImage()
    markLastInRow()

  thumbs.click ->
    thumb = jQuery(@)
    unless thumb.hasClass('current')
      thumb.addClass('current').siblings('.current').removeClass('current')
      image.attr('src', thumb.find('img').data('image'))
      lastInRow = if thumb.hasClass('last-in-row') then thumb else thumb.nextAll('.last-in-row').first()
      if imageContainer.prev()[0] != lastInRow[0]
        lastInRow.after(imageContainer)
        $('html,body').animate({scrollTop: thumb.position().top - 5}, 'slow')
      jQuery('body').addClass('show-image')

  image.click nextImage

  jQuery('body').keypress (event) ->
    switch event.keyCode
      when 27 then closeImage()
      when 39 then nextImage()
      when 37 then prevImage()
