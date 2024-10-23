require 'rubygems'
require 'gosu'
require './circle'
require './bezier_curve'

# The screen has layers: Background, middle, top
module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

class DemoWindow < Gosu::Window
  def initialize
    super(640, 400, false)
    self.caption = "Spiderman Logo"
  end

  def draw
    # see www.rubydoc.info/github/gosu/gosu/Gosu/Color for colours
    #draw_quad(5, 10, Gosu::Color::BLUE, 200, 10, Gosu::Color::AQUA, 5, 150, Gosu::Color::FUCHSIA, 200, 150, Gosu::Color::RED, ZOrder::BACKGROUND)
    #draw_triangle(50, 50, Gosu::Color::GREEN, 100, 50, Gosu::Color::GREEN, 50, 100, Gosu::Color::GREEN, ZOrder::MIDDLE, mode=:default)
    #draw_line(200, 200, Gosu::Color::BLACK, 350, 350, Gosu::Color::BLACK, ZOrder::TOP, mode=:default)
    # draw_rect works a bit differently:
    #Gosu.draw_rect(300, 200, 100, 50, Gosu::Color::BLACK, ZOrder::TOP, mode=:default)
    Gosu.draw_rect(0,0,640,400,Gosu::Color::RED, z=0, mode=:default)

    #The WEB
    draw_quad(2,0,Gosu::Color::BLACK, 0,2, Gosu::Color::BLACK, 638,400, Gosu::Color::BLACK, 640,398, Gosu::Color::BLACK)
    draw_quad(0,398,Gosu::Color::BLACK, 2,400, Gosu::Color::BLACK, 640,2, Gosu::Color::BLACK, 638,0, Gosu::Color::BLACK)

    Gosu.draw_rect(321,0,4,400,Gosu::Color::BLACK, ZOrder:: MIDDLE, mode=:default)
    Gosu.draw_rect(0,198,640,4,Gosu::Color::BLACK, ZOrder:: MIDDLE, mode=:default)

    draw_curve(150,200,320,100,160,100,160,100,2,Gosu::Color::BLACK, 5)
    draw_curve(320,100,480,200,460,100,460,100,2,Gosu::Color::BLACK, 5)
    draw_curve(480,200,300,300,460,300,460,300,2,Gosu::Color::BLACK, 5)
    draw_curve(320,300,150,200,160,300,160,300,2,Gosu::Color::BLACK, 5)
    #draw_line(320,100, Gosu::Color::BLACK, 480,200, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
    #draw_line(480,200, Gosu::Color::BLACK, 320,300, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
    #draw_line(320,300, Gosu::Color::BLACK, 320,300, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
    # Circle parameter - Radius
    img2 = Gosu::Image.new(Circle.new(50))
    # Image draw parameters - x, y, z, horizontal scale (use for ovals), vertical scale (use for ovals), colour
    # Colour - use Gosu::Image::{Colour name} or .rgb({red},{green},{blue}) or .rgba({alpha}{red},{green},{blue},)
    # Note - alpha is used for transparency.
    # drawn as an elipse (0.5 width:)
    img2.draw(278, 200, ZOrder::MIDDLE, 0.9, 0.9, Gosu::Color::BLACK)
    img2.draw(298, 160, ZOrder::MIDDLE, 0.5, 0.5, Gosu::Color::BLACK)
    #First Pair
    draw_curve(310, 185, 310, 140, 280, 170, 280, 170, 2, Gosu::Color::BLACK, 6)
    draw_curve(330, 185, 330, 140, 360, 170, 360, 170, 2, Gosu::Color::BLACK, 6)
    #Second Pair 
    draw_curve(310, 195, 270, 110, 230, 175, 230, 175, 2, Gosu::Color::BLACK, 6)
    draw_curve(330, 195, 370, 110, 410, 175, 410, 175, 2, Gosu::Color::BLACK, 6)
    #Third Pair 
    draw_curve(310, 210, 220, 230, 280, 180, 290, 190, 2, Gosu::Color::BLACK, 6)
    draw_curve(330, 210, 420, 230, 360, 180, 370, 190, 2, Gosu::Color::BLACK, 6)
    # drawn as a red circle:
    #Fourth Pair
    draw_curve(310, 210, 190, 350, 210, 210, 290, 300, 2, Gosu::Color::BLACK, 6)
    draw_curve(330, 210, 450, 350, 430, 210, 350, 300, 2, Gosu::Color::BLACK, 6)
    #Fangs
    draw_triangle(330, 165, Gosu::Color::BLACK, 340, 165, Gosu::Color::BLACK, 330, 145, Gosu::Color::BLACK, ZOrder::TOP, mode=:default)
    draw_triangle(305, 165, Gosu::Color::BLACK, 315, 165, Gosu::Color::BLACK, 315, 145, Gosu::Color::BLACK, ZOrder::TOP, mode=:default)
  end
end

DemoWindow.new.show
