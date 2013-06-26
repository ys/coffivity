class StatusView < NSView
  attr_accessor :statusItem, :isPlaying, :menu, :audioPlayer

  def drawRect(dirtyRect)
    self.statusItem.drawStatusBarBackgroundInRect dirtyRect, withHighlight: false

    icon = self.isPlaying ? self.playImage : self.pauseImage
    iconSize = icon.size
    bounds = self.bounds
    iconX = ((NSWidth(bounds) - iconSize.width) / 2).round
    iconY = ((NSHeight(bounds) - iconSize.height) / 2).round
    iconPoint = NSMakePoint(iconX, iconY)

    icon.drawAtPoint iconPoint, fromRect: NSZeroRect,  operation: NSCompositeSourceOver, fraction: 1.0
  end

  def statusItem=(item)
    @statusItem = item
    @statusItem.view = self
  end


  def playImage
    @image ||= NSImage.imageNamed "play"
    @image.setSize(NSMakeSize(16, 16))
    @image
  end

  def pauseImage
    @alternate_img ||= NSImage.imageNamed "pause"
    @alternate_img.setSize(NSMakeSize(16, 16))
    @alternate_img
  end

  def mouseDown(event)
    if @audioPlayer.isPlaying
      pauseMusic
    else
      playMusic
    end
    self.setNeedsDisplay true
  end

  def playMusic
    @audioPlayer.play
    @isPlaying = true
  end

  def pauseMusic
    @audioPlayer.pause
    @isPlaying = false
  end

  def rightMouseDown(event)
    showMenu
  end

  def showMenu
    statusItem.popUpStatusItemMenu @menu
    self.setNeedsDisplay true
  end
end
