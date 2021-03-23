require 'gosu'

class GameWindow < Gosu::Window
    def initialize
        super 800, 600, false
        self.caption = "Whack A Ruby"
    end
end

GameWindow.new.show