require 'rubygems'

input="7h%3.73%5%73t2.n125E514tFxe6%E5E72p%it95%%3_.%2a%%E2253m3Fm223F566pAfiFF9%2253"

#puts input
line=input[0,1].to_i
puts "number of line: "+line.to_s
input=input[1..-1]
puts "new input: "+input
col = input.length / line
puts "col size:"+col.to_s
puts "size :"+input.length.to_s
remainder= input.length%line
puts "remainder: "+remainder.to_s

result=''
base=0
box={}

for id in 1..line 
	if remainder > 0
        box[id]=input[base..base+col]
        base=base+col+1
        #puts remainder
    else
        box[id]=input[base..base+col-1]
	    base=base+col
    end
    remainder=remainder-1
    puts box[id] 
end


for index in 0..col
    for id in 1..line
        result<<box[id][index,1].to_s
    end
end
puts result
