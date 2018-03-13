# Project Title
Copy and Delete Unused data accross Fileshare servers

### Prerequisites

The purpose of the script's are to archieve/delete the unused data accross the fileshare servers, the list of files within the shares are gathered by our fav tools from NetApp or from Windows with both absolute path and  filename's.

The acripts should be ran with required access to copy and delete files.

## Deployment

The scripts, when ran in order will first copy the data to new path provided along with log,and once the log is validated the user will proceed running the second script to delete the data

During deletion, folder's listed as file names will not be deleted.
