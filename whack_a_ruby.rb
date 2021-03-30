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
        # Click Event Variable
        @hit = 0
        # Score
        @font = Gosu::Font.new(self, "Comic Sans MS", 30)
        @score = 0
        # Restart
        @start_time = 0
    end

    def update
        # Maintain Velocity
        @ruby_x += @ruby_vx
        @ruby_y += @ruby_vy
        # Ruby Reaches Edges
        if (@ruby_x -25 <= 0) or (@ruby_x + 25 >= 800)
            @ruby_vx *= -1
        end
        if (@ruby_y -25 <= 0) or (@ruby_y + 25 >= 600)
            @ruby_vy *= -1
        end
        # Ruby Visible for 30 Frames, Invisible for at least 10 Frames
        @ruby_visible -= 1
        if (@ruby_visible < -10) and (rand < 0.01)
            @ruby_visible = 30
        end
        # Timing
        @time_left = (60 - (Gosu.milliseconds/1000 - @start_time))
        if (@time_left < 0)
            @ruby_vx = 0
            @ruby_vy = 0
            @ruby_visible = 1
        end
    end

    def button_down(id)
        # Click Event Functionality + Scoring
        if (id == Gosu::MsLeft) and (@time_left >= 0)
            if (Gosu.distance(mouse_x, mouse_y, @ruby_x, @ruby_y) < 50) and (@ruby_visible >= 0)
                @hit = 1
                @score += 5
            else
                @hit = -1
                @score -= 1
            end
        end
        # Game Restart
        if (id == Gosu::KbSpace) and (@time_left < 0)
            @ruby_x = 25
            @ruby_y = 25
            @ruby_vx = 5
            @ruby_vy = 5
            @ruby_visible = 0
            @score = 0
            @hit = 0
            @start_time = Gosu.milliseconds/1000
        end
    end
    
    def needs_cursor?
        false
    end

    def draw
        # Draw Ruby If Visible
        if (@ruby_visible > 0)
            @ruby.draw(@ruby_x - 25, @ruby_y - 25, z=1, 0.0625, 0.0625)
        end
        # Hammer Traces Cursor
        @hammer.draw(mouse_x - 25, mouse_y - 25, z=2, 0.0625, 0.0625)
        # Background Based On Hit Status
        case @hit
        when -1
            Gosu.draw_rect(0,0,800,600,0xff_ff0000,z=0)
        when 1
            Gosu.draw_rect(0,0,800,600,0xff_00ff00,z=0)
        else
            Gosu.draw_rect(0,0,800,600,Gosu::Color::NONE,z=0)
        end
        # Reset Hit Status
        @hit = 0
        # Display Points
        @font.draw_text("Score: #{@score.to_s}", 650, 20, 3)
        if (@time_left >= 0)
            @font.draw_text("Time: #{@time_left.to_s}", 20, 20, 3)
        else
            # Game Over
            @font.draw_text("Time's Up!", 20, 20, 3)
            @font.draw_text("Press Space Bar To Play Again!", 250, 285, 3)
        end
    end
end

GameWindow.new.show
