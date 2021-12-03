using DelimitedFiles
import Statistics: mean


in_file = "input_3.txt"
report_string = open(in_file) do file
    readdlm(file, String)
end

# Change the array of 1x1000 strings into an maxtrix of int vectors
as_int = map(x ->  parse.(Int16, split(x, "")), report_string)
# Change 1D matrix of vectors into 2D matrix
report = hcat(as_int...) # ... means it concatenates everything in as_int along axis 2


# For part 1, the solutions are inversions of each other 
# The solution is really just the mean of the values in each column (didn't check in order of tie...)
function get_eps_gam(rep_arr)
    means = mean(rep_arr, dims=2);

    gamma_arr = round.(Int16, means)' # ' is transpose in Julia
    epsilon_arr = abs.(gamma_arr.-1)

    # Now convert to str and join 
    gamma_string = join(string.(gamma_arr))
    epsilon_string = join(string.(epsilon_arr))

    # read as binary
    gamma = parse(Int, gamma_string; base=2)
    epsilon = parse(Int, epsilon_string; base=2)

    gamma, epsilon

end


gamma, epsilon = get_eps_gam(report)
println("The solution to part one is: ", gamma*epsilon)

# Part 2 is more complicated
# we take the same array as part 1, but now have to filter by bit
# Take most common for 02, least for C02
function get_rating(rep_arr, rating_type) 

    mode = Dict("02" => 0.0, "C02" => 1.0)[rating_type] 
    
    found = false
    ind = 1
    while !found
        mean_ind = mean(rep_arr[ind,:])
        mean_ind = mean_ind - mode # minus 1 in C02 case to get least not most common

	# Rounding usually rounds to nearest even int in case of tie
        # We don't want this so change rounding mode
	median_ind = abs(round(Int16, mean_ind, RoundNearestTiesUp)) 
        if mean_ind != 1.0 && mean_ind != 1.0
            rep_arr = rep_arr[:,(rep_arr[ind,:] .== median_ind)]
        end
        if length(rep_arr[1,:]) == 1
            found = true
        else
            ind += 1
        end
    end
    
    last_standing = join(string.(rep_arr))
    parse(Int, last_standing; base=2)
    
end

rep_02 = get_rating(report, "02")
rep_C02 = get_rating(report, "C02")

println("The solution to part one is: ", rep_02*rep_C02)


