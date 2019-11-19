# Create Indincators for Impact Malaria

# set up ==================================================================
source("/Users/isaiahnyabuto/Documents/Workspace/utils.R")
baseurl <- "https://im-dev.psi-mis.org/"
base <- substr(baseurl,9,26)
usr <- keyringr::get_kc_account(base, type = "internet")
pwd <- keyringr::decrypt_kc_pw(base, type = "internet")

loginDHIS2(baseurl,usr,pwd)


#' Get all IM data elements

r <- GET(paste0(baseurl,"api/dataElements?fields=id,name,shortName,code,description,formName,categoryCombo[name],dataSetElements[dataSet[name]&filter=name:ilike:IM&paging=false"))

im_des <- fromJSON(content(r,"text"))$dataElements

im_des$catCombo <- im_des$categoryCombo$name

im_des$dataSet <- unlist(im_des$dataSetElements)

im_des %>% 
  select(-categoryCombo, -dataSetElements) %>%
  write.csv("./Impact Malaria/metadata/im_data_elements.csv", row.names = F)


##'
##'Indicators

ind_blueprint <- readxl::read_xlsx("./Impact Malaria/metadata/IM Global data entry forms.xlsx", sheet = "IM Indicator Blueprint")

# Indicator short names clean
ind_blueprint$shortName <- trimws(gsub("\\s+", " ", ind_blueprint$shortName))
ind_blueprint$name <- trimws(gsub("\\s+", " ", ind_blueprint$name))

# reformat the numerator to DHIS2 format
ind_blueprint$Numerator <- paste0("#{",ind_blueprint$Numerator,"}")

summed_ind <- function(x){
  # check if a summed indicator
  if (nchar(x) > 11){
    d <- unlist(strsplit(x,"['+']"))
    d <- trimws(d)
    paste0("#{",d,"}", collapse = "+")
  } else if (x == 1){
    1
  } else{
    paste0("#{",x,"}")
  }
}


ind_blueprint$`Denominator (edited)` <- sapply(ind_blueprint$`Denominator (edited)`, function(x) summed_ind(x))


# new ids
ind_id <- function(x){
  if (nchar(x) < 11){
    generateUID()
  } else{
    x
  }
}

ind_blueprint$id <- sapply(ind_blueprint$id, function(x) ind_id(x))


# generate payload
ind_payload <- data.frame(id = ind_blueprint$id,
                          name = ind_blueprint$name,
                          code = ind_blueprint$code,
                          shortName = ind_blueprint$shortName,
                          description = ind_blueprint$description,
                          numeratorDescription = ind_blueprint$numeratorDescription,
                          numerator = ind_blueprint$Numerator,
                          denominatorDescription = ind_blueprint$denominatorDescription,
                          denominator = ind_blueprint$`Denominator (edited)`,
                          indicatorType = ind_blueprint$indicatorType,
                          stringsAsFactors = F)

ind_payload$indicatorType <- rep("JjwfLvilfdU", nrow(ind_payload))

ind_payload$indicatorType <- data.frame(id = ind_payload$indicatorType, stringsAsFactors = F)

d <- POST(paste0(baseurl,"api/metadata?importStrategy=CREATE_AND_UPDATE"),
          body = toJSON(list(indicators = ind_payload), auto_unbox = T),
          content_type_json())

## Update sharing settings
im_sharing <- data.frame(id = c("lyN3gdA8BD4","DoGkwKs8ipw"),
                         access = c("rw------","r-------"),
                         stringsAsFactors = F)


d <- vector('list', nrow(ind_payload))
for (i in 1:nrow(ind_payload)){
  d[[i]] <- POST(paste0(baseurl,"api/sharing?type=indicator&id=",ind_payload$id[i]),
                 body = toJSON(sharing_settings(im_sharing),auto_unbox = T),
                 content_type_json())
}


## Benchamrk

ind_payload %>%
  select(-indicatorType) %>%
  write.csv("./Impact Malaria/metadata/Indicator Blueprint.csv", row.names = F)






