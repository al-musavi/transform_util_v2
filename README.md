# Transform Utility Documentation

## How to set up Transformation App on Terminal

First you need to clone the repository from github

Go to RJReliance github account
Navigate to transform_util_v2 page
Click on “Clone or download” button 

Copy URL to clipboard

Open “Terminal” on desktop

If you have a Mac search for it with the search tool 

If you have a Windows machine I usually setup using Ubuntu(Linux) with a Oracle VM virtualbox so I can use a the Linux terminal but there are other ways to setup Linux on a Windows in Windows 10 you can use the Windows Subsystem I haven’t tried it but this is new to Windows 

When you are in the terminal go to the folder you want to save the the repository 
I usually just save it in Documents but you can create a new folder and save it in there

When in the proper folder type

$ git clone https://github.com/al-musavi/transform_util_v2.git

Don’t type the dollar sign that is just so you know to type that line in the terminal
Then change into that directory by typing

$ cd transform_util_v2/

Now you just copied the repository into your terminal

First you want to run the bundler

In the terminal type

$ bundler

Next you want to set up the database and seed it

$ rake db:create
$ rake db:migrate
$ rake db:seed

These are three separate commands hit enter after each one

At this point the database should be seeded and you can run the program

To start the server type

$ rails s

In your browser goto 

$ localhost:3000

---------------------------------------

In order to seed other source table and logic tables  

At this point the tables must have the same column names as the test files 

In order to seed new files you must make a logic table and a source table and save them as csv files

This can be done with Google Docs, once you make the tables go to File and then Download as and save the spreadsheet as Comma Seperated Values(csv)

Save the logic table and source table in the home directory of the program

Go to the seed file and replace the source file and logic files with the new names 
They will be located at the bottom of the file:

parse_tables("logic_table_v1.csv", "source_table1.csv", "updated_table_v1")
parse_tables("logic_table_v2.csv", "source_table2.csv", "updated_table_v2")
parse_tables("logic_table_v3.csv", "source_table3.csv", "updated_table_v3")

The third variable “updated_table_v1” is a name I created to give the group of tables a name.





To search for the seed file you can press command + p on mac and type “seed”
Or on a windows ctrl + p


In order to run an rspec test to test the output of the app with an csv file with what the output is suppose to be

You must run the program by starting the server

 $ rails s

Going to the the url 

localhost:3000

Refreshing the page

Hit the Export CSV button underneath the table

That will save a file in your Download directory on your computer

If you haven’t done so already make a csv file of the expected output and save into the transform_util repository

At this point you are ready to replace the file names in the rspec file

Search for the file 

spec/Output2_spec.rb

Replaced the the expected_csv file name with the one you created

let(:expected_csv) {CSV.read('dest2.csv')}

Same with the generated_csv file

let(:generated_csv) {CSV.read('../../downloads/output2-2018-05-04 (5)')}

Now run the spec file by running the file  in the terminal

$ rspec ./spec/csv_files/output2_spec.rb
If the files match and output the same info you should get something like

Finished in 0.00965 seconds (files took 3.38 seconds to load)
1 example, 0 failures

Else it will show where the two files do not match















