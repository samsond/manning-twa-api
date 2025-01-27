# Dockerfile for Varnish Cache using version 7.3.0
FROM varnish:7.3.0

# Copy the VCL configuration file into the container
COPY default.vcl /etc/varnish/

# Expose Varnish port
EXPOSE 80

# Command to run Varnish with the specified VCL and backend settings
CMD ["varnishd", "-F", "-f", "/etc/varnish/default.vcl", "-a", ":80", "-s", "malloc,256m"]
