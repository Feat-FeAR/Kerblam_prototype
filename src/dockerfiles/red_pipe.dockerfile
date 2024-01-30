# Base image to use for the build process
FROM rocker/r-ver:latest

# Do not use WORKDIR to set the working directory inside the container unless
# you have explicitly set it in the kerblam.toml configuration file. By default,
# Kerblam expects that you copy the whole project folder directly to the root
# (/) of the container, since `kerblam run` will run
# 	docker run --rm -it -v ./data:/data kerblam_runtime

# Install prerequisites
#RUN apt-get update && apt-get install -y <some_software_here> \
#    && rm -rf /var/lib/apt/lists/*
RUN R -e "install.packages('magrittr', dependencies=TRUE, repos='http://cran.rstudio.com/')"

# Copy the whole project folder directly to the root (/) of the container
COPY . /
# or `COPY . .`, or `COPY ./ /`, as you prefer

# Run the analysis when the container starts (`executor` is the general name
# used by Kerblam for the pipeline to be dockered, thus allowing for universal
# container design
ENTRYPOINT ["bash", "./executor"]
