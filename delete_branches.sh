#!/bin/bash

# Function to handle local branch deletion with per-branch confirmation
delete_local_branches() {
    echo "Fetching list of merged local branches (excluding current branch and master)..."
    # Get merged branches, exclude current branch (*) and master
    merged_branches=$(git branch --merged | grep -v "\*" | grep -v "master")
    
    if [ -z "$merged_branches" ]; then
        echo "No merged local branches found to delete."
    else
        echo "Merged local branches:"
        echo "$merged_branches"
        echo ""
        
        # Iterate over each branch and ask for confirmation
        echo "$merged_branches" | while read -r branch; do
            # Remove leading/trailing whitespace from branch name
            branch=$(echo "$branch" | xargs)
            if [ -n "$branch" ]; then
                read -p "Do you want to delete local branch '$branch'? (Yes/No): " answer
                if [ "$answer" = "Yes" ] || [ "$answer" = "yes" ]; then
                    git branch -d "$branch"
                    echo "Deleted local branch: $branch"
                else
                    echo "Skipped deletion of local branch: $branch"
                fi
            fi
        done
    fi
}

# Function to handle remote branch deletion with per-branch confirmation
delete_remote_branches() {
    echo ""
    echo "Now handling remote branches..."
    # Prompt user for the branch name to check merged remote branches against
    read -p "Enter the branch name to check merged remote branches against (e.g., master, feature/branch): " target_branch
    
    # Fetch remote info
    git fetch origin
    
    echo "Fetching list of remote branches merged into origin/$target_branch (excluding current branch)..."
    # Get merged remote branches, exclude current branch
    merged_remote_branches=$(git branch -r --merged origin/"$target_branch" | grep "origin/feature" | grep -v "origin/$(git rev-parse --abbrev-ref HEAD)")
    
    if [ -z "$merged_remote_branches" ]; then
        echo "No merged remote branches found for origin/$target_branch."
    else
        # Clean up the list by removing origin/ prefix for display and processing
        branches_to_check=$(echo "$merged_remote_branches" | sed 's/origin\///')
        echo "Merged remote branches under origin/feature:"
        echo "$branches_to_check"
        echo ""
        
        # Iterate over each branch and ask for confirmation
        echo "$branches_to_check" | while read -r branch; do
            # Remove leading/trailing whitespace from branch name
            branch=$(echo "$branch" | xargs)
            if [ -n "$branch" ]; then
                read -p "Do you want to delete remote branch 'origin/$branch'? (Yes/No): " answer
                if [ "$answer" = "Yes" ] || [ "$answer" = "yes" ]; then
                    git push origin --delete "$branch"
                    echo "Deleted remote branch: origin/$branch"
                else
                    echo "Skipped deletion of remote branch: origin/$branch"
                fi
            fi
        done
    fi
}

# Main script execution
echo "Starting branch cleanup process..."
echo "-----------------------------------"

# Step 1: Handle local branches
delete_local_branches

# Step 2: Handle remote branches
delete_remote_branches

echo "-----------------------------------"
echo "Branch cleanup process completed."