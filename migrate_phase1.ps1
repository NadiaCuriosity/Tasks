$personal = "C:\Users\nadia\OneDrive"
$work = "C:\Users\nadia\OneDrive - Curiosity"

# Helper function: move folder, create destination parent if needed
function Move-Safely($src, $dest) {
    if (!(Test-Path $src)) {
        Write-Output "SKIP (not found): $src"
        return
    }
    $parent = Split-Path $dest -Parent
    if (!(Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    if (Test-Path $dest) {
        Write-Output "SKIP (destination exists): $dest"
        return
    }
    Move-Item -Path $src -Destination $dest -Force
    Write-Output "MOVED: $src -> $dest"
}

# Helper: move single file
function MoveFile-Safely($src, $destFolder) {
    if (!(Test-Path $src)) {
        Write-Output "SKIP (not found): $src"
        return
    }
    if (!(Test-Path $destFolder)) {
        New-Item -ItemType Directory -Path $destFolder -Force | Out-Null
    }
    Move-Item -Path $src -Destination $destFolder -Force
    Write-Output "MOVED: $src -> $destFolder"
}

Write-Output "=== PHASE 1A: Curiosity subfolders to work OneDrive ==="

$curiositySrc = "$personal\Curiosity"
$curiosityDest = "$work\Curiosity"

# Create Curiosity folder in work OneDrive
if (!(Test-Path $curiosityDest)) {
    New-Item -ItemType Directory -Path $curiosityDest -Force | Out-Null
}

$subfolders = @(
    "AI Documentation (Internal)",
    "AI Resources_Knowledge",
    "AI Assistant RAG knowledge",
    "Admin",
    "Archive",
    "Client Resourcess",
    "Clients",
    "Curiosity Logos_Illustrations",
    "Fractional Leadership_JDS",
    "GPT Instructions",
    "Github",
    "LinkenIn Advice and Resources",
    "Market Research Resources",
    "Marketing Templates",
    "My Website",
    "Podcast_Resources for Content"
)

foreach ($f in $subfolders) {
    Move-Safely "$curiositySrc\$f" "$curiosityDest\$f"
}

# Expense Invoices - move everything except Racers Edge
Write-Output ""
Write-Output "=== Expense Invoices (excluding Racers Edge) ==="
$expSrc = "$curiositySrc\Expense Invoices"
$expDest = "$curiosityDest\Expense Invoices"
if (!(Test-Path $expDest)) {
    New-Item -ItemType Directory -Path $expDest -Force | Out-Null
}
Get-ChildItem $expSrc -ErrorAction SilentlyContinue | Where-Object { $_.Name -ne "Racers Edge" } | ForEach-Object {
    Move-Item -Path $_.FullName -Destination $expDest -Force
    Write-Output "MOVED: $($_.FullName) -> $expDest"
}

# Loose files from Curiosity root
Write-Output ""
Write-Output "=== Loose files from Curiosity root ==="
Get-ChildItem "$curiositySrc" -File -ErrorAction SilentlyContinue | ForEach-Object {
    Move-Item -Path $_.FullName -Destination $curiosityDest -Force
    Write-Output "MOVED: $($_.FullName)"
}

Write-Output ""
Write-Output "=== PHASE 1B: Other business folders ==="

Move-Safely "$personal\0 Resouces" "$work\0 Resources"
Move-Safely "$personal\Books_Biz" "$work\Books_Biz"
Move-Safely "$personal\LWT" "$work\Clients\LWT"
Move-Safely "$personal\QLM_Workshop" "$work\Clients\QLM_Workshop"
Move-Safely "$personal\Ritson" "$work\Resources\Ritson"
Move-Safely "$personal\Demo" "$work\Resources\Demo"
Move-Safely "$personal\Nominations and applications" "$work\Nominations and Applications"
Move-Safely "$personal\CV" "$work\CV"

Write-Output ""
Write-Output "=== PHASE 1C: Business files from Desktop ==="

MoveFile-Safely "$personal\Desktop\Nadia Curiosity backup 1 june.pst" "$work\ZZ Archive\Email Backup"
MoveFile-Safely "$personal\Desktop\Nadia_Week1-2_Schedule_Jan2026_UPDATED.xlsx" "$work\Documents"
MoveFile-Safely "$personal\Desktop\INV-6267174 - Queenstown Wedding Association.pdf" "$curiosityDest\Expense Invoices"
MoveFile-Safely "$personal\Desktop\CV Expanded.docx" "$work\CV"

Write-Output ""
Write-Output "=== PHASE 1D: Business files from Documents ==="

# Zoom AI summit recordings
Move-Safely "$personal\Documents\Zoom\2026-01-30 06.03.36 The AI Marketing Strategy Summit" "$work\Recordings\2026-01-30 AI Marketing Strategy Summit"
Move-Safely "$personal\Documents\Zoom\2025-09-26 08.01.36 The AI_ROI Conference" "$work\Recordings\2025-09-26 AI ROI Conference"
Move-Safely "$personal\Documents\Zoom\2025-07-18 07.20.37 The AI Strategy Summit" "$work\Recordings\2025-07-18 AI Strategy Summit"

# Journals - Curiosity subfolder
Move-Safely "$personal\Documents\Journals\Curiosity" "$work\Documents\Journals"

# Individual business files from Documents
$bizDocsDir = "$work\Documents"
if (!(Test-Path $bizDocsDir)) { New-Item -ItemType Directory -Path $bizDocsDir -Force | Out-Null }

$bizDocFiles = @(
    "Toggl_time_entries_2023-09-01_to_2024-08-31 (1).csv",
    "Expanded_SOSTAC_Action_Plan_for_One-Person_Marketing_Team.xlsx",
    "Strategy & Done.pdf",
    "Motivations for B-Corp.xlsx",
    "isite Board Paper template.docx",
    "Summary of Pods.xlsx"
)

foreach ($f in $bizDocFiles) {
    MoveFile-Safely "$personal\Documents\$f" $bizDocsDir
}

Write-Output ""
Write-Output "=== PHASE 1 COMPLETE ==="
