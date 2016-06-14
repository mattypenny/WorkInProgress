function append-NextAndPreviousLinksToMarkdownFile {
<#
.SYNOPSIS
  Append next page and previous page links to Markdown Files based on the weighting
.DESCRIPTION
  Longer description

.PARAMETER folder
  Folder 

.EXAMPLE




#>
  [CmdletBinding()]
  Param( [string]$Folder = ".")
  
  write-startfunction
  
  $YamlFromAllTheFolders = foreach ($File in $Folder)
  {
      get-yaml $File
  }
  
  $SortedYamlFromAllTheFolders = $YamlFromAllTheFolders | sort-object -property weighting, url

  foreach ($Yaml in $SortedYamlFromAllTheFolders)
  {
    <# $File = $Yaml.????
   
    $PreviousNextText = "???"
    
    copy ??? ??? # take a backup
    
    "$PreviousText" >> $File
    #>
  }  
  write-endfunction
  return 
}
function get-HugoFrontMatter { 
<#
.SYNOPSIS
    Return the HugoFrontMatter as an object
.DESCRIPTION
    Todo: get it tow work for Json and Toml
.PARAMETER HugoMarkdownFile

.EXAMPLE
     get-HugoFrontMatter -f D:\hugo\sites\example.com\content\on-this-day\10th-june-1668-samuel-pepys-visits-salisbury.md
  title       :  "10th June 1668 - Samuel Pepys visits Salisbury"
description :  ""
lastmod     :  "2016-06-07"
date        :  "2013-11-29"
aliases     :  ["/on-this-day/june/10th-june-1668-samuel-pepys-visits-salisbury"]
draft       :  No
publishdate :  "2013-11-29"
weight      :  610
markup      :  "md"
url         :  /on-this-day/june/10th-june-1668-samuel-pepys-visits-salisbury


.EXAMPLE
    Another example of how to use this cmdlet
#>
    [CmdletBinding()]
    Param( [string][Alias ("f")]$HugoMarkdownFile = "$pwd"  ) 

    write-startfunction

    $Files = dir $HugoMarkDownFile

    foreach ($File in $Files)
    {
        $MarkdownLines = select-string -pattern '^' $File

        $NumberOfMarkDownLines = $MarkdownLines | measure-object -Line
        write-debug "`$NumberOfMarkDownLines: $NumberOfMarkDownLines"

    
        $PropertyCount = 0
        $YamlDividingLines = 0

        # initialize the output values
        $description = ""
        $lastmod = ""
        $date = ""
        $tags = [PSCustomObject]@{}
        # "categories" 
        # aliases CAN be multiple, but I've not coded for this yet
        $aliases = ""
        $draft = ""
        $publishdate = ""
        $weight = ""
        $markup = ""
        $url = ""
           
        foreach ($MarkdownLine in $MarkDownLines)
        {
            [string]$Line = $MarkdownLine.Line
            if ($Line -like "---*")
            {
                $YamlDividingLines = $YamlDividingLines + 1
            }
            if ($YamlDividingLines -eq 1)
            {

                if ($Line -like " -*")
                {
                    write-debug "Childline: $Line"
                }
                
                
                $PropertyCount = $PropertyCount + 1
            
                $PositionOfFirstColon = $line.IndexOf(':')
                if ($PositionOfFirstColon -eq -1)
                {
                    $PositionOfFirstColon = 0
                }

                $PropertyName = $Line.Substring(0,$PositionOfFirstColon)
                
                $PropertyValue = $Line.Substring($PositionOfFirstColon +1  )
            
                $PropertyValue = $PropertyValue.trimstart(' ') 
                $PropertyValue = $PropertyValue.trimend(' ') 
                $PropertyValue = $PropertyValue.trimstart('"') 
                $PropertyValue = $PropertyValue.trimend('"') 
                 
                write-debug "`$Line: $Line x"  
                write-debug "`$Line.length: $($Line.length)"     
                write-debug "`$PositionOfFirstColon: $PositionOfFirstColon"
                write-debug "`$PropertyName: <$PropertyName>"
                write-debug "`$PropertyValue: <$PropertyValue>"
               
            
                switch ($PropertyName) 
                {
                    "title" 
                    { 
                        write-debug "in switch"; 
                        $title = $PropertyValue 
                    }
                    "description"
                    { 
                        write-debug "description - in switch"; 
                        $description = $PropertyValue 
                    }
                    "lastmod"
                    { 
                        write-debug "in switch"; 
                        $lastmod = $PropertyValue 
                    }
                    "date"
                    { 
                        write-debug "in switch"; 
                        $date = $PropertyValue 
                    }
                    "tags" 
                    {
                        $TagString = $PropertyValue
                        $TagString = $TagString.trimstart('[')
                        $TagString = $TagString.trimstart(']')
                        
                        $tags = foreach ($Tag in $TagString)
                        {
                            [PSCustomObject]@{Tag =$Tag}
                        }
                    }
                    # aliases CAN be multiple, but I've not coded for this yet
                    "aliases"
                    { 
                        write-debug "in switch"; 
                        $aliases = $PropertyValue 
                    }
                    "draft"
                    { 
                        write-debug "in switch"; 
                        $draft = $PropertyValue 
                    }
                    "publishdate"
                    { 
                        write-debug "in switch"; 
                        $publishdate = $PropertyValue 
                    }
                    "weight"
                    { 
                        write-debug "in switch"; 
                        $weight = $PropertyValue 
                    }
                    markup
                    { 
                        write-debug "in switch - markup"; 
                        $markup = $PropertyValue 
                    }
                    "url"
                    { 
                        write-debug "in switch"; 
                        $url = $PropertyValue 
                    }  
                    Default
                    { 
                        write-debug "Unknown property"
                        $UnknownProperty = $PropertyValue 
                    }  
                }    
            }
        }


        [PSCustomObject]@{
            title = $title        
            description = $description
            lastmod = $lastmod
            date = $date
            tags = $tags
            # # categories = $categories
            # aliases CAN be multiple, but I've not coded for this yet
            aliases = $aliases 
            draft = $draft
            publishdate = $publishdate
            weight = $weight 
            markup = $markup
            url = $url
            unknownproperty = $unknownproperty
        }
            
    }
    write-endfunction

}

set-alias temp get-template

<#
vim: tabstop=4 softtabstop=4 shiftwidth=4 expandtab
#>



