using CSV
using DataFrames

in_file = "input_4.txt"
nums = Matrix(CSV.read(in_file, DataFrame, delim = ',', limit = 1, header = false))


in_tables = Matrix(CSV.read(in_file, DataFrame, skipto = 2, delim = " ", header = false, ignorerepeated= true))
in_tables = permutedims(reshape(in_tables, (5, 100, 5)), [2,1,3]);


function find_winner(tables)
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


println("The solution to part one is: ", find_winner(in_tables))
