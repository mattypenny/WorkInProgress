$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
remove-module PoshHugo -verbose
import-module PoshHugo -verbose
$TestData = "$here\PesterData"
# . "$here\$sut"

$HugoContentFolder = "D:\hugo\sites\example.com\content\on-this-day\"

Describe "get-HugoNameAndFirstLineValue" {
    It "returns name and value for a valid line" {
        $Hugo = get-HugoNameAndFirstLineValue -FrontMatterLine "Weight: 103"
        $value = $Hugo.PropertyValue
        $value | Should Be '103'
        # "103" | Should Be '103'
        # $Hugo.value | Should Be '103'
    }

}

<#
title: "10th June 1668 - Samuel Pepys visits Salisbury"
description: ""
lastmod: "2016-06-07"
date: "2013-11-29"
tags: [  ]
categories: 
 - "on-this-day"
aliases: ["/on-this-day/june/10th-june-1668-samuel-pepys-visits-salisbury"]
draft: No
publishdate: "2013-11-29"
weight: 610
markup: "md"
url: /on-this-day/june/10th-june-1668-samuel-pepys-visits-salisbury
#>

Describe "get-HugoContent for a single file" {
    
    $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md

    It "returns title" {
        $title = $HugoContent.title
        $title | Should Be '10th June 1668 - Samuel Pepys visits Salisbury'
    }

    It "returns description" {
        $description = $HugoContent.description
        $description | Should Be ''
    }


    It "returns lastmod" {
        $lastmod = $HugoContent.lastmod
        $lastmod | Should Be '2016-06-07'
    }

    It "returns date" {
        $date = $HugoContent.date
        $date | Should Be '2013-11-29'
    }

    It "returns tags" {
        $tags = $HugoContent.tags
        $tags[0] | Should be "pepys"

        $tags[1] | Should be "literary"
        $tags[2] | Should be "visitors"
        $tags[3] | Should be "old george mall"
        $tags[4] | Should be "high street"

        
    }

    It "returns categories" {
        $categories = $HugoContent.categories
        $ExpectedCategories = @("on-this-day", "june", "diaries and things", "dummy")
        $Comparison = Compare-Object $categories $ExpectedCategories
        $Comparison.InputObject | Should Be "dummy"
        $Comparison.SideIndicator | Should Be "=>"
    }

    It "returns aliases" {
        $Content = $HugoContent.aliases
        $ExpectedContent = @("/on-this-day/june/10th-june-1668-samuel-pepys-visits-salisbury", "/about-Pepys-and-Salisbury", "dummy")
        $Comparison = Compare-Object $Content $ExpectedContent
        $Comparison.InputObject | Should Be "dummy"
        $Comparison.SideIndicator | Should Be "=>" 
    }

    It "returns draft" {
        $draft = $HugoContent.draft
        $draft | Should Be 'No'
    }

    It "returns publishdate" {
        $publishdate = $HugoContent.publishdate
        $publishdate | Should Be '2013-11-29'
    }

    It "returns weighting" {
        $Weight = $HugoContent.Weight
        $Weight | Should Be '610'
    }

    It "returns markup" {
        $markup = $HugoContent.markup
        $markup | Should Be 'Md'
    }

    It "returns url" {
        $url = $HugoContent.url
        $url | Should Be '/on-this-day/june/10th-june-1668-samuel-pepys-visits-salisbury'
    }
<#
    It "returns body" {
        [string]$ExpectedBody = get-content $TestData\Pepys-Body.txt
        [string]$body = $HugoContent.body
        $BodyFirst = $Body.Substring(1,10)
        $ExpectedBodyFirst = $ExpectedBody.Substring(1,10)

        $bodyFirst | Should Be $ExpectedBodyFirst
    }

    It "returns links" {
        $links = $HugoContent.links
        $links | Should Be ''
    }

    It "returns images" {
         
        $images | Should Be '610'
    }
    <#
    #>
}

Describe "get-HugoContent for multiple file" {
    
    $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md

    It "returns title" {
        $title = $HugoContent.title
        $title | Should Be '10th June 1668 - Samuel Pepys visits Salisbury'
    }
}

Describe "get-HugoValueArrayFromString" {
    It "returns an array of values from a comma seperated list of tags when there are many values" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString '[ "pepys", "literary", "visitors"," old george mall", "high street" ]'
        $HugoValueArray.count | Should be 5
        $HugoValueArray[0] | Should be "pepys"
        $HugoValueArray[1] | Should be "literary"
        $HugoValueArray[2] | Should be "visitors"
        $HugoValueArray[3] | Should be "old george mall"
        $HugoValueArray[4] | Should be "high street"
        
    }
    It "returns an array of values from a dash seperated list of tags when there are many values" {
        $HugoValueArray = get-HugoValueArrayFromString -DElimiter '-' -MultipleValueString '- "roadname" - "onthisday" - "stonehengeseverywhere" -"unknown"'
        $HugoValueArray.count | Should be 4
        $HugoValueArray[0] | Should be "roadname"
        $HugoValueArray[1] | Should be "onthisday"
        $HugoValueArray[2] | Should be "stonehengeseverywhere"
        $HugoValueArray[3] | Should be "unknown"
        
    }
        It "returns one value from a comma seperated list of tags when there is only one value" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString '[ "pepys", ]'
        $HugoValueArray | Should be "pepys"
        
    }
        It "returns one value when the string is just one word, with no comma seperation" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString '[ "pepys" ]'
        $HugoValueArray | Should be "pepys"
        
    }
        It "returns one value when the string is just one word, with no comma seperation and no brackets" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString ' "pepys" '
       $HugoValueArray | Should be "pepys"
        
    }
        It "should not throw an error when the string is blank" {
        {get-HugoValueArrayFromString -MultipleValueString '  '} | Should Not Throw
       
        
    }

        It "returns nothing when the string is blank" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString '  '
        $HugoValueArray.count | Should be 0
        $HugoValueArray | Should benullOrEmpty
        
    }

}

