
$filelist = Import-Csv "C:\temp\PST-File-List.csv" | % {$_.absname}

write-host "Hi, I am importing the Excel file provided"

$results = @()

for($i=0; $i -lt $filelist.Count;$i++)
{
$file = $filelist[$i]
$filetype = test-path $file  -pathtype leaf
           if ($filetype -eq $True)
              {
            $filetype = "File"
            write-host "`nDeleting File $File" -foregroundcolor "Red `n"

                                # $Filedeleted =  $file | remove-item -verbose -ErrorAction ignore
                                 $Isfiledeleted = test-path $file
			                            if ($Isfiledeleted -eq $False)
                                  {
                                   $Isfiledeleted = "File deleted"
                                  }
                                   else
                                  {
                               $Isfiledeleted = "Error at this file"
                                   }
              }
       	    Else {
                       $fileexists  = test-path $file
                       if($fileexists -eq $false  ) 
                           {
                            $filetype = "NA"
                             $Isfiledeleted  = "The File not exists or Already Deleted"
                           }

                           else 
                           { 
                         $filetype = "Folder"
                         write-host "`noops, We have a folder $file `n" -foregroundcolor "Green"
                         $Isfiledeleted = "It's not deleted, because its a folder"
                           }
                }
			       

$details = @{            
                Date         = get-date              
                FileType     = $filetype                
                Filepath     = $file 
				        Filedeleted  = $Isfiledeleted
        }                           
        $results += New-Object PSObject -Property $details  
			
}
$CurrentDateTime = Get-Date -format "ddMMMyyyy-HH-mm"
$Filename = "File-deletion-log-" + $CurrentDateTime + ".csv"
$results |Export-Csv "$Filename" -NoTypeInformation -UseCulture
 