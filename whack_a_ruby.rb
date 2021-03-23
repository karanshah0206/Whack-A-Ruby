require 'gosu'

class GameWindow < Gosu::Window
    def initialize
        super 800, 600, false
        self.caption = "Whack A Ruby"
        # Ruby Image Configuration
        @ruby = Gosu::Image.new("./media/ruby.png")
        @ruby_x = 25
        @ruby_y = 25
    end

    def draw
        @ruby.draw(@ruby_x - 25, @ruby_y - 25, z=1, 0.0625, 0.0625)
    end
end

GameWindow.new.show