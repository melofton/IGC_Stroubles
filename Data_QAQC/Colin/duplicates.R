#This file contains methods to examine duplicate rows in WQ and stage
#It was written to ensure that dropping what seemed to be duplicate rows in the unQAQC-ed dataset by using distinct() would be kosher
B1_QA_duplicates <- arrange( filter( B1_QA, duplicated(B1_QA$DateTime) | duplicated(B1_QA$DateTime, fromLast = TRUE)),
         DateTime)


filter( B1_QA_duplicates, 
        duplicated( B1_QA_duplicates[colnames(B1_QA_duplicates[-1])] ) |
          duplicated( B1_QA_duplicates[colnames(B1_QA_duplicates[-1])], fromLast = TRUE )
) %>%
  arrange(DateTime)


#A quick visual scan of the table below, which contains ALL the duplicate rows for stage, shows that
#there are no differences between duplicated rows greater than a millimeter
B1_stage_QA_duplicates <- arrange( filter( B1_stage_QA, duplicated(B1_stage_QA$DateTime) | duplicated(B1_stage_QA$DateTime, fromLast = TRUE)),
                             DateTime)
