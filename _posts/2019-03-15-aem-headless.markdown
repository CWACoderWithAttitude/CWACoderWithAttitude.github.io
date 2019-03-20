---
layout: post
title:  "AEM Headless CMS - Draft"
date:   2018-03-15 14:20:27 +0100
categories: aem headless rest hateoas siren
---
# AEM Headless CMS - Draft

I'm currently investigating Adobe AEMs headless features.
At first i'd like to give a short overview of where we come from, where we're going to.
And the difference.

After that i'd like to go a bit deeper into the technical details.

## What does headless mean?

Headless means programatic access to the content. Resources like sites, pages etc. are represented by json objects.
Access follows the REST paradigm by denoting entities with paths and specifying actions using HTTP verbs like GET, POST, DELETE...

Each entity can have multiple relations. Those relations are reflected by listing links to other resources with the content

## What does Adobe say?

On [Content as a Service
](https://www.adobe.com/marketing/experience-manager-sites/content-as-a-service.html) they describe it

Adobe lists [Content as a Service
](https://www.adobe.com/marketing/experience-manager-sites/content-as-a-service.html) as part of their [Experience Manager Sites](https://www.adobe.com/marketing/experience-manager-sites.html)


## Where do we come from

Traditional AEM systems are build from these components:
* authoring server
* publishing server
* dispatcher

Author and publisher are loosely coupled by a message queuing system.

That is: all content is created and edited on the author and then pushed to the publisher.
The publishers sole purpose is serving content.

![architecture taken from adobe](https://helpx.adobe.com/content/dam/help/en/AEM-forms/6-1/Topology_Big.png)


## Whats different with headless?



> In production scenarios, AEM Content Services should serve content from AEM Publish, and from directly from AEM Author.
[Adobe Content Services](https://helpx.adobe.com/experience-manager/kt/sites/using/content-services-tutorial-use/part6.html)

I think (!!!) the sentence should read something like this:

> In production scenarios, AEM Content Services should serve content from AEM Publish and directly from AEM Author.


That's a major difference.
There could be implications for setups already in production.
Even the docs are inconsistent.

A few lines down the page there's a line stating this may be appropriate for content served internally.
Content available to the all evil internet should be protected. That's interesting.


## How?

### Content Preparation

Content has to be authored and designed for headless access.

There're different concepts that are used to compose Headless feature:
* [Fragments](https://helpx.adobe.com/experience-manager/kt/sites/using/content-fragments-feature-video-use.html)
and
* [Adobe Content Services / ACS](https://helpx.adobe.com/experience-manager/kt/sites/using/content-services-tutorial-use.html)

ACS offers two template types to define [JSON structure exposing content](https://helpx.adobe.com/experience-manager/kt/sites/using/content-services-tutorial-use/part4.html):
* FAQ Main API Template
and
* FAQ Listing API Template

> Content for the Headless feature has to be derived from those two templates!

A description on how to implement headless content can be found [here](https://helpx.adobe.com/experience-manager/kt/sites/using/content-services-tutorial-use/part5.html)

### Access

Accessing asset resources follows the REST paradigm. REST describes entities like pages, images teasers etc.
Since this lacks the most interesting and important part: the relations between them a second paradigm - [siren](https://github.com/kevinswiber/siren) and [Google discussion group on Siren Hypermedia](https://groups.google.com/forum/#!forum/siren-hypermedia)- is applied.

A good description of REST can be found [here](https://medium.com/@marinithiago/guys-rest-apis-are-not-databases-60db4e1120e4)

Siren is a bit like [HATEOAS](https://en.wikipedia.org/wiki/HATEOAS).
While HATEOAS is for xml siren describes the scenarios in json.

AEM offers [Assets HTTP API](https://helpx.adobe.com/experience-manager/6-3/assets/using/mac-api-assets.html).

They offer information on content navigation on [Navigating Content Structure ](https://helpx.adobe.com/experience-manager/6-4/screens/using/rest-api.html)

The latter link is about dealing with [AEM Screens (German)](https://helpx.adobe.com/de/experience-manager/6-4/sites/deploying/using/aem-screens-introduction.html), [
Introduction to AEM Screens](https://helpx.adobe.com/experience-manager/kt/eseminars/gems/aem-introduction-to-aem-screens.html)
This also mentions cordova integration.

[AEM screens](https://helpx.adobe.com/experience-manager/6-4/screens/user-guide.html) seems to be AEMs Gateway to 3rd party applications.

The documentation lists [cordova aka phonegap](https://cordova.apache.org/) integration among others.

### Getting stated links
* [Getting Started with Core Components and the Style System](https://helpx.adobe.com/experience-manager/kt/sites/using/style-system-core-components-tutorial-develop.html)
* [AEM Fluid Experiences for headless usecases](https://helpx.adobe.com/experience-manager/kt/eseminars/gems/aem-headless-usecases.html)
* [AEM as a Headless CMS](http://aempodcast.com/2017/aem-resources/aem-headless-cms/#.XJDnexNKiL8)
* [Experience-Cloud: Headless CMS
](https://www.adobe.com/de/experience-cloud/topics/headless-cms.html)
* []()


## Getting fingers dirty

Examples are based on the "We.retail" example content.

> The following code examples make use of [JQ](https://github.com/stedolan/jq).
> JQ is like "grep" but for JSON. Check it out - it's really cool.

> Caveat: Most commands use the "-c" (comapct) option to save space.
>   omit it to pretty print the output

Lets have a look what it looks like

Retrieve list of available sites:
```bash
curl http://admin:admin@127.0.0.1:4502/api/content/sites.json | jq -c '.'
```

gives us:

```bash
{"entities":[{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/experience-fragments.json"}],"class":["content/page"],"properties":{"dc:title":"Experience Fragments","name":"experience-fragments"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/screens.json"}],"class":["content/page"],"properties":{"dc:title":"Screens","name":"screens"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/campaigns.json"}],"class":["content/page"],"properties":{"dc:title":"Campaigns","name":"campaigns"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/sites.json"}],"class":["content/page"],"properties":{"dc:title":"Community Sites","name":"sites"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/forms.json"}],"class":["content/page"],"properties":{"name":"forms"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/community-components.json"}],"class":["content/page"],"properties":{"name":"community-components"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail.html"}],"class":["content/page"],"properties":{"dc:language":"en_US","dc:title":"We.Retail","name":"we-retail"}}],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites.json"},{"rel":["parent"],"href":"http://127.0.0.1:4502/api/content.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content.infinity.json"}],"class":["content/page"],"properties":{"name":"sites","srn:paging":{"total":7,"offset":0,"limit":20}}}
```
Hm, that looks confusing - but it's not. Just present it in the right way:

```bash
curl http://admin:admin@127.0.0.1:4502/api/content/sites.json | jq -c '. | .entities[]'
...
{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/experience-fragments.json"}],"class":["content/page"],"properties":{"dc:title":"Experience Fragments","name":"experience-fragments"}}
{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/screens.json"}],"class":["content/page"],"properties":{"dc:title":"Screens","name":"screens"}}
{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/campaigns.json"}],"class":["content/page"],"properties":{"dc:title":"Campaigns","name":"campaigns"}}
{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/sites.json"}],"class":["content/page"],"properties":{"dc:title":"Community Sites","name":"sites"}}
{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/forms.json"}],"class":["content/page"],"properties":{"name":"forms"}}
{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/community-components.json"}],"class":["content/page"],"properties":{"name":"community-components"}}
{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail.html"}],"class":["content/page"],"properties":{"dc:language":"en_US","dc:title":"We.Retail","name":"we-retail"}}
```

Better - but what if we want just the names:

```bash
curl http://admin:admin@127.0.0.1:4502/api/content/sites.json | jq -c '. | .entities[] | .properties | .name'
...
"experience-fragments"
"screens"
"campaigns"
"sites"
"forms"
"community-components"
"we-retail
```

or just the links:
```bash
curl http://admin:admin@127.0.0.1:4502/api/content/sites.json | jq --raw-output -c  '. | .entities[] | .links[].href'
...
http://127.0.0.1:4502/api/content/sites/experience-fragments.json
http://127.0.0.1:4502/api/content/sites/screens.json
http://127.0.0.1:4502/api/content/sites/campaigns.json
http://127.0.0.1:4502/api/content/sites/sites.json
http://127.0.0.1:4502/api/content/sites/forms.json
http://127.0.0.1:4502/api/content/sites/community-components.json
http://127.0.0.1:4502/api/content/sites/we-retail.json
http://127.0.0.1:4502/content/we-retail.html
```

# Content inspection

Now we know how to retrieve information. Let's use this knowledge.

```bash
curl http://admin:admin@127.0.0.1:4502/api/content/sites.json | jq --raw-output -c '. | .entities[] | .links[]'
...
{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail.json"}
{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail.html"}
```

> I leave the language processing as an execise to you.
> We skip forward to the content:

```bash
curl http://admin:admin@127.0.0.1:4502/api/content/sites/we-retail/us/en.infinity.json | jq -c --raw-output  '.'
...
{"entities":[{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail/us/en/user.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail/us/en/user.html"}],"class":["content/page"],"properties":{"hideInNav":"true","dc:title":"User","name":"user"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail/us/en/experience.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail/us/en/experience.html"}],"class":["content/page"],"properties":{"dc:title":"Experience","hideSubItemsInNav":true,"name":"experience"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail/us/en/men.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail/us/en/men.html"}],"class":["content/page"],"properties":{"dc:title":"Men","name":"men"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail/us/en/women.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail/us/en/women.html"}],"class":["content/page"],"properties":{"dc:title":"Women","name":"women"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail/us/en/equipment.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail/us/en/equipment.html"}],"class":["content/page"],"properties":{"dc:title":"Equipment","name":"equipment"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail/us/en/about-us.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail/us/en/about-us.html"}],"class":["content/page"],"properties":{"dc:title":"About Us","name":"about-us"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail/us/en/products.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail/us/en/products.html"}],"class":["content/page"],"properties":{"dc:language":"en","dc:title":"Products","coverImage":"/content/dam/we-retail/en/products/Product_catalog.jpg","name":"products"}},{"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail/us/en/community.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail/us/en/community.html"}],"class":["content/page"],"properties":{"pageTitle":"community","etcpath":"/libs/settings/community/templates/functions/activitystream","dc:title":"community","name":"community","languageCopies":["en"],"scoringRules":["community/scoring/rules/weretail-scoring"],"formPayload":"/var/community/publish/content/we-retail/us/en/community","badgingRules":["community/badging/rules/weretail-badging"],"navTitle":"Community"}}],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail/us/en.json"},{"rel":["parent"],"href":"http://127.0.0.1:4502/api/content/sites/we-retail/us.json"},{"rel":["content"],"href":"http://127.0.0.1:4502/content/we-retail/us/en.infinity.json"}],"class":["content/page"],"properties":{"dc:language":"en_US","cq:commerceProvider":"we-retail","cq:lastRolledout":"2016-06-29T14:20:45.039+02:00","cq:cartPage":"/content/we-retail/us/en/user/cart","cq:contextHubPath":"/libs/settings/cloudsettings/legacy/contexthub","cq:lastRolledoutBy":"admin","cq:contextHubSegmentsPath":"/conf/we-retail/settings/wcm/segments","dc:title":"English","cq:lastModified":"2016-06-29T14:20:45.038+02:00","name":"en","cq:lastModifiedBy":"admin","navRoot":true,"cq:checkoutPage":"/content/we-retail/us/en/user/cart","cq:template":"/conf/we-retail/settings/wcm/templates/hero-page","srn:paging":{"total":8,"offset":0,"limit":20}}}
```

This would be the human readable form:
```json
{
  "entities": [
    {
      "links": [
        {
          "rel": [
            "self"
          ],
          "href": "http://127.0.0.1:4502/api/content/sites/we-retail/us/en/user.json"
        },
        {
          "rel": [
            "content"
          ],
          "href": "http://127.0.0.1:4502/content/we-retail/us/en/user.html"
        }
      ],
      "class": [
        "content/page"
      ],
      "properties": {
        "hideInNav": "true",
        "dc:title": "User",
        "name": "user"
      }
    },
    {
      "links": [
        {
          "rel": [
            "self"
          ],
          "href": "http://127.0.0.1:4502/api/content/sites/we-retail/us/en/experience.json"
        },
        {
          "rel": [
            "content"
          ],
          "href": "http://127.0.0.1:4502/content/we-retail/us/en/experience.html"
        }
      ],
      "class": [
        "content/page"
      ],
      "properties": {
        "dc:title": "Experience",
        "hideSubItemsInNav": true,
        "name": "experience"
      }
    },
    {
      "links": [
        {
          "rel": [
            "self"
          ],
          "href": "http://127.0.0.1:4502/api/content/sites/we-retail/us/en/men.json"
        },
        {
          "rel": [
            "content"
          ],
          "href": "http://127.0.0.1:4502/content/we-retail/us/en/men.html"
        }
      ],
      "class": [
        "content/page"
      ],
      "properties": {
        "dc:title": "Men",
        "name": "men"
      }
    },
    {
      "links": [
        {
          "rel": [
            "self"
          ],
          "href": "http://127.0.0.1:4502/api/content/sites/we-retail/us/en/women.json"
        },
        {
          "rel": [
            "content"
          ],
          "href": "http://127.0.0.1:4502/content/we-retail/us/en/women.html"
        }
      ],
      "class": [
        "content/page"
      ],
      "properties": {
        "dc:title": "Women",
        "name": "women"
      }
    },
    {
      "links": [
        {
          "rel": [
            "self"
          ],
          "href": "http://127.0.0.1:4502/api/content/sites/we-retail/us/en/equipment.json"
        },
        {
          "rel": [
            "content"
          ],
          "href": "http://127.0.0.1:4502/content/we-retail/us/en/equipment.html"
        }
      ],
      "class": [
        "content/page"
      ],
      "properties": {
        "dc:title": "Equipment",
        "name": "equipment"
      }
    },
    {
      "links": [
        {
          "rel": [
            "self"
          ],
          "href": "http://127.0.0.1:4502/api/content/sites/we-retail/us/en/about-us.json"
        },
        {
          "rel": [
            "content"
          ],
          "href": "http://127.0.0.1:4502/content/we-retail/us/en/about-us.html"
        }
      ],
      "class": [
        "content/page"
      ],
      "properties": {
        "dc:title": "About Us",
        "name": "about-us"
      }
    },
    {
      "links": [
        {
          "rel": [
            "self"
          ],
          "href": "http://127.0.0.1:4502/api/content/sites/we-retail/us/en/products.json"
        },
        {
          "rel": [
            "content"
          ],
          "href": "http://127.0.0.1:4502/content/we-retail/us/en/products.html"
        }
      ],
      "class": [
        "content/page"
      ],
      "properties": {
        "dc:language": "en",
        "dc:title": "Products",
        "coverImage": "/content/dam/we-retail/en/products/Product_catalog.jpg",
        "name": "products"
      }
    },
    {
      "links": [
        {
          "rel": [
            "self"
          ],
          "href": "http://127.0.0.1:4502/api/content/sites/we-retail/us/en/community.json"
        },
        {
          "rel": [
            "content"
          ],
          "href": "http://127.0.0.1:4502/content/we-retail/us/en/community.html"
        }
      ],
      "class": [
        "content/page"
      ],
      "properties": {
        "pageTitle": "community",
        "etcpath": "/libs/settings/community/templates/functions/activitystream",
        "dc:title": "community",
        "name": "community",
        "languageCopies": [
          "en"
        ],
        "scoringRules": [
          "community/scoring/rules/weretail-scoring"
        ],
        "formPayload": "/var/community/publish/content/we-retail/us/en/community",
        "badgingRules": [
          "community/badging/rules/weretail-badging"
        ],
        "navTitle": "Community"
      }
    }
  ],
  "links": [
    {
      "rel": [
        "self"
      ],
      "href": "http://127.0.0.1:4502/api/content/sites/we-retail/us/en.json"
    },
    {
      "rel": [
        "parent"
      ],
      "href": "http://127.0.0.1:4502/api/content/sites/we-retail/us.json"
    },
    {
      "rel": [
        "content"
      ],
      "href": "http://127.0.0.1:4502/content/we-retail/us/en.infinity.json"
    }
  ],
  "class": [
    "content/page"
  ],
  "properties": {
    "dc:language": "en_US",
    "cq:commerceProvider": "we-retail",
    "cq:lastRolledout": "2016-06-29T14:20:45.039+02:00",
    "cq:cartPage": "/content/we-retail/us/en/user/cart",
    "cq:contextHubPath": "/libs/settings/cloudsettings/legacy/contexthub",
    "cq:lastRolledoutBy": "admin",
    "cq:contextHubSegmentsPath": "/conf/we-retail/settings/wcm/segments",
    "dc:title": "English",
    "cq:lastModified": "2016-06-29T14:20:45.038+02:00",
    "name": "en",
    "cq:lastModifiedBy": "admin",
    "navRoot": true,
    "cq:checkoutPage": "/content/we-retail/us/en/user/cart",
    "cq:template": "/conf/we-retail/settings/wcm/templates/hero-page",
    "srn:paging": {
      "total": 8,
      "offset": 0,
      "limit": 20
    }
  }
}
```
