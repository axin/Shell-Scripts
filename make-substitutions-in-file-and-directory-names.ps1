# Replaces <pattern> with <substitution> in file and directory names of given <directory>

param ([string]$pattern, [string]$substitution, [string]$directory)

function getNewName {
	param ($oldName)
	
	return $oldName -Replace $pattern, $substitution
}

function renameItems {
    param ($items)
    
    $items | Foreach {
        $oldName = $_.Name
        $newName = getNewName($oldName)
        
        if ($oldName -ne $newName) {
            $_ | Rename-Item -NewName $newName
        }
    }
}

function renameFiles {
    $files = Get-Childitem -Recurse *
    renameItems($files)
}

function renameDirectories {
    $directories = Get-Childitem -Recurse
    renameItems($directories)
}

function exitWithError {
    param ($message)
    
    Write-Error $message
    exit 1
}

function checkArguments {
    if ($pattern -Eq "") {
        exitWithError("Pattern required")
    }
    
    if ($substitution -Eq "") {
        exitWithError("Substitution required")
    }
    
    if ($directory -Eq "") {
        $directory = Get-Location
    }
}

checkArguments

Push-Location $directory

renameFiles
renameDirectories

Pop-Location
