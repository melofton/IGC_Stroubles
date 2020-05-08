##MakeEMLBridge1
##Author: Mary Lofton
##Date: 09SEP19

#good site for step-by-step instructions
#https://ediorg.github.io/EMLassemblyline/articles/overview.html
#and links therein

#run QAQC_for_EDI_08MAY20 to generate the proper, QAQC'ed file for EDI

# (install and) Load EMLassemblyline #####
# install.packages('devtools')

devtools::install_github("EDIorg/EMLassemblyline")
#note that EMLassemblyline has an absurd number of dependencies and you
#may exceed your API rate limit; if this happens, you will have to wait an
#hour and try again or get a personal authentification token (?? I think)
#for github which allows you to submit more than 60 API requests in an hour
library(EMLassemblyline)


#Step 1: Create a directory for your dataset
#in this case, our directory is IGC_Stroubles/MakeEMLBridge1

#Step 2: Move your dataset to the directory

#Step 3: Identify an intellectual rights license
#ours is CCBY

#Step 4: Identify the types of data in your dataset
#right now the only supported option is "table"; happily, this is what 
#we have!

#Step 5: Import the core metadata templates

#for our application, we will need to generate all types of metadata
#files except for taxonomic coverage, as we have both continuous and
#categorical variables and want to report our geographic location

# View documentation for these functions
?template_core_metadata
?template_table_attributes
?template_geographic_coverage

# Import templates for our dataset licensed under CCBY, with 1 table.
template_core_metadata(path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
                 license = "CCBY",
                 file.type = ".txt",
                 write.file = TRUE)

template_table_attributes(path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
                       data.path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
                       data.table = "Bridge1.csv",
                       write.file = TRUE)


#we want empty to be true for this because we don't include lat/long
#as columns within our dataset but would like to provide them
template_geographic_coverage(path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
                          data.path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
                          data.table = "Bridge1.csv",
                          empty = TRUE,
                          write.file = TRUE)

#Step 6: Script your workflow
#that's what this is, silly!

#Step 7: Abstract
#copy-paste the abstract from your Microsoft Word document into abstract.txt
#if you want to check your abstract for non-allowed characters, go to:
#https://pteo.paranoiaworks.mobi/diacriticsremover/
#paste text and click remove diacritics

#Step 8: Methods
#copy-paste the methods from your Microsoft Word document into abstract.txt
#if you want to check your abstract for non-allowed characters, go to:
#https://pteo.paranoiaworks.mobi/diacriticsremover/
#paste text and click remove diacritics

#Step 9: Additional information
#I put the notes about FCR manipulations and pubs documenting it in this file

#Step 10: Keywords
#DO NOT EDIT KEYWORDS FILE USING A TEXT EDITOR!! USE EXCEL!!
#not sure if this is still true...let's find out! :-)

#Step 11: Personnel
#copy-paste this information in from your metadata document
#Typically, the lead PI (Cully?) needs to be listed several times; that person has to be listed separately for his/her roles as
#PI, creator, and contact, and also separately for each separate funding source (!!)

#Step 12: Attributes
#grab attribute names and definitions from your metadata word document
#for units....
# View and search the standard units dictionary
view_unit_dictionary()
#put flag codes and site codes in the definitions cell
#force reservoir to categorical

#Step 13: Close files
#if all your files aren't closed, sometimes functions don't work

#Step 14: Categorical variables
# Run this function for your dataset
#THIS WILL ONLY WORK once you have filled out the attributes_Bridge1.txt and
#identified which variables are categorical
?template_categorical_variables 

template_categorical_variables(path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
                               data.path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
                               write.file = TRUE)

#open the created value IN A SPREADSHEET EDITOR and add a definition for each category

#Step 15: Geographic coverage
#fill in the text file with the appropriate bounding box for your site

## Step 16: Obtain a package.id. ####
# Go to the EDI staging environment (https://portal-s.edirepository.org/nis/home.jsp),
# then login using your username and password.

# Select Tools --> Data Package Identifier Reservations and click 
# "Reserve Next Available Identifier"
# A new value will appear in the "Current data package identifier reservations" 
# table (e.g., edi.123)
# Make note of this value, as it will be your package.id below

