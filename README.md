# Stackable lnav Utils

A collection of [lnav](https://lnav.org) log format definitions and analysis scripts for all things Stackable related.
These scripts help analyze logs from various Stackable components.

## Quick Start

For first-time lnav users:

```bash
# Install the scripts repository
$ lnav -i https://github.com/stackabletech/lnav_scripts.git

# Load your log file (example with HBase logs)
$ lnav hbase.ndjson

# Example: In lnav, filter by Kubernetes pod name
:filter-expr :kubernetes_pod_name = 'etu1-hbase-regionserver-default-0'
```

## Available Scripts and Formats

### Log Format Definitions (.json files)

- **`vector-json.json`** - Parses JSON logs from the Vector aggregator
- **`graylog-json.json`** - Parses JSON logs exported from Graylog (TODO: Is this customer specific?)
- **`graylog-json-extended.json`** - Extended Graylog format with additional fields (TODO: Is this customer specific?)

### Analysis Scripts (.lnav files)

* Apache NiFi
* Apache ZooKeeper
* Graylog
*`hide-containerdebug.lnav`** - Filters out containerdebug container logs 

### SQL Filters
- **`vector-json-filters.sql`** - Auto-applies (is this correct? I assumed based on the TRIGGER) filters when vector_json format is detected

## Usage Examples

### NiFi

```bash
# Load NiFi logs and run analysis
$ lnav nifi-app.log

# In lnav, view GC performance:
:switch-to-view db
select log_time,generation,duration from gctime order by duration desc

# Check request processing times by type:
select type, avg(duration), max(duration) from requests group by type
```

## Installation

### Method 1: Automatic Installation

```bash
lnav -i https://github.com/stackabletech/lnav_scripts.git
```

TODO: I have no idea where this is installed to or how to update it later.

### Method 2: Local Installation

TODO: I'm not sure if this actually works. I looked at the lnav help but am not entirely sure.

```bash
git clone https://github.com/stackabletech/lnav_scripts.git
cd lnav_scripts
lnav -I .
```
