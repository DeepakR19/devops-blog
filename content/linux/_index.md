---
title: "Linux Core Concepts"  
description: "Essential Linux fundamentals for DevOps and system engineers"  
date: 2026-01-18  
categories: [Linux, DevOps, Fundamentals]  
tags: [linux, kernel, processes, systemd, filesystem, logs]  
draft: false
---

## Linux Boot Process (BIOS → GRUB → Kernel → init/systemd)

### Boot Flow

1. **BIOS/UEFI**
   
   - Performs POST (Power-On Self-Test)
   
   - Locates bootable disk
   
   - Loads the bootloader

2. **Bootloader (GRUB)**
   
   - Displays OS selection menu
   
   - Loads the Linux kernel into memory
   
   - Passes boot parameters

3. **Kernel**
   
   - Initializes hardware
   
   - Loads device drivers
   
   - Mounts root filesystem
   
   - Starts PID 1

4. **init / systemd**
   
   - Starts system services
   
   - Brings system to a usable state

---

## Kernel Space vs User Space

| Feature          | Kernel Space    | User Space  |
|:----------------:|:---------------:|:-----------:|
| Privileges       | High            | Low         |
| Hardware Access  | Direct          | Indirect    |
| Stability Impact | Critical        | Isolated    |
| Examples         | Kernel, drivers | Shell, apps |

**Why separation?**

- Security

- Stability

- Fault isolation

---

## Process vs Thread

| Feature       | Process  | Thread                |
|:-------------:|:--------:|:---------------------:|
| Memory        | Separate | Shared                |
| Creation cost | High     | Low                   |
| Communication | IPC      | Direct                |
| Crash impact  | Isolated | Affects whole process |

---

## Linux Filesystem Hierarchy

### `/bin`

Essential user commands (`ls`, `cp`, `cat`)

### `/sbin`

System binaries (`reboot`, `fsck`)

### `/etc`

Configuration files

### `/var`

Variable data (logs, cache, spool)

### `/usr`

User programs and libraries

### `/home`

User home directories

### `/proc`

Virtual kernel/process info

### `/tmp`

Temporary files

---

## Inodes

An inode stores **metadata** about a file.

### Stores:

- Permissions

- Ownership

- Size

- Timestamps

- Disk blocks

### Does NOT store:

- Filename

- File content

**Why it matters:**  
You can run out of inodes even if disk space is available.

---

## Process Lifecycle

1. Created

2. Ready

3. Running

4. Waiting

5. Terminated

---

## Zombie and Orphan Processes

### Zombie

- Finished execution

- Entry still in process table

- Waiting for parent to collect exit status

### Orphan

- Parent terminated

- Adopted by PID 1 (systemd/init)

---

## Linux Signals

| Signal  | Number | Purpose       |
| ------- | ------ | ------------- |
| SIGKILL | 9      | Force kill    |
| SIGTERM | 15     | Graceful stop |
| SIGSTOP | 19     | Pause         |

```bash
kill -9 <pid>
kill -15 <pid>
```

---

## systemd vs init

| Feature             | init | systemd |
| ------------------- | ---- | ------- |
| Parallel startup    | ❌    | ✅       |
| Dependency handling | ❌    | ✅       |
| Logging             | ❌    | ✅       |
| Speed               | Slow | Fast    |

---

## journald

`journald` is the logging service of systemd.

### Features

- Structured logs

- Indexed

- Centralized

- Binary format

### Commands

```bash
journalctl
journalctl -xe
journalctl -u nginx
```

---

## Common Log Locations

| Type     | Location          |
| -------- | ----------------- |
| System   | /var/log/syslog   |
| Auth     | /var/log/auth.log |
| Kernel   | /var/log/kern.log |
| Boot     | /var/log/boot.log |
| App logs | /var/log//        |

---

## Summary

This guide covers core Linux internals required for:

- DevOps

- SRE

- Linux Admin

- Cloud Engineers

---

> Want individual pages for each topic with diagrams and commands? I can auto-generate them.
