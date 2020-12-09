# Powershell module to search all the lines in a file with occurenrences of a string
# Based on  user-input, either Display to lines having the text or replace them with a Replacement text

function Search_And_Replace_Text{
    param($search, $replace, $filename, $caseSenstive = "N")
    # $search is the text to be searched for
    # $replace is the text to be replaced. Set $replace as "DISPLAY" to only view and not replace.
    # $filename is the path of the file with its name which needs to be modified/viewed.
    # caseSenstive is to be given as "Y" if the search should be case-senstive, else can be skipped

    ## RETURN VALUE
    # Returns a hashmap consistsing of below keys:
    # value -> Array of lines found if DISPLAY is the replace text
    # return_code -> 0-99 for success, 100-199 for error and 200-299 for warning
    # message -> Any message associated with the error or warning or any information

    [System.Collections.Hashtable]$result = @{
        value=$null;
        return_code=0;
        message="Ok"
    }

    $search = $search -replace '\\','\\'
    try{
        # if(![System.IO.File]::Exists($filename)){ throw "The given file does not exists" }
        if($search -eq $null -or $search -eq ""){ throw "Search parameter needs to be passed" }
        if($replace -eq $null){ throw "Replace parameter needs to be passed" }
        if($replace -eq ""){
            $result["return_code"] = 200
            $result["message"] = "WARNING: Replace param is passed as blank"
        }
        
        if($caseSenstive -eq "Y") { $output = Select-String -Path $filename -Pattern $search -CaseSensitive | Select LineNumber }
        else { $output = Select-String -Path $filename -Pattern $search | Select LineNumber }

        [System.Collections.ArrayList]$content = Get-Content $filename

        if($replace -eq "DISPLAY") {
            [System.Collections.ArrayList]$items = @()
            foreach($item in $output.LineNumber) { $items.Add($content[$item-1]) | Out-Null }
            $result['value'] = $items
        }
        else { foreach($item in $output.LineNumber) { $content[($item -as [int]) - 1] = $replace } }
        Set-Content -Path $filename -Value $content | Out-Null
    }

    catch {
        $result["return_code"] = 100
        $result["message"] = "ERROR: " + $_.Exception.Message
    }
    return $result
}