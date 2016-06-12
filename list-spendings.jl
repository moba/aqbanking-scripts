#!/usr/bin/env julia

using DataFrames
using ArgParse

cli_args = ArgParseSettings()
@add_arg_table cli_args begin
    "input_csv_file"
        help = "The transactions csv file to extract the spendings from"
        required = true
        arg_type = UTF8String
end
parsed_args = parse_args(cli_args)

# read in the csv file into a DataFrame data-structure
full_csv = readtable(parsed_args["input_csv_file"], separator=';')

# only keep the relevant coloumns
relevant_subset = full_csv[[:purpose, :remoteName, :value_value]]

# resolve the stupud "250/100" string entries into: 2,50 Floats
amounts = @data([])
for i in relevant_subset[:value_value]
    cur_amount = convert(Float64 ,eval(parse(i)))
    # Jep, we're directly evaluating user input here, YOLO
    push!(amounts, cur_amount)
end
relevant_subset[:value_value] = amounts

# only keep rows with negative values
relevant_subset = relevant_subset[relevant_subset[:value_value] .< 0 , :]

# sort according to money amount
sort!(relevant_subset, cols = [:value_value], rev = true)

# Print result (The DataFrames package automagically does
# pretty printing of DataFrames (i.e. Tables) :) )
print(relevant_subset)
