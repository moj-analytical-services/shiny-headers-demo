FROM rocker/shiny@sha256:627a2b7b3b6b1f6e33d37bdba835bbbd854acf70d74010645af71fc3ff6c32b6

WORKDIR /srv/shiny-server

# Cleanup shiny-server dir
RUN rm -rf ./*

# Make sure the directory for individual app logs exists
RUN mkdir -p /var/log/shiny-server

# Install dependency on xml2
RUN apt-get update && \
 apt-get install libxml2-dev libssl-dev --yes --no-install-recommends && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/*

# Add shiny app code
ADD . .

# Shiny runs as 'shiny' user, adjust app directory permissions
RUN chown -R shiny:shiny .

CMD R -e "library(shiny); shiny::runApp(host='0.0.0.0', port=80)"
EXPOSE 80
