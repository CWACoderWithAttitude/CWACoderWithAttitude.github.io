---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: default
---

Ideas, opinions, mistakes and errors are mine. Stuff shown here does not necessarily reflect my employers ideas.

<h2>Posts</h2>
<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span> - {{ post.date | date: "%B %e, %Y" }}</span>
    </li>
  {% endfor %}
</ul>