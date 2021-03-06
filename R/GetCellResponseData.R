#' Get Cell Line Drug Response from FORESEE Object
#'
#' The GetCellResponseData Function extracts the entries of the drug response data that are relevant to predict the drug response with regard to the user's choice of CellResponseType and DrugName. It returns the given input object with a new element "DrugResponse".
#'
#' @param TrainObject Object that contains all data needed to train a model, including molecular data (such as gene expression, mutation, copy number variation, methylation, cancer type, etc. ) and drug response data
#' @param CellResponseType Format of the drug response data of the TrainObject, such as LN_IC50, AUC, GI50, etc., that is used for prediction
#' @param DrugName Name of the drug whose efficacy is supposed to be predicted with the model
#' @return \item{TrainObject}{The TrainObject with extracted drug response data.}
#' @examples GetCellResponseData(GDSC,"Gemcitabine","AUC")
#' @export

#########################
# This file is part of the FORESEE R-package
# File authors: Lisa-Katrin Turnhoff <turnhoff@combine.rwth-aachen.de> and Ali Hadizadeh Esfahani <hadizadeh@combine.rwth-aachen.de>
# Distributed under the GNU General Public License v3.0.(http://www.gnu.org/licenses/gpl-3.0.html)
#########################

GetCellResponseData <- function(TrainObject, DrugName, CellResponseType){

  #Checking to see user's CellResponseType is available in TrainObject:
  CellResponseTypeAvailabilityCheck(TrainObject,CellResponseType)
  #Checking to see user's DrugName is available:
  if(!any(colnames(TrainObject[[CellResponseType]])==DrugName)){
    message(paste(DrugName,"wasn't found, trying to match case-insensitive..."))
    if(any(tolower(colnames(TrainObject[[CellResponseType]]))==tolower(DrugName))){
      if(sum(colnames(tolower(TrainObject[[CellResponseType]]))==tolower(DrugName)) > 1){
        stop("More than one drug were matched! Can not continue with more than one drug to access!")
      } else {
        DrugName <- colnames(TrainObject[[CellResponseType]])[tolower(colnames(TrainObject[[CellResponseType]]))==tolower(DrugName)]
      }
      message(paste(DrugName,"was found! Will continue with",DrugName,"..."))
    } else {
      stop(paste("No drugs were found in TrainObject matching",DrugName,", Try listDrugs(TrainObject) to get all acceptable DrugNames in your TrainObject"))
    }
  }
  DrugResponse <- TrainObject[[CellResponseType]][,DrugName]
  DrugResponse <- DrugResponse[is.na(DrugResponse)==FALSE]
  #Adding the element DrugResponse to the TrainObject
  TrainObject[["DrugResponse"]] <- DrugResponse

  return(TrainObject)
}
