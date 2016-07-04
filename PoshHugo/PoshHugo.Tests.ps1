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

    It "returns title" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $title = $HugoContent.title
        $title | Should Be '10th June 1668 - Samuel Pepys visits Salisbury'
    }

    It "returns description" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $description = $HugoContent.description
        $description | Should Be ''
    }


    It "returns lastmod" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $lastmod = $HugoContent.lastmod
        $lastmod | Should Be '2016-06-07'
    }

    It "returns date" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $date = $HugoContent.date
        $date | Should Be '2013-11-29'
    }

    It "returns tags" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $tags = $HugoContent.tags
        $tags | Should Be ''
    }

    It "returns categories" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $categories = $HugoContent.categories
        $categories | Should Be 'on-this-day'
    }

    It "returns aliases" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $aliases = $HugoContent.aliases
        $aliases | Should Be '/on-this-day/june/10th-june-1668-samuel-pepys-visits-salisbury'
    }

    It "returns draft" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $draft = $HugoContent.draft
        $draft | Should Be 'No'
    }

    It "returns publishdate" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $publishdate = $HugoContent.publishdate
        $publishdate | Should Be '2013-11-29'
    }

    It "returns weighting" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $Weight = $HugoContent.Weight
        $Weight | Should Be '610'
    }

    It "returns markup" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $markup = $HugoContent.markup
        $markup | Should Be 'Md'
    }

    It "returns url" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $url = $HugoContent.url
        $url | Should Be '/on-this-day/june/10th-june-1668-samuel-pepys-visits-salisbury'
    }

    It "returns body" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $body = $HugoContent.body
        $body | Should Be ''
    }

    It "returns links" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $links = $HugoContent.links
        $links | Should Be ''
    }

    It "returns images" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $images = $HugoContent.images
        $images | Should Be '610'
    }

}


Describe "get-HugoValueArrayFromString" {
    It "returns an array of values from a comma seperated list of tags when there are many values" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString '[ "pepys", "literary", "visitors"," old george mall", "high street" ]'
        $HugoValueArray.length | Should be 5
        $HugoValueArray[0] | Should be "pepys"
        $HugoValueArray[1] | Should be "literary"
        $HugoValueArray[2] | Should be "visitors"
        $HugoValueArray[3] | Should be "old george mall"
        $HugoValueArray[4] | Should be "high street"
        
    }
    It "returns an array of values from a dash seperated list of tags when there are many values" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString '[ "pepys", "literary", "visitors"," old george mall", "high street" ]'
        $HugoValueArray.length | Should be 5
        $HugoValueArray[0] | Should be "pepys"
        $HugoValueArray[1] | Should be "literary"
        $HugoValueArray[2] | Should be "visitors"
        $HugoValueArray[3] | Should be "old george mall"
        $HugoValueArray[4] | Should be "high street"
        
    }
        It "returns one values from a comma seperated list of tags when there is only one value" {
        $HugoValueArray = get-HugoValueArrayFromString -MultipleValueString '[ "pepys", ]'
        $HugoValueArray.length | Should be 1
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

}