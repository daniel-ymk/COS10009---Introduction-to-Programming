require "gosu"

WIDTH, HEIGHT = 1000, 1000
GRID = 100
WIDTH_IN_GRID = WIDTH / GRID
HEIGHT_IN_GRID = HEIGHT / GRID
PIXELS_MOVED = 10

module ZOrder
    BACKGROUND, MIDDLE, TOP = *0..2
end

module ScreenType
    MAIN_MENU, GAME, GAMEOVER = *0..3
end

class SnakeGame < Gosu::Window
    def initialize
        super WIDTH, HEIGHT, false, 1000 / 60
        self.caption = "Snake Game"

        #All classes initialized
        @snake = Snake.new(self)  # Pass reference to self (the SnakeGame window)
        @fruit = Fruit.new
        @pixels = Background_Pixel.new
        @screen_type = ScreenType::MAIN_MENU

        @score = 0
        @highest_score = 0

        # Initialize font
        @font = Gosu::Font.new(100)

        #sound effects
        @eat_sound = Gosu::Sample.new("sounds/eat.mp3")
        @background_music = Gosu::Song.new("sounds/background_music.mp3") 
        @background_music.volume = 0.5
        @background_music.play(true)
    end

    def update
        case @screen_type
        when ScreenType::GAME  #if it is game screen update snake and fruit
            @snake.update
            @fruit.update
            if @snake.snake_x == @fruit.fruit_x && @snake.snake_y == @fruit.fruit_y
                @score += 1
                @snake.grow
                @eat_sound.play
                @fruit.generate_fruit(@snake.position)
            end
        end
    end

    def draw
        draw_background

        case @screen_type
        when ScreenType::MAIN_MENU
            draw_main_menu
        when ScreenType::GAME
            draw_game_screen
        when ScreenType::GAMEOVER
            draw_game_over
        end
    end

    def draw_main_menu
        start_image = Gosu::Image.new("images/Start.jpg")
        start_image.draw(250, 250, ZOrder::TOP, scale_x = 1.8, scale_y = 0.75)

        @font.draw_text("Start", 450, 275, ZOrder::TOP, 0.75, 0.75, Gosu::Color::BLACK)
        start_image.draw(250, 600,  ZOrder::TOP, scale_x = 1.8, scale_y = 0.75)
        @font.draw_text("Highest Score: #{@highest_score}", 350, 650, ZOrder::TOP, 0.5, 0.5, Gosu::Color::BLACK)

        if mouse_on_area?(250, 750, 250, 375) && Gosu.button_down?(Gosu::MsLeft)
            @screen_type = ScreenType::GAME
            reset_game()
        end
    end

    def draw_game_screen
        @snake.draw
        @fruit.draw
        @font.draw_text("Score: #{@score}", 10, 10, ZOrder::TOP, 0.25, 0.25, Gosu::Color::BLACK)
    end

    def draw_game_over
        # Background
        Gosu.draw_rect(WIDTH/2 -375, 125, 750, 375, Gosu::Color::BLACK, ZOrder::TOP)

        # GameOver text        
        if @score == 97
            @font.draw_text("You Won", 250, 200, ZOrder::TOP, 0.25, 0.25, Gosu::Color::GREEN)
        else
            @font.draw_text("Game Over", 250, 200, ZOrder::TOP, 0.25, 0.25, Gosu::Color::RED)
        end
        # Score
        @font.draw_text("Score: #{@score}    Highest Score: #{@highest_score}", 250, 275, ZOrder::TOP, 0.25, 0.25, Gosu::Color::WHITE)

        
        # Play Again
        @font.draw_text("Press Space to Play Again", 250, 350, ZOrder::TOP, 0.25, 0.25, Gosu::Color::WHITE)
        @font.draw_text("Or Esc to exit to Menu", 250, 425, ZOrder::TOP, 0.25, 0.25, Gosu::Color::WHITE)

    end

    def mouse_on_area?(x1, x2, y1, y2) #To check if the mouse is on something
        mouse_x.between?(x1, x2) && mouse_y.between?(y1, y2)
    end

    def draw_background     #Just a white background
        Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::WHITE, ZOrder::BACKGROUND)
        @pixels.draw
    end

    def button_down(id)
        case id
        when Gosu::KbUp then @snake.up
        when Gosu::KbDown then @snake.down
        when Gosu::KbLeft then @snake.left
        when Gosu::KbRight then @snake.right
        when Gosu::KbSpace
            if @screen_type == ScreenType::GAMEOVER || @screen_type == ScreenType::MAIN_MENU
                reset_game()
                @screen_type = ScreenType::GAME
            end
        
        when Gosu::KbEscape 
            if @screen_type == ScreenType::GAMEOVER
                @screen_type = ScreenType::MAIN_MENU
            end
        end
    end

    def reset_game #reset
        @score = 0
        @snake = Snake.new(self)
        @fruit = Fruit.new
    end

    def game_over
        if @score > @highest_score
            @highest_score = @score  #update highest if scored is higher
        end
        @screen_type = ScreenType::GAMEOVER #draw gameover

    end
