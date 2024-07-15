---
title: 4. Moving and Managing Larger Files
layout: page
nav_order: 4
parent: Day 2
updateDate: 2024-07-10
---

# {{ page.title }}
---

- Often, you’ll be downloading and moving large (>1GB) files between folders on a computer or even between computers
- There are many tools to do this, but today I’ll be focusing on two: scp and [rclone](https://rclone.org)
- First, will show you how to copy files to and from your laptop using scp
    - Useful for uploading data downloaded from the Internet, or for downloading tables, figures, or compiled paper drafts to view on your computer
- Then will show you how to copy large files around the Yens (and from third-party cloud storage like Dropbox, Box, Google Drive) using the more efficient rclone