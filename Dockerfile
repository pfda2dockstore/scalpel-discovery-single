# Generated by precisionFDA exporter (v1.0.3) on 2018-06-14 03:42:05 +0000
# The asset download links in this file are valid only for 24h.

# Exported app: scalpel-discovery-single, revision: 10, authored by: matthew.lueder
# https://precision.fda.gov/apps/app-F3B29xQ0kvV0Q7X4FXKgzQJ0

# For more information please consult the app export section in the precisionFDA docs

# Start with Ubuntu 14.04 base image
FROM ubuntu:14.04

# Install default precisionFDA Ubuntu packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	aria2 \
	byobu \
	cmake \
	cpanminus \
	curl \
	dstat \
	g++ \
	git \
	htop \
	libboost-all-dev \
	libcurl4-openssl-dev \
	libncurses5-dev \
	make \
	perl \
	pypy \
	python-dev \
	python-pip \
	r-base \
	ruby1.9.3 \
	wget \
	xz-utils

# Install default precisionFDA python packages
RUN pip install \
	requests==2.5.0 \
	futures==2.2.0 \
	setuptools==10.2

# Add DNAnexus repo to apt-get
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/amd64/' > /etc/apt/sources.list.d/dnanexus.list"
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/all/' >> /etc/apt/sources.list.d/dnanexus.list"
RUN curl https://wiki.dnanexus.com/images/files/ubuntu-signing-key.gpg | apt-key add -

# Update apt-get
RUN DEBIAN_FRONTEND=noninteractive apt-get update

# Download app assets
RUN curl https://dl.dnanex.us/F/D/gjvX92yGQFYvxJ8qjx153pY0Yxq0FfpqyVGP275G/grch37-fasta.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/B7PfkzZVZ2k4PzZVB0jkXB6KPy4f1b14PvbY6Xk7/hs37d5-fasta.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/ByQXbpPP94VgYyg9bYGvq87x4Bk6ZJpv2b9vPyZB/scalpel_v0.5.3.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions

# Download helper executables
RUN curl https://dl.dnanex.us/F/D/0K8P4zZvjq9vQ6qV0b6QqY1z2zvfZ0QKQP4gjBXp/emit-1.0.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/bByKQvv1F7BFP3xXPgYXZPZjkXj9V684VPz8gb7p/run-1.2.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions

