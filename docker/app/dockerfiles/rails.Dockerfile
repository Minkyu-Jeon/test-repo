FROM thesis:development

RUN chmod +x docker/app/entrypoints/rails.sh

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]