#Step 17: Make EML
# View documentation for this function
?make_eml

# Run this function
make_eml(
  path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
  data.path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
  eml.path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
  dataset.title = "Water quality time series for Stroubles Creek in Blacksburg, Virginia, USA 20XX-2018",
  temporal.coverage = c("2013-04-04", "2018-12-17"), #needs edited!!
  maintenance.description = 'ongoing', #or completed if we don't ever plan on updating this
  data.table = "Bridge1.csv",
  data.table.description = "Bridge 1 sonde dataset",
  user.id = '', #email Colin Smith to get one of these that is not for Carey Lab?
  user.domain = 'EDI',
  package.id = 'edi.267.0') #will need to change this

## Step 8: Check your data product! ####
# Return to the EDI staging environment (https://portal-s.edirepository.org/nis/home.jsp),
# then login using your username and password 

# Select Tools --> Evaluate/Upload Data Packages, then under "EML Metadata File", 
# choose your metadata (.xml) file (e.g., edi.270.1.xml), check "I want to 
# manually upload the data by selecting files on my local system", then click Upload.

# Now, Choose File for each file within the data package (e.g., each zip folder), 
# then click Upload. Files will upload and your EML metadata will be checked 
# for errors. If there are no errors, your data product is now published! 
# If there were errors, click the link to see what they were, then fix errors 
# in the xml file. 
# Note that each revision results in the xml file increasing one value 
# (e.g., edi.270.1, edi.270.2, etc). Re-upload your fixed files to complete the 
# evaluation check again, until you receive a message with no errors.

## Step 9: PUBLISH YOUR DATA! ####
# Reserve a package.id for your error-free data package. 
# NEVER ASSIGN this identifier to a staging environment package.
# Go to the EDI Production environment (https://portal.edirepository.org/nis/home.jsp)
# and login using your permanent credentials. 

# Select Tools --> Data Package Identifier Reservations and click "Reserve Next 
# Available Identifier". A new value will appear in the "Current data package 
# identifier reservations" table (e.g., edi.518)
# This will be your PUBLISHED package.id

# In the make_eml command below, change the package.id to match your 
# PUBLISHED package id. This id should end in .1 (e.g., edi.518.1)

# ALL OTHER entries in the make_eml() command should match what you ran above,
# in step 7

make_eml(
  path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
  data.path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
  eml.path = "C:/Users/Mary Lofton/Documents/RProjects/IGC_Stroubles/MakeEMLBridge1",
  dataset.title = "Water quality time series for Stroubles Creek in Blacksburg, Virginia, USA 20XX-2018",
  temporal.coverage = c("2013-04-04", "2018-12-17"), #needs edited!!
  maintenance.description = 'ongoing', #or completed if we don't ever plan on updating this
  data.table = "Bridge1.csv",
  data.table.description = "Bridge 1 sonde dataset",
  user.id = '', #email Colin Smith to get one of these that is not for Carey Lab?
  user.domain = 'EDI',
  package.id = 'edi.267.0') #will need to change this

# Once your xml file with your PUBLISHED package.id is Done, return to the 
# EDI Production environment (https://portal.edirepository.org/nis/home.jsp)

# Select Tools --> Preview Your Metadata, then upload your metadata (.xml) file 
# associated with your PUBLISHED package.id. Look through the rendered 
# metadata one more time to check for mistakes (author order, bounding box, etc.)

# Select Tools --> Evaluate/Upload Data Packages, then under "EML Metadata File", 
# choose your metadata (.xml) file associated with your PUBLISHED package.id 
# (e.g., edi.518.1.xml), check "I want to manually upload the data by selecting 
# files on my local system", then click Upload.

# Now, Choose File for each file within the data package (e.g., each zip folder), 
# then click Upload. Files will upload and your EML metadata will be checked for 
# errors. Since you checked for and fixed errors in the staging environment, this 
# should run without errors, and your data product is now published! 

# Click the package.id hyperlink to view your final product! HOORAY!