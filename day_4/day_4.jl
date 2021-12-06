using CSV
using DataFrames

in_file = "input_4.txt"
in_nums = Matrix(CSV.read(in_file, DataFrame, delim = ',', limit = 1, header = false))


in_tables = Matrix(CSV.read(in_file, DataFrame, skipto = 2, delim = " ", header = false, ignorerepeated= true))
in_tables = permutedims(reshape(in_tables, (5, 100, 5)), [2,1,3]);

# Changes numbers to -1 if they have been called
# When a board wins it will have a column/row that sums to -5
function find_winner(tables, nums)
    for n in nums
        tables = replace(tables, n=>-1)
    
        if any(sum(tables, dims = 2) .== -5)
            ind = findmin(sum(tables, dims = 2))[2][1]
            return sum(replace(tables[ind,:,:],-1=>0))*n
        end
    
        if any(sum(tables, dims = 3) .== -5)
            ind = findmin(sum(tables, dims = 3))[2][1]
            return sum(replace(tables[ind,:,:],-1=>0))*n 
        end
    
    end
end


# I tried being clever and search from the back, but ended having to subtract 1 in many places, which gets a bit ugly. 
function find_last_winner(tables, nums)

    tables = -1*tables .-1 # -1 because I use the fact that numbers are pos/neg to find bingo, and 0 is neither 

    nums = reverse(-1*nums .-1) # Search from the back and correct for -1 

    for (i, n) in enumerate(nums)
        tables = replace(tables, n=>-1*n)

	# Basically just ask whether all boards win
        # As we start at the back all boards are winners and we find the point where one stops winning. 
        condition = all(sum(sign.(tables), dims = 2) .!= -5, dims = 3) .&& all(sum(sign.(tables), dims = 3) .!= -5, dims = 2)
        
        if any(condition)
            ind = findall(condition)[1][1]
	    # ugly corrections to make up for using negative numbers
            tab = replace(tables[ind,:,:], -1*n=> n)
            tab = replace(x -> sign(x) == -1 ? 0 : x, tab.-1) 
            return sum(tab)*(-1*n - 1)
        end

    end
end




println("The solution to part one is: ", find_winner(in_tables, in_nums))
println("The solution to part two is: ", find_last_winner(in_tables, in_nums))
