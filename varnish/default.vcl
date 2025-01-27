vcl 4.1;

backend default {
    .host = "api-catalog"; # Replace with the actual host, e.g., microservice host
    .port = "6070"; # Replace with the actual port, e.g., 8080
}

# Define caching policy
default_ttl = 3600s; # Set cache duration to 1 hour

sub vcl_recv {
    if (req.method == "GET" || req.method == "HEAD") {
        if (req.url ~ "^/api/flights/catalog/city/.*$") {
            return (hash);
        }

    }
    # Do not cache other HTTP methods
    return (pass);
}

sub vcl_backend_response {
    # Allow caching for HTTP 200 responses
    if (beresp.status == 200) {
        if (bereq.url ~ "^/api/flights/catalog/city/.*$") {
            set beresp.ttl = 3600s;
        }

    } else {
        set beresp.ttl = 0s;
    }
}

sub vcl_deliver {
    # Add a custom header to responses for debugging
    set resp.http.X-Cache = "HIT";
    if (obj.hits == 0) {
        set resp.http.X-Cache = "MISS";
    }
}

