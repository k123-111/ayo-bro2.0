$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$skillsSourceRoot = Join-Path $repoRoot "skills"
$claudeCommandsSourceRoot = Join-Path $repoRoot ".claude\commands"

if (-not (Test-Path $skillsSourceRoot)) {
    throw "Cannot find skills source at $skillsSourceRoot"
}

$targets = @(
    @{ Name = "Codex"; Root = if ($env:CODEX_HOME) { Join-Path $env:CODEX_HOME "skills" } else { Join-Path $env:USERPROFILE ".codex\skills" } },
    @{ Name = "Claude"; Root = Join-Path $env:USERPROFILE ".claude\skills" }
)

foreach ($entry in $targets) {
    New-Item -ItemType Directory -Force -Path $entry.Root | Out-Null
    foreach ($skillSource in Get-ChildItem -Path $skillsSourceRoot -Directory) {
        $target = Join-Path $entry.Root $skillSource.Name
        if (Test-Path $target) {
            Remove-Item -Recurse -Force -Path $target
        }
        Copy-Item -Recurse -Force -Path $skillSource.FullName -Destination $target
        Write-Host "Installed $($skillSource.Name) skill for $($entry.Name) to $target"
    }
}

$claudeCommandsRoot = Join-Path $env:USERPROFILE ".claude\commands"
if (Test-Path $claudeCommandsSourceRoot) {
    New-Item -ItemType Directory -Force -Path $claudeCommandsRoot | Out-Null
    foreach ($commandSource in Get-ChildItem -Path $claudeCommandsSourceRoot -Filter "*.md" -File) {
        Copy-Item -Force -Path $commandSource.FullName -Destination (Join-Path $claudeCommandsRoot $commandSource.Name)
        Write-Host "Installed Claude Code /$([System.IO.Path]::GetFileNameWithoutExtension($commandSource.Name)) command to $claudeCommandsRoot"
    }
}

Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Fully restart Codex or Claude Code, or open a brand-new chat after installation."
Write-Host "2. Open the project you want to summarize."
Write-Host "3. Type exactly: ayo, oya, ayo bro, or fuck"
Write-Host "   In Claude Code, you can also type: /ayo, /oya, /ayo-bro, or /fuck"
Write-Host ""
Write-Host "Note: ordinary ChatGPT web/app chats do not load local skills from this folder."
