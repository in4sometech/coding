# Project Title
Copy and Delete Unused data accross Fileshare servers

###Prerequisites

The purpose of the script's are to archieve/delete the unused data accross teh fileshare servers, the list of files within the shares are gathered by our fav tools from NetApp or from Windows

The acripts will be running with runas users and provided access with required access to copya nd delete files.

## Deployment

The scripts will first copy the data to new path provided along with log,a nd once the log is validated the user will proceed running the second script to delete the data

During deletion folders with file names will not be deleted.
