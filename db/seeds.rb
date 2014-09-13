Domain.where(domain: 'alphasights.com').first_or_create.patterns << Pattern.where(pattern: 'first_name.last_name').first_or_create
Domain.where(domain: 'google.com').first_or_create.patterns << Pattern.where(pattern: 'first_name.last_initial').first_or_create
Domain.where(domain: 'google.com').first_or_create.patterns << Pattern.where(pattern: 'first_initial.last_name').first_or_create
Domain.where(domain: 'apple.com').first_or_create.patterns << Pattern.where(pattern: 'first_initial.last_initial').first_or_create