Describe "get-HugoContent for multiple files" {
    
    
    
        

    It "returns title" {
        $HugoTitles = get-HugoContent -f $TestData\*.md | select title
        
        $ExpectedTitles = @("10th August 1901 - Miss Moberly meets Marie Antoinette",               
                            "10th June 1668 - Samuel Pepys visits Salisbury",                      
                            "15th June 1786 - Matcham meets 'the Dead Drummer', possibly",          
                            "1st May 472 - the 'Night of the Long Knives' at Amesbury",             
                            "3rd June 1977 - the Ramones visit Stonehenge. Johnny stays on the bus",
                            "dummy"
                            )
        $ExpectedTitles
        $Comparison = Compare-Object $HugoTitles.title $ExpectedTitles
    
        $Comparison.InputObject | Should Be "dummy"
        $Comparison.SideIndicator | Should Be "=>" 
    
    }
}

Describe "get-HugoContent for a single file - body processing" {
    
    $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md
    [string]$ExpectedBody = get-content -encoding default $TestData\Pepys-Body.txt
    [string]$body = $HugoContent.body

    It "returns the first 10 characters" {
        
        $BodyFirst = $Body.Substring(0,10)
        $ExpectedBodyFirst = $ExpectedBody.Substring(0,10)
        $bodyFirst | Should Be $ExpectedBodyFirst
    }
    It "returns the first character" {
        
        [byte][char]$Body[0] | Should Be $([byte][char]$ExpectedBody[0])
    }
    It "returns the same length" {
        
        $BodyLength = $Body.length
        $ExpectedBodyLength = $ExpectedBody.length
        $bodyLength | Should Be $ExpectedBodyLength
    }

}

Describe "set-HugoContent backs up an existing file" {
    It "creates a backup copy of the existing file" {
 
        $Now = get-date -uformat "%Y%m%d%H%M"
        
        $HugoParameters = @{
            HugoMarkdownFile = "c:\temp\markdown_file.md"
            aliases = 'xx'
            body = 'xx'
            categories = 'xx'
            date = 'xx'
            description = 'xx'
            draft = 'xx'
            lastmod = 'xx'
            markup = 'xx'
            publishdate = 'xx'
            tags = "hippy","wiltshire","stonehenge"
            title = 'xx'
            unknownproperty = 'xx'
            url = 'xx'
            weight = 'xx'
            nobackup = $False
        }
        set-HugoContent @HugoParameters

        $(test-path "c:\temp\old\markdown_file.md_$Now") | Should Be $true
    }
}

Describe "set-HugoContent" {
 
    $Now = get-date -uformat "%Y%m%d%H%M"
    $HugoFile = "$HugoContentFolder\elvis-visits-Salisbury.md"

    $HugoParameters = @{
        HugoMarkdownFile = "$HugoFile"
        aliases = '["/on-this-day/theking"]'
        body = 'This is a test post - sadly Elvis never got to visit Salisbury'
        categories = 'on-this-day'
        date = '2016-08-25'
        description = ''
        draft = 'No'
        lastmod = '2016-08-25'
        markup = 'md'
        publishdate = '2016-08-25'
        tags = "elvis","wiltshire","salisbury"
        title = 'Elvis Presley visits Salisbury (this is a test)'
        unknownproperty = 'xx'
        url = '/on-this-day/june/elvis-visits-salisbury'
        weight = '1'
        nobackup = $False
        }
        set-HugoContent @HugoParameters

    It "creates a backup copy of the existing file" {
        $(test-path "D:\hugo\sites\example.com\content\on-this-day\old\elvis-visits-Salisbury.md_$Now") | Should Be $true
    }
    It "creates a markdown file" {
        $(test-path "$HugoFile") | Should Be $true
    }

    It "creates a markdown file whtat works with Hugo (if Hugo is running!)" {
        $WebPage = invoke-webrequest http://localhost:1313/on-this-day/june/elvis-visits-salisbury/ 
        
        $WebPage.RawContentLength | Should Be 2229
    }
    It "populates the Hugo fields" -testcases @{Key = "title"; ExpectedValue = "Elvis Presley visits Salisbury (this is a test)" },
                                              @{Key = "title"; ExpectedValue = "Elvis Presley visits Salisbury (this is a test)" } -test {
        param ([string]$Key,
               [string]$ExpectedValue)
 
        write-host "`$Key: <$Key>"
        write-host "`$ExpectedValue: <$ExpectedValue>"
        $ReturnedString = select-string  -pattern "$key  *:" $HugoFile

        $($ReturnedString | measure-object).count | Should Be 1

        [string]$Line = $ReturnedString.line
        write-host "`$Line: <$Line>"
        $value = $Line.split(":")[1]
        $Value = $Value.trim()
       
        $Value | Should Be $ExpectedValue

    }
<#
title           : Elvis Presley visits Salisbury (this is a test)
description     : 
lastmod         : 2016-08-25
date            : 2016-08-25
tags            : 
 - "elvis" 
 - "wiltshire" 
 - "salisbury"
categories      : 
 - "on-this-day"
aliases         : 
 - "on-this-day"
draft           : No
publishdate     : 2016-08-25
weight          : 1
markup          : md
url             : /on-this-day/june/elvis-visits-salisbury
---
This is a test post - sadly Elvis never got to visit Salisbury
#>
}
