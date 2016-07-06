function add-NextAndPreviousLinksToMarkdownFile {
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

function get-HugoContent { 
<#
.SYNOPSIS
    Return the HugoContent as an object
.DESCRIPTION
    Todo: get it to work for Json and Toml
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
        $tags = @{}
        $categories = @{}
        $aliases = ""
        $draft = ""
        $publishdate = ""
        $weight = ""
        $markup = ""
        $url = ""
        $content = ""
           
        <#
            Initialize the potentially multi-value and/or multi-line properties
        #>
        $TagString = ""
        $CategoriesString = ""
        $AliasesString = ""
               
        foreach ($MarkdownLine in $MarkDownLines)
        {
            [string]$Line = $MarkdownLine.Line
            if ($Line -like "---*")
            {
                $YamlDividingLines = $YamlDividingLines + 1
            }
            if ($YamlDividingLines -eq 1 -and $Line.trim() -ne "")
            {

                <#
                    Retrieve Property Name and Line i.e. key and value
                #>
                $HugoNameAndValue = get-HugoNameAndFirstLineValue -FrontMatterLine $Line
                [string]$PropertyName = $HugoNameAndValue.Propertyname
                [string]$PropertyValue = $HugoNameAndValue.PropertyValue
                write-debug "`$PropertyName: <$PropertyName>"
                write-debug "`$PropertyValue: <$PropertyValue>"


                
                    
                
                
                $PropertyCount = $PropertyCount + 1
            
                
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
                        
                        write-debug "in switch"; 
                        $TagString = $PropertyValue
                        
                    }
                    # aliases CAN be multiple, but I've not coded for this yet
                    "aliases"
                    { 
                        write-debug "in switch"; 
                        $aliasesString = $PropertyValue 
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
                    "markup"
                    { 
                        write-debug "in switch - markup"; 
                        $markup = $PropertyValue 
                    }
                    "url"
                    { 
                        write-debug "in switch"; 
                        $url = $PropertyValue 
                    }  
                    <#
                        if the Property name is null, either it's an invalid line
                        or it's multiline
                    #>
                    ""
                    {
                        switch ($PropertyNameFromPreviousLine)
                        {
                            "tags"
                            { 
                                write-debug "in `$PropertyNameFromPreviosLine switch Tags"; 
                                $TagString = "$TagString, $PropertyValue"
                            }
                    
                            "categories"
                            { 
                                write-debug "in `$PropertyNameFromPreviosLine switch categories"; 
                                $aliases = "$CategoriesString$PropertyValue"
                            }
                    
                            "aliases"
                            { 
                                write-debug "in `$PropertyNameFromPreviosLine switch Aliases"; 
                                $aliases = "$AliasesString, $PropertyValue"
                            }
                            "default"
                            {
                                write-error "There is an invalid line: Line: <$Line> PropertyName: <$PropertyName> PropertyValue <$PropertyValue>"
                            }
                         } 
                    }

                
                    Default
                    { 
                                write-error "There is an invalid line: Line: <$Line> PropertyName: <$PropertyName> PropertyValue <$PropertyValue>"
                    }
                            

                }
            $PropertyNameFromPreviousLine = $PropertyName

            }
            elseif ($YamlDividingLines -gt 1)
            {
                <#
                    The front matter is over, so the rest is content
                #>
                write-debug "Adding to content"    

            }
        }

        $TagArray = convert-HugoDelimitedQuotedStringIntoAnArray -String $TagString 

                        $Tags = $TagString
                        $Aliases = $AliasesString
                        $Categories = $CategoriesString

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

function get-HugoNameAndFirstLineValue {

<#
.SYNOPSIS
  Return property name and any value on the same line 
.DESCRIPTION
  

.PARAMETER FrontMatterLine
  Folder 

.EXAMPLE
#>
  [CmdletBinding()]
  Param( [string]$FrontMatterLine = ".")
  
  write-startfunction


  $PositionOfFirstColon = $FrontMatterline.IndexOf(':')
  if ($PositionOfFirstColon -eq -1)
  {
    $PositionOfFirstColon = 0
  }

  $PropertyName = $FrontMatterLine.Substring(0,$PositionOfFirstColon)
                
  $PropertyValue = $FrontMatterLine.Substring($PositionOfFirstColon +1  )
            
  $PropertyValue = $PropertyValue.trimstart(' ') 
  $PropertyValue = $PropertyValue.trimend(' ') 
  $PropertyValue = $PropertyValue.trimstart('"') 
  $PropertyValue = $PropertyValue.trimend('"') 

  [PSCustomObject]@{ 
    PropertyName = $PropertyName
    PropertyValue = $PropertyValue 
  }

}


function get-HugoValueArrayFromString {

<#
.SYNOPSIS
  
.DESCRIPTION
  

.PARAMETER MultipleValueString
  Folder 

.EXAMPLE
#>
  [CmdletBinding()]
  Param( [string]$MultipleValueString = '[ "pepys", "literary", "visitors"," old george mall", "high street" ]',
         [string]$Delimiter = ',')
  
  write-startfunction

  $MultipleValueString = $MultipleValueString.trimstart('[')
  $MultipleValueString = $MultipleValueString.trimend(']')
  $MultipleValueString = $MultipleValueString.trim()
  $TagArray = $MultipleValueString.split($Delimiter)
                        
  
  write-debug "`$tagstring: <$tagstring>"


  $CleanedUpTagArray = @{}                     
  $Element = -1
  $tags = foreach ($Tag in $TagArray)
  {
    write-debug "1: `$tag: <$tag>"
    $Tag = $Tag.trim()
    write-debug "2: `$tag: <$tag>"
    $Tag = $Tag.trim('"')
    $Tag = $Tag.trim()
    write-debug "3: `$tag: <$tag>"
    if ($Tag -ne "")
    {
      $Element++
      $CleanedUpTagArray[$Element] = $Tag
    }
  }
  return $CleanedUpTagArray
}
#>