# Write app spec and code to root folder
RUN ["/bin/bash","-c","echo -E \\{\\\"spec\\\":\\{\\\"input_spec\\\":\\[\\{\\\"name\\\":\\\"bam\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"BAM\\ file\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":\\\"file-F39VQZQ0826yzxqV0fpJ002V\\\"\\},\\{\\\"name\\\":\\\"bed\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"BED\\ file\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":\\\"file-F39JZxQ0K25ZG4ZYF8JBFXYg\\\"\\},\\{\\\"name\\\":\\\"ref\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Reference\\ Genome\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":\\\"grch37\\\",\\\"choices\\\":\\[\\\"grch37\\\",\\\"hs37d5\\\"\\]\\},\\{\\\"name\\\":\\\"kmer\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"k-mer\\ size\\ \\[default\\ 25\\]\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":25\\},\\{\\\"name\\\":\\\"covthr\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"threshold\\ used\\ to\\ select\\ source\\ and\\ sink\\ \\[default\\ 5\\]\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":5\\},\\{\\\"name\\\":\\\"lowcov\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"threshold\\ used\\ to\\ remove\\ low-coverage\\ nodes\\ \\[default\\ 2\\]\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":2\\},\\{\\\"name\\\":\\\"covratio\\\",\\\"class\\\":\\\"float\\\",\\\"optional\\\":false,\\\"label\\\":\\\"minimum\\ coverage\\ ratio\\ for\\ sequencing\\ errors\\ \\(default:\\ 0.01\\)\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":0.01\\},\\{\\\"name\\\":\\\"radius\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"left\\ and\\ right\\ extension\\ \\(in\\ base-pairs\\)\\ \\[default\\ 100\\]\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":100\\},\\{\\\"name\\\":\\\"window\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"window-size\\ of\\ the\\ region\\ to\\ assemble\\ \\(in\\ base-pairs\\)\\ \\[default\\ 400\\]\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":400\\},\\{\\\"name\\\":\\\"maxregcov\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"maximum\\ average\\ coverage\\ allowed\\ per\\ region\\ \\[default\\ 10000\\]\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":10000\\},\\{\\\"name\\\":\\\"step\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"delta\\ shift\\ for\\ the\\ sliding\\ window\\ \\(in\\ base-pairs\\)\\ \\[default\\ 100\\]\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":100\\},\\{\\\"name\\\":\\\"mapscore\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"minimum\\ mapping\\ quality\\ for\\ selecting\\ reads\\ to\\ assemble\\ \\[default\\ 1\\]\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":1\\},\\{\\\"name\\\":\\\"pathlimit\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"limit\\ number\\ of\\ sequence\\ paths\\ to\\ \\[default\\ 1000000\\]\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":1000000\\},\\{\\\"name\\\":\\\"mismatches\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"max\\ number\\ of\\ mismatches\\ in\\ near-perfect\\ repeat\\ detection\\ \\[default\\ 3\\]\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":3\\}\\],\\\"output_spec\\\":\\[\\{\\\"name\\\":\\\"outdir\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"zipped\\ up\\ output\\ folder\\\",\\\"help\\\":\\\"\\\"\\}\\],\\\"internet_access\\\":false,\\\"instance_type\\\":\\\"baseline-32\\\"\\},\\\"assets\\\":\\[\\\"file-Bk5xvzQ0qVb5k0VYzZQG7BXJ\\\",\\\"file-Bk5y43Q0qVb0gjfqY8f9k4g8\\\",\\\"file-F39BJ9Q0K25b69Vg8QgxXQgX\\\"\\],\\\"packages\\\":\\[\\]\\} \u003e /spec.json"]
RUN ["/bin/bash","-c","echo -E \\{\\\"code\\\":\\\"export\\ LD_LIBRARY_PATH\\=\\$LD_LIBRARY_PATH:/opt/scalpel-0.5.3/bamtools-2.3.0/lib/:/opt/scalpel-0.5.3/bcftools-1.1/htslib-1.1\\\\nexport\\ PATH\\=\\$PATH:/opt/scalpel-0.5.3/:/opt/scalpel-0.5.3/bamtools-2.3.0/lib/:/opt/scalpel-0.5.3/bcftools-1.1/htslib-1.1\\\\nscalpel-discovery\\ --single\\ --bam\\ \\\\\\\"\\$bam_path\\\\\\\"\\ --bed\\ \\\\\\\"\\$bed_path\\\\\\\"\\ --ref\\ \\\\\\\"\\$ref\\\\\\\".fa\\ --kmer\\ \\\\\\\"\\$kmer\\\\\\\"\\ --covthr\\ \\\\\\\"\\$covthr\\\\\\\"\\ --lowcov\\ \\\\\\\"\\$lowcov\\\\\\\"\\ --covratio\\ \\\\\\\"\\$covratio\\\\\\\"\\ --radius\\ \\\\\\\"\\$radius\\\\\\\"\\ --window\\ \\\\\\\"\\$window\\\\\\\"\\ --maxregcov\\ \\\\\\\"\\$maxregcov\\\\\\\"\\ --step\\ \\\\\\\"\\$step\\\\\\\"\\ --mapscore\\ \\\\\\\"\\$mapscore\\\\\\\"\\ --pathlimit\\ \\\\\\\"\\$pathlimit\\\\\\\"\\ --mismatches\\ \\\\\\\"\\$mismatches\\\\\\\"\\ --numprocs\\ \\\\\\\"\\`nproc\\`\\\\\\\"\\\\ntar\\ czvf\\ outdir.tar.gz\\ outdir\\\\nemit\\ outdir\\ outdir.tar.gz\\\"\\} | python -c 'import sys,json; print json.load(sys.stdin)[\"code\"]' \u003e /script.sh"]

# Create directory /work and set it to $HOME and CWD
RUN mkdir -p /work
ENV HOME="/work"
WORKDIR /work

# Set entry point to container
ENTRYPOINT ["/usr/bin/run"]

VOLUME /data
VOLUME /work