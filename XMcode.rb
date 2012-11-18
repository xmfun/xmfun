module XMcode

    def inilialize()
    end
    
    def XMcode.decode(input)
        line=input[0,1].to_i
        input=input[1..-1]
        col = input.length / line
        remainder= input.length%line
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
            #puts box[id] 
        end    
    
        for index in 0..col
            for id in 1..line
                result<<box[id][index,1].to_s
            end
        end
        
        result = result.gsub('%2F','/')
        result = result.gsub('%3A',':')
        result = result.gsub('%5E','0')
        result = result.gsub('%25','%')
        
        return result
    end 
end           

