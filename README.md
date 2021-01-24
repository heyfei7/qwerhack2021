# qwerhack2021

There are plenty of resources online for queer or questioning teens, but we find that there are two main problems:
1. The Internet is full of misleading information
2. Much of the resources are only in English, or else similarly monolingual.

Our application aims to solve these problems by providing a centralized database of reputable and accurate LGBTQ+ educational resources. Our users will be able to view these articles directly within the app, which can also translate the content into multiple languages.

We hope the translation services will bridge language gaps within the LGBTQ+ community. Most specifically, this has application for queer teens of immigrant parents, who may have different native tongues and be more comfortable in different languages.

Education is the key to understanding and acceptable, but it must be accessible to everyone.

## Technology
- Built the mobile app on Flutter and Dart
- Translation done with [`translator`](https://pub.dev/packages/translator)
- Querying and parsing HTML documents from URLs using [`http`](https://pub.dev/packages/http) and [`html`](https://pub.dev/packages/http)

## Current Features
- Users can pick which language they want translations for
- Users can filter and search from database of resources by tags
- Users can view a resource and toggle its content between the languages they supported
- Translations are currently provided by Google Translate

## Roadmap
- Continually curating, adding, and tagging resources to the database
- Dynamically extract only the relevant content from each resource
- Support for community sourced translations.
- Support for community ambassadors, who can not only provide language translations, but also cultural translations. Users can sign up to be an ambassador and become open to communication from various members of the community who might need more personalized support.
