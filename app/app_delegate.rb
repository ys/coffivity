class AppDelegate
  def applicationDidFinishLaunching(notification)
    status = NSStatusBar.systemStatusBar
    @item = status.statusItemWithLength(NSSquareStatusItemLength)
    @statusView = StatusView.alloc.initWithFrame [[0.0, 0.0],[16.0, 16.0]]
    @statusView.statusItem = @item
    @item.setHighlightMode true
    menu.addItemWithTitle('Quit', action: 'terminate:', keyEquivalent: 'q')
    path = NSBundle.mainBundle.pathForResource('coffivity', ofType: 'mp3')
    file = NSURL.URLWithString path
    @audioPlayer = AVAudioPlayer.alloc.initWithContentsOfURL(file, error: nil)
    @audioPlayer.prepareToPlay
    @audioPlayer.numberOfLoops = -1
    @statusView.menu = menu
    @statusView.audioPlayer = @audioPlayer
  end

  def menu
    @menu ||= NSMenu.new
  end

  def play(event)
    @audioPlayer.play
  end

  def pause(event)
    @audioPlayer.pause
  end
end

