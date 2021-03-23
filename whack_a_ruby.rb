require 'gosu'

class GameWindow < Gosu::Window
    def initialize
        super 800, 600, false
        self.caption = "Whack A Ruby"
        # Ruby Image Configuration
        @ruby = Gosu::Image.new("./media/ruby.png")
        @ruby_x = 25
        @ruby_y = 25
        @ruby_vx = 5
        @ruby_vy = 5
        @ruby_visible = 0
        # Hammer Image Configuration
        @hammer = Gosu::Image.new("./media/hammer.png")
    end

    def update
        @ruby_x += @ruby_vx
        @ruby_y += @ruby_vy
        # Ruby Reaches Edges
        if (@ruby_x -25 <= 0) or (@ruby_x + 25 >= 800)
            @ruby_vx *= -1
        end
        if (@ruby_y -25 <= 0) or (@ruby_y + 25 >= 600)
            @ruby_vy *= -1
        end
        # Ruby Random Visibility
        # Ruby Visible for 30 Frames, Invisible for at least 10 Frames
        @ruby_visible -= 1
        if (@ruby_visible < -10) and (rand < 0.01)
            @ruby_visible = 30
        end
    end

    def draw
        if (@ruby_visible > 0)
            @ruby.draw(@ruby_x - 25, @ruby_y - 25, z=1, 0.0625, 0.0625)
        end
        @hammer.draw(mouse_x - 25, mouse_y - 25, z=2, 0.0625, 0.0625)
    end
end

GameWindow.new.show