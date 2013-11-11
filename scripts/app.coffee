---
---


jQuery ->
  thumbs = jQuery('.thumb')
  imageContainer = jQuery('<div class="image"></div>')

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
    imageContainer.hide()
    markLastInRow()

  thumbs.click ->
    jQuery(@).nextAll('.last-in-row').first()
      .after(imageContainer.show())
