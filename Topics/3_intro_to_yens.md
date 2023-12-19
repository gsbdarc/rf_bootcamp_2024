---
title: 3. Introduction to the Yen Servers
layout: page 
parent: Topics 
nav_order: 3
updateDate: 2023-12-19
---
# {{ page.title }}
---

## On-premises GSB resources

As a supplement to everything you can do on your own computer, the GSB has several Linux servers that you can use 
for your computing needs. These Linux research servers are useful for a variety of tasks, including when you want or need to:

- Run a program over a long period of time and do not want to leave your personal computer on and running
- Run a program that will use a lot of memory (such as when analyzing a large data set)
- Take advantage of parallel processing
- Access software for which you do not have a personal license
- Save files in a place where multiple people can access and work with them

## Yen Servers

![](/intro-to-yens.github.io/assets/images/yens.png)

At the GSB, we have a collection of Ubuntu Linux servers (the `yen` cluster) specifically for doing your research computing work. 
 If you are a faculty member, PhD student, post-doc or research fellow, by default you should have access to these servers. 
 They are administered by the <a href="https://srcc.stanford.edu" target="_blank">Stanford Research Computing Center (SRCC)</a> and located in Stanford's data centers.

{% include important.html content="The `yen` servers are not designed for teaching or course work!" %}

<div class="row">
    <div class="col-lg-12">
      <H1> </H1>
    </div>
  </div>
  <div class="row">
    <div class="col-lg-12">
     <div class="fontAwesomeStyle"><i class="fas fa-tachometer-alt"></i> Current cluster configuration</div>
<iframe class="airtable-embed" src="https://airtable.com/embed/shr0XAunXoKz62Zgl?backgroundColor=purple" frameborder="0" onmousewheel="" width="100%" height="533" style="background: transparent; border: 1px solid #ccc;"></iframe>
    </div>
    <div class="col col-md-2"></div>
  </div>

---
## Why use the `yen` servers?

These servers offer you several advantages over using a laptop or desktop computer.

#### Better Hardware

Let's use the server `yen3.stanford.edu` as an example: this machine has 256 processing cores and 1 TB of RAM. 
In comparison, my MacBook Pro has 6 cores (double-threaded so it looks like 12 cores) and 32 GB of RAM. With `yen3`, you are able to complete memory- or CPU-intensive work that would overwhelm even the best personal laptop!

#### Long running jobs

Even when your laptop is capable of doing the job, you may still want to offload that work to the external server. 
The server can free up resources for your laptop to use for other tasks such as browsing web sites, reading PDF files, 
working with spreadsheets, and so forth. If your laptop crashes, it's very convenient for your compute jobs to continue!

#### Licensed software

Tools like Matlab and Stata are installed and licensed to use on the `yen` servers.


#### Storage

The project files and any large output should live on ZFS file system (not in your home). The ZFS capacity is nearly 1 PB (petabyte).

{% include important.html content="The Yen servers are *not* approved for high risk data." %}

---
