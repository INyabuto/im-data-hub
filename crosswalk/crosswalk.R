##'
##'Clean Crosswalk (CL)
##'

crosswalk_cl <- readxl::read_xlsx("./Impact Malaria/metadata/Copy of IM Global data entry forms, CL.xlsx",
                                  sheet = "Crosswalk (CL)", skip = 2)

im_ind_blueprint <- readxl::read_xlsx("./Impact Malaria/metadata/Copy of IM Global data entry forms, CL.xlsx",sheet = "IM Indicator (DHIS2)")

crosswalk_cl_ind_blueprint <- merge(crosswalk_cl,im_ind_blueprint, by.x = "Performance Indicator", by.y = "description")

write.csv(crosswalk_cl_ind_blueprint, "./Impact Malaria/metadata/crosswalk (cl) & ind blueprint.csv", row.names = F)
