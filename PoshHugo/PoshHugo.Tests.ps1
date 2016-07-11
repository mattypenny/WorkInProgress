$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
remove-module PoshHugo -verbose
import-module PoshHugo -verbose
$TestData = "$here\PesterData"
# . "$here\$sut"


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

Describe "get-HugoContent" {
    
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

        $tags | Should Be ''
    }

    It "returns categories" {
        $categories = $HugoContent.categories
        $ExpectedCategories = @("on-this-day", "june", "diaries and things", "dummy")
        $Comparison = Compare-Object $categories $ExpectedCategories
        $Comparison.InputObject | Should Be "dummy"
        $Comparison.SideIndicator | Should Be "=>"
    }

    It "returns aliases" {
        $aliases = $HugoContent.aliases
        $aliases | Should Be '/on-this-day/june/10th-june-1668-samuel-pepys-visits-salisbury'
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

    It "returns body" {
        $body = $HugoContent.body
        $body | Should Be ''
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
        $HugoValueArray.count | Should be 1
        $HugoValueArray[0] | Should be "pepys"
        
    }
        It "returns one value when the string is just one word, with no comma seperation" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString '[ "pepys" ]'
        $HugoValueArray.length | Should be 1
        $HugoValueArray[0] | Should be "pepys"
        
    }
        It "returns one value when the string is just one word, with no comma seperation and no brackets" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString ' "pepys" '
        $HugoValueArray.length | Should be 1
        $HugoValueArray[0] | Should be "pepys"
        
    }
        It "should not throw an error when the string is blank" {
        {get-HugoValueArrayFromString -MultipleValueString '  '} | Should Not Throw
       
        
    }

        It "returns nothing when the string is blank" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString '  '
        $HugoValueArray.count | Should be 0
        $HugoValueArray[0] | Should benullOrEmpty
        
    }

}