﻿<#
    .NOTES
        Copyright 2012 Robert Nees
        Licensed under the Apache License, Version 2.0 (the "License");
        http://sushihangover.blogspot.com
    .SYNOPSIS
        *nix style grep 
    .DESCRIPTION
        This script provides a wrapper to give Linux/Grep style cmd line options
        Note: It needs a lot of help/work to complete
    .EXAMPLE
    .LINK
        http://sushihangover.blogspot.com
#>
function Do-Grep {
    param(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True)][string]$Path = '',
        [Parameter(Mandatory=$False)][Alias("filter")][string]$filterString,
        [Parameter(Mandatory=$False)][Alias("i")][switch]$ignore_case,
        [Parameter(Mandatory=$False)][Alias("v")][switch]$invert_match,
        [Parameter(Mandatory=$False)][Alias("test")][switch]$debugOutput,
        [Parameter(Mandatory=$False)][Alias("H")][switch]$with_filename,
        [Parameter(Mandatory=$False)][Alias("ver")][switch]$version
    )
    begin {
        if ($version.IsPresent) {
            help ($MyInvocation.MyCommand)
            break
        }
        if ($debugOutput.IsPresent) {
            $count = 0;
            Write-Host "(  begin) : Count = $count; filter = $filterString";
        }
    }
    process {
        if ($debugOutput.IsPresent) {
            $count++
            Write-Host "(process) : Count = $count; filter = $filterString; `$_ = $_";
        }

        # foreach ($property in $_.PSObject.Properties)
        # $_.PSObject.properties[$property.Name].Value

        if ($ignore_case.IsPresent) {
           if ( ($_ -cmatch $filterString ) -and  (-not $invert_match.IsPresent) ) {
               $_
            } else {
               $_
            }
        } else {
            if ( ( $_ -match $filterString )  -and  (-not $invert_match.IsPresent) ) {
                if ($with_filename.IsPresent) {
                    $_.FullName
                }
                $_
            } elseif ( ( $_ -notmatch $filterString )  -and  ($invert_match.IsPresent) ) {
                if ($with_filename.IsPresent) {
                    $_.FullName
                }
                $_
            }
        }
    }
    end {
        if ($debugOutput.IsPresent) {
            Write-Host "(    end) : Count = $count; filter = $filterString";
        }
    }
}
