
#Move Non-priority/unused files like PST from all folers within an array to a specific arcive folder by still keeping the source path and history for Auditing and retrieval purpose 
#Code also checks for dublicate file paths
#Record of the output is saved on the file for auditing and validation purposes
#basename is filename(Ex:- File.pst) and absname is abosulte path of the file(Ex:- \\NAS01\users\in4sometech\File.pst)


$filelist = Import-Csv "C:\temp\PST-File-List.csv" | % {$_.absname}
$basenames = Import-Csv "C:\temp\Nas mount Script\PST-File-List.csv" | % {$_.basename}

write-host "Hi, I am importing the Excel file provided"

$results = @()
$targetNAs = "\\Targnetpath\PSTfiles"
$NewFileLocation = "NA"
for($i=0; $i -lt $filelist.Count;$i++)
{
$file = $filelist[$i]
#echo $file
$basename = $basenames[$i]
$filetype = test-path $file  -pathtype leaf
#echo $filetype
           if ($filetype -eq $True)
              {
            $filetype = "File"
            write-host "`nworking on File $File `n"

                             
							 $trimmedfile = $file.trim("\\")
							 $newfilelocationpath = $targetNAs+"\" +$trimmedfile
							 $newfilelocation  = $newfilelocationpath.trim($basename).trimend("\")
							 $createdirectory = mkdir $newfilelocation
							 write-host "`nCreating Directory as path  $newfilelocation" -foregroundcolor "Red `n"
							 $Filecopied =  Copy-Item $file $newfilelocation 
							 $Filecopied = "Filecopied"
							 write-host "`n Copying $file to new path  $newfilelocation" -foregroundcolor "Green `n"
							 
							 													
								
                                  $Isfilecopied = test-path $newfilelocationpath
			                            if ($Isfilecopied -eq $False)
                                  {
                                   $Isfilecopied = "File not copied"
                                  }
                                   else
                                  {
                                  $Isfilecopied = "File copied"
                                   }
              }
       	    Else {
                       $fileexists  = test-path $file
                       if($fileexists -eq $false  ) 
                           {
                            $filetype = "NA"
                             $Filecopied  = "The File not exists"
							 $NewFileLocation = "NA"
                           }
                           else 
                           { 
                         $filetype = "Folder"
                         write-host "`noops, We have a folder $file `n" -foregroundcolor "Green"
                         $Filecopied = "It's copied"
                           }
                }
			       

$details = @{            
                Date         = get-date              
                FileType     = $filetype                
                Filepath     = $file 
				NewFileLocation  = $newfilelocation
				Filecopied  = $Filecopied
        }                           
        $results += New-Object PSObject -Property $details  
			
}
$CurrentDateTime = Get-Date -format "ddMMMyyyy-HH-mm"
$Filename = "File-Copied-Log-" + $CurrentDateTime + ".csv"
$results |Export-Csv "$Filename" -NoTypeInformation -UseCulture
 