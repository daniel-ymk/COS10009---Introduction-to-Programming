# # Acknowledgement to the original authors of the code on which this 
# # example is based.
import pygame

pygame.init()

SCREEN_HEIGHT = 400
SCREEN_WIDTH = 400

screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
done = False
is_blue = True
x = 30
y = 30

time = pygame.time
clock = pygame.time.Clock()

while not done:
    clock.tick(60)
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True
        if event.type == pygame.KEYDOWN and event.key == pygame.K_SPACE:
            is_blue = not is_blue

    pressed = pygame.key.get_pressed()

    if pressed[pygame.K_LEFT]:
        x -= 3
    if pressed[pygame.K_RIGHT]:
        x += 3
    if pressed[pygame.K_UP]:
        y -= 3
    if pressed[pygame.K_DOWN]:
        y += 3

    # Ensure the shape does not move out of the window area
    x = max(0, min(x, SCREEN_WIDTH - 60))
    y = max(0, min(y, SCREEN_HEIGHT - 60))

    print(f"x is {x} y is {y} timer is {time.get_ticks()}")

    screen.fill((0, 0, 0))
    if is_blue: color = (0, 128, 255)  
    else: (255, 100, 0)

    rect = pygame.Rect(x, y, 60, 60)
    pygame.draw.rect(screen, color, rect)

    pygame.display.flip()
