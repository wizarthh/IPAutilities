/***
_version 1.0_ 

XXX
===== 

explain the XXX command briefly...

Syntax
------ 

> __XXX__ _varlist_ =_exp_ [_if_] [_in_] 
[_weight_] using _filename_ [, _options_]

| _option_          |  _Description_          |
|:------------------|:------------------------|
| **em**phasize     | explain whatever does   |
| **opt**ion(_arg_) | explain whatever does   |


Description
-----------

describe __XXX__ in more details ...

Options
-------

describe the options in details, if the options table is not enough

Remarks
-------

discuss the technical details about __XXX__, if there is any

Example(s)
----------

    explain what it does

        . XXX example command

    second explanation

        . XXX example command

Stored results
--------------

describe the Scalars, Matrices, Macros, stored by __XXX__, for example:

### Scalars

> __r(level)__: explain what the scalar does 

### Matrices

> __r(table)__: explain what it includes

Functions

Acknowledgements
----------------

If you have thanks specific to this command, put them here.

Author
------

leave 2 white spaces at the end of each line for line break. For example:

Your Name   
Your affiliation    
Your email address, etc.    

License
-------

Specify the license of the software

References
----------

Author Name (year), [title & external link](https://github.com/haghish/markdoc/)

- - -

This help file was dynamically produced by 
[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/) 
***/



/***
_version 1.0_ 

XXX
===== 

explain the XXX command briefly...

Syntax
------ 

> __XXX__ _varlist_ =_exp_ [_if_] [_in_] 
[_weight_] using _filename_ [, _options_]

| _option_          |  _Description_          |
|:------------------|:------------------------|
| **em**phasize     | explain whatever does   |
| **opt**ion(_arg_) | explain whatever does   |


Description
-----------

describe __XXX__ in more details ...

Options
-------

describe the options in details, if the options table is not enough

Remarks
-------

discuss the technical details about __XXX__, if there is any

Example(s)
----------

    explain what it does

        . XXX example command

    second explanation

        . XXX example command

Stored results
--------------

describe the Scalars, Matrices, Macros, stored by __XXX__, for example:

### Scalars

> __r(level)__: explain what the scalar does 

### Matrices

> __r(table)__: explain what it includes

Functions

Acknowledgements
----------------

If you have thanks specific to this command, put them here.

Author
------

leave 2 white spaces at the end of each line for line break. For example:

Your Name   
Your affiliation    
Your email address, etc.    

License
-------

Specify the license of the software

References
----------

Author Name (year), [title & external link](https://github.com/haghish/markdoc/)

- - -

This help file was dynamically produced by 
[MarkDoc Literate Programming package](http://www.haghish.com/markdoc/) 
***/




program define democases
    local docuname `1'
	local numobs `2'
    local formname `3'
	
	import delimited using "`docuname'", clear

drop if _n >= 1

set obs `numobs'

replace id = 10000 + _n

gen b_label = "ID"

egen a_label = concat(b_label id), punct(" ") 
replace label = a_label
drop a_label b_label

replace formids = "`formname'"

local nums 11111111 22222222 33333333 44444444
local obstot = 10000 + _N

forvalues id = 1001/`obstot' {
	local a = 4*runiform() + 1
	local cont = 1
	foreach v of local nums{
		
		forvalues i = `cont'/`a'{
		
			replace phone_`i' = `v' if id == `id'
		}
		local cont = `cont' + 1
		
	}
	}

if `numobs' < 12 {
	local a = `numobs'
}

else {
	local a = 12
}

gen nomb_1 = ""
generate rannum = uniform()
egen grp2 = cut(rannum), group(`a')
	local nomb `" "Rosa" "Marco" "ADRIAN" "Kelly" "Guillermo" "Víctor" "Nicolas" "Ursula" "Aurora" "Braulio" "Jose" "Juan" "'
	local cont = 0
	foreach v of local nomb{
		
		replace nomb_1 = "`v'"     if grp2 == `cont'
		local cont = `cont' + 1
		
	}
drop rannum grp2

gen apelli_1 = ""
generate rannum = uniform()
egen grp2 = cut(rannum), group(`a')
	local nomb `" "Rojas" "Condor" "Montaño" "Herencia" "Monzón" "Pantoja" "Arteaga" "Delgado" "Condori" "Huamani" "Ruiz" "Miranda" "'
	local cont = 0
	foreach v of local nomb{
		
		replace apelli_1 = "`v'"     if grp2 == `cont'
		local cont = `cont' + 1
		
	}
drop rannum grp2

egen a_label = concat(nomb_1 apelli_1), punct(" ")
replace interviewee_name = a_label

drop a_label nomb_1 apelli_1

	
replace interviewee_name = ustrregexra(strupper( ustrregexra( ustrnormalize(trim(itrim(interviewee_name)), "nfd" ) , "\p{Mark}", "" ) ), "[^A-Z \s]", "")

egen a_contacts = rownonmiss(phone_?)
replace contacts = a_contacts
drop a_contacts
	
end


