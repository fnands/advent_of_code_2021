using DelimitedFiles

in_file = "input_1.txt"

# can dump the entire file's values to array
depths = open(in_file) do file
    readdlm(file, Int16)
end

# Function one takes the depth readings and increments 
#if the read value is larger than the previous one
function one(readings)
    prev = 0
    counter = -1 # to make up for the fact that it will count the first value
    for d in readings
       if d > prev
            counter += 1 # increment like Python
        end
        prev = d
    end
    counter # Julia returns the last expression you evaluate
end
    
# Function two sums in a slideing window of three and 
# then calls function one 
function two(readings)
    slid = (sum(depths[x:x+2]) for x in 1:length(readings)-2)
    one(slid)
end


println("The solution to part one is ", one(depths))
println("The solution to part two is ", two(depths))