end
#Background pixel format
#     1 0 1 0 1 0 1 0
#     0 1 0 1 0 1 0 1
#     1 0 1 0 1 0 1 0
#think 1s as green and 0 as white
class Background_Pixel
    attr_accessor :pixel_x, :pixel_y

    def initialize
        @pixel_x = 0
        @pixel_y = 0
    end

    def draw
        #drawing the first row and then skipping 1 row
        #  1 0 1 0 1 0 1
        #  
        #  1 0 1 0 1 0 1
        #  
        @pixel_y = 0
        while @pixel_y < HEIGHT
            @pixel_x = 0
            while @pixel_x < WIDTH
                Gosu.draw_rect(@pixel_x, @pixel_y, GRID, GRID, Gosu::Color.argb(0xff_6aff4d), ZOrder::MIDDLE)
                @pixel_x += GRID * 2  # draw the pixels in 10101010101010 format
            end
            @pixel_y += GRID * 2
        end
        
        #start drawing from the second row and the skipping 1 row 
        # 
        #  0 1 0 1 0 1
        # 
        #  0 1 0 1 0 1
        @pixel_y = GRID
        while @pixel_y < HEIGHT
            @pixel_x = GRID
            while @pixel_x < WIDTH
                Gosu.draw_rect(@pixel_x, @pixel_y, GRID, GRID, Gosu::Color.argb(0xff_6aff4d), ZOrder::MIDDLE)
                @pixel_x += GRID * 2
            end
            @pixel_y += GRID * 2
        end
    end
end

