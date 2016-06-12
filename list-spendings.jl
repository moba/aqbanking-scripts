#!/usr/bin/env julia

using DataFrames

# read in the csv file into a DataFrame data-structure
full_csv = readtable("demo.csv", separator=';')

# only keep the relevant coloumns
relevant_subset = full_csv[[:purpose, :remoteName, :value_value]]

# resolve the stupud "250/100" string entries into: 2,50 Floats
amounts = @data([])
for i in relevant_subset[:value_value]
    cur_amount = convert(Float64 ,eval(parse(i)))
    push!(amounts, cur_amount)
end
relevant_subset[:value_value] = amounts

# only keep rows with negative values
relevant_subset = relevant_subset[relevant_subset[:value_value] .< 0 , :]

# sort according to money amount
sort!(relevant_subset, cols = [:value_value], rev = true)

# Print result (The DataFrames package automagically does
# pretty printing of DataFrames (i.e. Tables) :) )
println(relevant_subset)
