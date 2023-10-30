
//cap prog drop assignusers
prog define assignusers
    local nombres "`1'"
    local field_name `2'
	
foreach name of local nombres {
	local name = ustrupper(ustrregexra( ustrnormalize( "`name'", "nfd" ) , "\p{Mark}", "" ) )
	local inicial = substr("`name'", 1, 1)
    local pos = strpos("`name'", " ") + 1
    local name = substr("`name'", `pos', .)
	local usr_pre = "`inicial'" + "`name'"
    local newlist `newlist' `usr_pre'
}

local newlist_1 `newlist'



foreach v of local newlist {
	local count 0
	foreach i of local newlist_1 {
		if ("`v'" == "`i'") {
			local count = `count' + 1
			local quito "`i'"
		}
	}
	
	local newcountlist `newcountlist' `count'
	local newlist_1: list newlist_1 - quito
	
}

local count 0

foreach v of local newcountlist {
	local count = `count' + 1
	local newuser: word `count' of `nombres'
	
	local newuser = ustrlower(ustrregexra( ustrnormalize( "`newuser'", "nfd" ) , "\p{Mark}", "" ) )
	local inicial = substr("`newuser'", 1, `v')
    local pos = strpos("`newuser'", " ") + 1
    local name = substr("`newuser'", `pos', .)
	local new_usr_pre = "`inicial'" + "`name'"
    local newlistdef `newlistdef' `new_usr_pre'
}

di "`newlistdef'"

local cont = 0

foreach v of local nombres {
	local cont = `cont' + 1
}

set seed 12345
generate rannum = uniform()
egen grp2 = cut(rannum), group(`cont')

		local cont_1 = 0
	foreach v of local nombres{
		
		replace `field_name' = "`v'"     if grp2 == `cont_1'
		local cont_1 = `cont_1' + 1
		
	}
replace `field_name' = ustrupper(ustrregexra( ustrnormalize( `field_name', "nfd" ) , "\p{Mark}", "" ) )

		local cont_1 = 0
	foreach v of local newlistdef{
		
		replace users = "`v'"     if grp2 == `cont_1'
		local cont_1 = `cont_1' + 1
	}

drop rannum grp2

end