class Snake
    attr_accessor :snake_x, :snake_y
    attr_reader :position

    def initialize(window)
        @window = window  # Store reference to window
        @snake_x = GRID - PIXELS_MOVED # Start from Grid 
        @snake_y = HEIGHT / 2

        @move_x = PIXELS_MOVED #start by moving right
        @move_y = 0

        @tail = GRID/PIXELS_MOVED + 1 #pixels moved per each clock cycle 1 pixel for the first clock
        @position = []

        @new_direction = nil # Add new_direction attribute
        @hit_sound = Gosu::Sample.new("sounds/game_over.mp3")
    end

    def update
        @snake_x += @move_x
        @snake_y += @move_y

        # Change direction if a new direction is set and the snake is aligned with the grid
        if @snake_x % GRID == 0 && @snake_y % GRID == 0 && @new_direction
            change_direction()
        end

        #game_over when snake hits the border
        if @snake_x < 0 || @snake_x >= WIDTH || @snake_y < 0 || @snake_y >= HEIGHT
            @hit_sound.play
            @window.game_over
        end

        if @position.size > 11 #the snake needs 4 squares to hit itself
            @position.each do |pos|  #each element of position checked using pos block element
                if pos == [@snake_x, @snake_y]
                    @hit_sound.play
                    @window.game_over
                end
            end
        end
        
        @position << [@snake_x, @snake_y]             #add the head to the position
        #shifting makes the snake seem like moving 
        @position.shift until @position.size <= @tail   #position cannot be longer than the tail meaning
    end

    def draw
        @position.each do |snake_x, snake_y| #draw each coordinate of the snake in the array
            Gosu.draw_rect(snake_x, snake_y, GRID, GRID, Gosu::Color::BLUE, ZOrder::TOP)
        end
    end

    def grow
        @tail += GRID/ PIXELS_MOVED
    end

    def moving_horizonal?
        if @move_y == 0     #vertical is 0
            return true     #so it is travelling horizonatally
        else
            return false    #vertical is not 0 --> travelling vertically
        end
    end

    def up
        if @snake_x %GRID != 0 
        @snake_y += PIXELS_MOVED #to cancel out the first clock
        end

        if moving_horizonal?()  #go up only if it is travelling horizontally
            while @snake_x %GRID != 0 
                if @move_x == PIXELS_MOVED     #moving right
                    @snake_x += PIXELS_MOVED   #fill the grid quick
                else                           # moving left
                    @snake_x -= PIXELS_MOVED   #fill the grid quick
                end
            end
            @move_x = 0
            @move_y = -PIXELS_MOVED             #go up
        end
    end
    
    
    def down
        if @snake_x %GRID != 0 
            @snake_y -= PIXELS_MOVED #to cancel out the first clock 
        end
        if moving_horizonal?()     #go down only if it is travelling horizontally
            while @snake_x %GRID != 0  
                if @move_x == PIXELS_MOVED     #moving right
                    @snake_x += PIXELS_MOVED;   #fill grid right
                else                            #moving left
                    @snake_x -= PIXELS_MOVED    #fill grid left
                end
            end
            @move_x = 0;
            @move_y = PIXELS_MOVED;             #go down
        end
    end



    def left
        if  @snake_y %GRID != 0
            @snake_x += PIXELS_MOVED #to cancel out the first clock
        end
        if moving_horizonal?() != true   #go left only if it is travelling vertically
            while @snake_y %GRID != 0 
                if @move_y == PIXELS_MOVED    #going down
                    @snake_y += PIXELS_MOVED;   #fill down grid
                else                            #going up
                    @snake_y -= PIXELS_MOVED    #fill up grid
                end
            end
            @move_y = 0;  
            @move_x = -PIXELS_MOVED         #go left
        end
    end
    
    def right
        if  @snake_y %GRID != 0
            @snake_x -= PIXELS_MOVED #to cancel out the first clock
        end
        if moving_horizonal?() != true  #go right only if it is travelling vertically
            while @snake_y %GRID != 0       
                if @move_y == PIXELS_MOVED      #moving down
                    @snake_y += PIXELS_MOVED;   #fill down
                else                            #moving up
                    @snake_y -= PIXELS_MOVED    #fill up
                end
            end
            @move_y = 0;        
            @move_x = PIXELS_MOVED;             #go right
        end
    end
end

class Fruit
    attr_accessor :fruit_x, :fruit_y

    def initialize
        @fruit_x = WIDTH / 2
        @fruit_y = HEIGHT / 2
    end

    def update
    end

    def draw
        fruit_image = Gosu::Image.new("images/Apple.png")
        fruit_image.draw(@fruit_x + 5, @fruit_y + 5, ZOrder::TOP, scale_x = 0.4, scale_y = 0.4)
        #Gosu.draw_rect(@fruit_x + 20, @fruit_y + 20, GRID - 40, GRID - 40, Gosu::Color::RED, ZOrder::MIDDLE)
    end

    def generate_fruit(snake_position)
        begin 
            temp_x = rand(WIDTH_IN_GRID) * GRID
            temp_y = rand(HEIGHT_IN_GRID) * GRID
        end while overlap_fruit_snake?(snake_position, temp_x, temp_y)   #check if it is on snake then regenerate
 
        @fruit_x = temp_x
        @fruit_y = temp_y
        
    end

    def overlap_fruit_snake?(snake_position,x, y)           #snake and fruit touch
        snake_position.each do |pos|
          return true if pos == [x, y]
        end
        false
    end
end

SnakeGame.new.show
