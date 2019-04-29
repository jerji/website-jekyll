---
layout: page
title: Projects
---

{% for projects in site.projects %}


<h2><a href="{{ projects.url | prepend: site.baseurl }}">
      {{ projects.title }}
</a></h2>

<p class="post-excerpt">{{ projects.field | truncate: 160 }}</p>

{% endfor %}  
