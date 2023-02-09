{smcl}
{it:version 1.0} 


{title:democases}

{p 4 4 2}
This command generates N demo cases for a specified "cases.csv" for SurveyCTO. 


{title:Syntax}

{p 8 8 2} {bf:democases} {it:filename} {it:numobs} {it:formname} 

{col 5}{it:option}{col 24}{it:Description}
{space 4}{hline 44}
{col 5}{ul:em}phasize{col 24}explain whatever does
{col 5}{ul:opt}ion({it:arg}){col 24}explain whatever does
{space 4}{hline 44}


{title:Description}

{p 4 4 2}
{bf:democases} is used to create N new false cases starting by the ID 10001, to be used in enumerator training or testing. Democases requires you to specify a .csv file so that the demo cases are created using the format of the .csv you are trying to test. It only generates ID, ID label, phones and interviewee_name, so it's use with {bf:assignusers} is recommended for completing a cases csv.


{title:Options}

{p 4 4 2}
none at the moment. {break}
Comment: Maybe could include the options to specify variable names or number of phones.

{title:Remarks}

{p 4 4 2}
discuss the technical details about  {bf:XXX}, if there is any


{title:Example(s)}

    To create 200 demo cases for the "demo_form" form ID using a "cases.csv" in your working directory you should type:

        . democases "cases.csv" 200 "demo_form"

    If the cases file isn't on your working directory, you could specify it's location using the following format:

        . democases "X:\local\cases.csv" 500 "demo_form"


{title:Stored results}

{p 4 4 2}
The resulting demo cases should be stored in Stata's memory, so that you can proceed to assing user names or export the cases file as is. 

{title:Author}

{p 4 4 2}
leave 2 white spaces at the end of each line for line break. For example:

{p 4 4 2}
Victor Herencia     {break}
IPA      {break}
vherencia@poverty-action.org      {break}



