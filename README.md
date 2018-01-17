# Query Engine (Statistics Canada)
This software is designed to find data from the crime and census data sets provided by Statistics Canada to answer four types of questions the user may have. The first type of question is directed towards users that are searching for specific statistics for specific violations and locations given a time period. For example, if a government employee was interested in knowing the highest number of incidents for homicide in Ontario during the years 2000 - 2015. This question could easily be asked using the first question type and the appropriate data could then be collected and presented as a graph of the user’s choice (scatter, line, bar).  
 
The second type of question is designed to answer questions that are more general than the previous type. For example, with this question type the user can find out which province had the highest percentage change in rate for homicide rather than having to specify a specific location the way they did in the previous type.  
 
The third type of question is intended to do comparisons between two violations or locations. For example, if the user was interested in finding out whether there are more cases of fraud or identity theft in a specific location, they would be able to get the data for each and see it presented in a double line graph.  
 
The final type of question allows the user to find out how the population of a province in Canada contributed to a specific violation in 2011. The answers are determined by using the crimes data file and the 2011 census file. Each province’s contribution to the total incidents of a crime is then outlined in a color coded bar graph. 
 
<b>Instructions to execute: </b>
 
1.	Ensure that you have the following files saved in a folder before you execute the Query Engine; bar.pl, census.csv, crime.csv,  
2.	Execute the following command: perl QueryEngine.pl census.CSV crime.csv 
3.	Select the type of question you would like to ask (1-4). 
4.	The question will be presented on the screen blank by blank, and you must choose one of the options displayed to build your question. 
5.	After you have filled in all the blanks, the full question will be displayed on the screen and it will then present the results in a graph of your preference. 
6.	You can choose to exit the program immediately after or continue asking more questions. 
 
 
Test Cases: 
 
Scenario 1: The Ontario Police Department is trying to evaluate if their RIDE campaign has decreased the number of drunk driving incidents over the years that they have collected data. They will be selecting question 1 and asking the following question: What is the lowest actual	 incidents for total, impaired driving	 in Ontario during 1998 - 2015?  
 
Scenario 2: Government employees are trying to determine which city’s police department should get the highest funding. They will begin by selecting question 2 and asking the following question: Which city has the highest rate per 100,000 population for total,all violations during 2013-2015?  
 
Scenario 3: Government employees want to launch a public awareness campaign in Ontario on the dangers of either drunk driving or cocaine possession, trafficking and distribution. Which campaign should their funding go towards? They will begin by selecting question 3 and asking the following question: Which violation; cocaine possession, trafficking and distribution	 or	 total, impaired driving has the highest actual incidents for Ontario in 	2012-2015?  
 
Scenario 4: Due to recent events, there has been a slight decrease in Nunavut’s population, the police department is interested in knowing if this event has caused the number of total, all violent violations to decrease.They will begin by selecting question 4 and asking the following question: What is the contribution of the population of Nunavut 	to the total incidents of 	total, all	 violent violations in 2011	?
