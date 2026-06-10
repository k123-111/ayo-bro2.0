$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$source = Join-Path $repoRoot "skills\ayo"
$claudeCommandSource = Join-Path $repoRoot ".claude\commands\ayo.md"

if (-not (Test-Path $source)) {
    throw "Cannot find skill source at $source"
}

$targets = @(
    @{ Name = "Codex"; Root = if ($env:CODEX_HOME) { Join-Path $env:CODEX_HOME "skills" } else { Join-Path $env:USERPROFILE ".codex\skills" } },
    @{ Name = "Claude"; Root = Join-Path $env:USERPROFILE ".claude\skills" }
)

foreach ($entry in $targets) {
    $target = Join-Path $entry.Root "ayo"
    New-Item -ItemType Directory -Force -Path $entry.Root | Out-Null
    if (Test-Path $target) {
        Remove-Item -Recurse -Force -Path $target
    }
    Copy-Item -Recurse -Force -Path $source -Destination $target
    Write-Host "Installed ayo skill for $($entry.Name) to $target"
}

if (Test-Path $claudeCommandSource) {
    $claudeCommandsRoot = Join-Path $env:USERPROFILE ".claude\commands"
    New-Item -ItemType Directory -Force -Path $claudeCommandsRoot | Out-Null
    Copy-Item -Force -Path $claudeCommandSource -Destination (Join-Path $claudeCommandsRoot "ayo.md")
    Write-Host "Installed Claude Code /ayo command to $claudeCommandsRoot"
}

Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Fully restart Codex or Claude Code, or open a brand-new chat after installation."
Write-Host "2. Open the project you want to summarize."
Write-Host "3. Type exactly: ayo"
Write-Host "   In Claude Code, you can also type: /ayo"
Write-Host ""
Write-Host "Note: ordinary ChatGPT web/app chats do not load local skills from this folder."
