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

Headless means programatic access to the content. Resources like sites, pages etc. are represented by JSON objects instead of HTML web pages.
Access follows the REST paradigm by denoting entities with paths and specifying actions using HTTP verbs like GET, POST, PUT, DELETE...

## How about Apache Sling?

AEM contains [Apache Sling](https://sling.apache.org/). Sling provides [RESTful access](https://cwiki.apache.org/confluence/display/SLING/FAQ#FAQ-RESTfulAPI).


![Sling Request Processing
](https://helpx.adobe.com/content/dam/help/en/experience-manager/6-3/sites/developing/using/the-basics/_jcr_content/main-pars/image_1/chlimage_1.png)

Similarities are quite obvious - so are the differences.

In Sling you would specify the desired output format using the extension. (`.html`, `.json`,..) you get the point.

So, the URL is a bit misused.

In HTTP the URL just denotes the exact location of the resource. The preferred format is requested by sending appropriate headers with the request.

An in-depth comparison is not in the scope of this document. The links above will point you to further and much more detailed information.

## What does Adobe say?

Adobe lists [Content as a Service
](https://www.adobe.com/marketing/experience-manager-sites/content-as-a-service.html) as part of their [Experience Manager Sites](https://www.adobe.com/marketing/experience-manager-sites.html)

Headless access is just one aspect of there [omni-channel hybrid headless CMS](https://www.adobe.com/de/marketing/experience-manager-sites/competitors.html).


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

Accessing data is not consistent throughout different aspects of AEM.

- Content
- Screens
> Content for special devices. Could be the huge displays you see on busstops, airports or trainstations. Or your smartwatsch
- Fragments
> [Experience Fragments can be used](https://helpx.adobe.com/experience-manager/6-4/screens/using/experience-fragments-in-screens.html) to easily prepare content for devices. Fragemnts are used to implement screens.
- [Assets](https://helpx.adobe.com/experience-manager/6-3/assets/using/mac-api-assets.html) / DAM
> Anything digital. Image, video, pdf, xls,...

All aspects have one thing in common: [Siren](https://github.com/kevinswiber/siren). Siren is [HATEOAS](https://en.wikipedia.org/wiki/HATEOAS) - but for JSON.

Accessing asset resources follows the REST paradigm. REST describes entities like pages, images,... etc.
Since this lacks the most interesting and important part: the relations between them a second paradigm - [siren](https://github.com/kevinswiber/siren) and [Google discussion group on Siren Hypermedia](https://groups.google.com/forum/#!forum/siren-hypermedia)- is applied.

A good description of REST can be found [here](https://medium.com/@marinithiago/guys-rest-apis-are-not-databases-60db4e1120e4)

They offer information on content navigation on [Navigating Content Structure ](https://helpx.adobe.com/experience-manager/6-4/screens/using/rest-api.html)

The latter link is about dealing with [AEM Screens (German)](https://helpx.adobe.com/de/experience-manager/6-4/sites/deploying/using/aem-screens-introduction.html), [
Introduction to AEM Screens](https://helpx.adobe.com/experience-manager/kt/eseminars/gems/aem-introduction-to-aem-screens.html)
This also mentions cordova integration.


### Getting started links

* [Getting Started with Core Components and the Style System](https://helpx.adobe.com/experience-manager/kt/sites/using/style-system-core-components-tutorial-develop.html)
* [AEM Fluid Experiences for headless usecases](https://helpx.adobe.com/experience-manager/kt/eseminars/gems/aem-headless-usecases.html)
* [AEM as a Headless CMS](http://aempodcast.com/2017/aem-resources/aem-headless-cms/#.XJDnexNKiL8)
* [Experience-Cloud: Headless CMS
](https://www.adobe.com/de/experience-cloud/topics/headless-cms.html)


## Getting fingers dirty

All published endpoints are prefixed with `/api` to distinguish them from regular content URLs.
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
curl http://admin:admin@127.0.0.1:4502/api/content/sites.json \
  | jq -c '. | .entities[] | .properties | .name'
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
curl http://admin:admin@127.0.0.1:4502/api/content/sites.json | \
    jq --raw-output -c  '. | .entities[] | .links[].href'
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

As we can see there's plenty of detailed info available.
In a structured machine parsable way.


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

## Retrieving assets (DAM objects)

`$> curl -u admin:admin http://127.0.0.1:4502/api/assets.json`

```
{"entities":[{"rel":["child"],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/assets/we-unlimited-app.json"}],"class":["assets/folder"],"properties":{"name":"we-unlimited-app"}},{"rel":["child"],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/assets/projects.json"}],"class":["assets/folder"],"properties":{"name":"projects"}},{"rel":["child"],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/assets/catalogs.json"}],"class":["assets/folder"],"properties":{"name":"catalogs"}},{"rel":["child"],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/assets/we-retail-screens.json"}],"class":["assets/folder"],"properties":{"name":"we-retail-screens"}},{"rel":["child"],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/assets/formsanddocuments.json"}],"class":["assets/folder"],"properties":{"name":"formsanddocuments"}},{"rel":["child"],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/assets/we-retail.json"}],"class":["assets/folder"],"properties":{"name":"we-retail"}},{"rel":["child"],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/assets/we-retail-client-app.json"}],"class":["assets/folder"],"properties":{"name":"we-retail-client-app"}},{"rel":["child"],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/assets/templates.json"}],"class":["assets/folder"],"properties":{"name":"templates"}},{"rel":["child"],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/assets/formsanddocuments-themes.json"}],"class":["assets/folder"],"properties":{"name":"formsanddocuments-themes"}}],"links":[{"rel":["self"],"href":"http://127.0.0.1:4502/api/assets.json"},{"rel":["parent"],"href":"http://127.0.0.1:4502/api.json"}],"class":["assets/folder"],"actions":[{"method":"POST","name":"add-folder","href":"http://127.0.0.1:4502/api/assets/*","title":"Add Folder","fields":[{"name":"name","type":"text"}]},{"method":"PUT","name":"update","href":"http://127.0.0.1:4502/api/assets","type":"application/vnd.siren+json","title":"Update","fields":[{"name":"data","type":"text"}]},{"method":"DELETE","name":"delete","href":"http://127.0.0.1:4502/api/assets","title":"Delete"},{"method":"POST","name":"add-asset","href":"http://127.0.0.1:4502/api/assets/*","title":"Add Asset","fields":[{"name":"name","type":"text"},{"name":"file","type":"file"}]}],"properties":{"cq:allowedTemplates":["/libs/dam/templates/assetshare","/libs/dam/templates/asseteditor"],"name":"assets","srn:paging":{"total":9,"offset":0,"limit":20}}}%
```

## Lets retrieve all available asset folders

```
$ curl -u admin:admin http://127.0.0.1:4502/api/assets.json \
      | jq --raw-output '.entities[] | .class[] + " : " + .properties.name + " : " + .links[0].href'

assets/folder : we-unlimited-app : http://127.0.0.1:4502/api/assets/we-unlimited-app.json
assets/folder : projects : http://127.0.0.1:4502/api/assets/projects.json
assets/folder : catalogs : http://127.0.0.1:4502/api/assets/catalogs.json
assets/folder : we-retail-screens : http://127.0.0.1:4502/api/assets/we-retail-screens.json
assets/folder : formsanddocuments : http://127.0.0.1:4502/api/assets/formsanddocuments.json
assets/folder : we-retail : http://127.0.0.1:4502/api/assets/we-retail.json
assets/folder : we-retail-client-app : http://127.0.0.1:4502/api/assets/we-retail-client-app.json
assets/folder : templates : http://127.0.0.1:4502/api/assets/templates.json
assets/folder : formsanddocuments-themes : http://127.0.0.1:4502/api/assets/formsanddocuments-themes.json
```


##
