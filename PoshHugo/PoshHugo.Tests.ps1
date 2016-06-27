$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$TestData = "$here\PesterData"
. "$here\$sut"

Describe "PoshHugo" {
    It "does something useful" {
        $true | Should Be $false
    }
}


Describe "get-HugoNameAndValue" {
    It "returns name and value for a valid line" {
        $Hugo = get-HugoNameAndValue -FrontMatterLine "Weighting: 103"
        # [string]$name = $Hugo.name
        # $name | Should Be 'Weighting'
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
        $title | Should Be 'xx'
    }

    It "returns description" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $description = $HugoContent.description
        $description | Should Be 'xx'
    }

    It "returns lastmod" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $lastmod = $HugoContent.lastmod
        $lastmod | Should Be 'xx'
    }

    It "returns date" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $date = $HugoContent.date
        $date | Should Be 'xx'
    }

    It "returns tags" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $tags = $HugoContent.tags
        $tags | Should Be 'xx'
    }

    It "returns categories" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $categories = $HugoContent.categories
        $categories | Should Be 'xx'
    }

    It "returns aliases" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $aliases = $HugoContent.aliases
        $aliases | Should Be 'xx'
    }

    It "returns draft" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $draft = $HugoContent.draft
        $draft | Should Be 'xx'
    }

    It "returns publishdate" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $publishdate = $HugoContent.publishdate
        $publishdate | Should Be 'xx'
    }

    It "returns markup" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $markup = $HugoContent.markup
        $markup | Should Be 'xx'
    }

    It "returns url" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $url = $HugoContent.url
        $url | Should Be 'xx'
    }

    It "returns body" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $body = $HugoContent.body
        $body | Should Be 'xx'
    }

    It "returns links" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $links = $HugoContent.links
        $links | Should Be 'xx'
    }

    It "returns weighting" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $Weighting = $HugoContent.Weighting
        $Weighting | Should Be '610'
    }

    It "returns images" {
        $HugoContent = get-HugoContent -f $TestData\10th-june-1668-samuel-pepys-visits-salisbury.md 
        $images = $HugoContent.images
        $images | Should Be '610'
    }

}
