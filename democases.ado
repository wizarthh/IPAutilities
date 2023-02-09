/***
_version 1.0_ 

democases
===== 

This command generates N demo cases for a specified "cases.csv" for SurveyCTO. 

Syntax
------ 

> democases _filename_ _numobs_ _formname_

Using _filename_, set _numobs_ new democases, wich take _formname_ as its formid.

Description
-----------

*democases* is used to create N new false cases starting by the ID 10001, to be used in enumerator training or testing. Democases requires you to specify a .csv file so that the demo cases are created using the format of the .csv you are trying to test. It only generates ID, ID label, phones and interviewee_name, so it's use with *assignusers* is recommended for completing a cases csv.

Options
-------
none at the moment.
Comment: Maybe could include the options to specify variable names or number of phones.

Remarks
-------

__democases__ relies on the cases file being a .csv for SurveyCTO and containg the following variables:

	- id: First variable of the data set.
	- label: string variable for the ID, _democases_ uses the following format: "ID XXXXXX"
	- formids: string variable that contains the form's name.
	- phone_1 - phone_4: Numeric variables that will contain the fake numbers created by _democases_ 
	- contacts: numeric variable that stores the total number of phones a case has.
	- interviewee_name: String variable containing the name of the interviewee.
	
If all of this variables exist within the .csv file and belong to the specified types, democases should work perfectly. If an error where to arise it could be because of a type mismatch between one of this variables.

Example(s)
----------

    To create 200 demo cases for the "demo_form" form ID using a "cases.csv" in your working directory you should type:

        . democases "cases.csv" 200 "demo_form"

    If the cases file isn't on your working directory, you could specify it's location using the following format:

        . democases "X:\local\cases.csv" 500 "demo_form"

Stored results
--------------

The resulting demo cases should be stored in Stata's memory, so that you can proceed to assing user names or export the cases file as is. 

Author
------

Victor Herencia   
IPA    
vherencia@poverty-action.org    

- - -

***/




program define democases
    local docuname `1'
	local numobs `2'
    local formname `3'
	
	import delimited using "`docuname'", clear numericcols(1)

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


