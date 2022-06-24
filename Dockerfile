FROM composer:latest

RUN composer global require laravel/pint --no-progress --dev
ENV PATH="/tmp/vendor/bin:${PATH}"

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]