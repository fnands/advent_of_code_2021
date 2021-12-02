using DelimitedFiles

in_file = "input_2.txt"
commands = open(in_file) do file
    readdlm(file) # Automatically reads it to a 1000x2 matrix, neat
    # also infers type of inputs!
end



# Iterates through instructions and adds to depth
# or horizontal depending on instruction
function one(instructions)
    horizontal = 0
    depth = 0
    # Julia is column major, so doing by row is inefficient
    # Just for future reference
    for (inst, amount) in eachrow(instructions) 
        if inst == "forward"
            horizontal += amount
        elseif inst == "up"
            depth -= amount
        elseif inst == "down"
            depth += amount
        end

    end
    depth, horizontal
end

# Similar to one, but now updates aim, which influences
# depth, because submarine
function two(instructions)
    horizontal = 0
    depth = 0
    aim = 0
    for (inst, amount) in eachrow(instructions) 
        if inst == "forward"
            horizontal +=  amount
            depth += amount*aim
        elseif inst == "up"
            aim -= amount
        elseif inst == "down"
            aim += amount
        end
    end
    depth, horizontal
end


println("The solution to part one is ", one(commands))
println("The solution to part two is ", two(commands))

