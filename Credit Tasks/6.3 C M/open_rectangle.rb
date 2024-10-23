

def draw_open_rec(start_x, start_y, end_x, end_y, cp_start_x, cp_start_y, cp_end_x, cp_end_y, z, colour, thickness)

    i = 0

    while i < thickness

        t = 0.0

        points = []

        while t < 1.0

        px = (((1 - t) ** 3) * start_x) + (3 * t * ((1 - t) ** 2) * cp_start_x) + (3 * t * t * (1 - t) * cp_end_x) + ((t ** 3) * end_x)

        py = (((1 - t) ** 3) * start_y) + (3 * t * ((1 - t) ** 2) * cp_start_y) + (3 * t * t * (1 - t) * cp_end_y) + ((t ** 3) * end_y)

        points << [px, py]

        t += 0.001

        end

        points.inject(points[0]) do |last, point|

            draw_line last[0],last[1], colour,

                    point[0],point[1], colour,

                    z

            point

        end

        i += 1

        start_x += 1

        end_x += 1

        cp_start_x += 1 

        cp_end_x += 1

    end

end

