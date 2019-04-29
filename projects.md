---
layout: page
title: Projects
---

{% for projects in site.projects %}


<h4><a href="{{ projects.url | prepend: site.baseurl }}">
      {{ projects.title }}
</a></h4>

<p class="post-excerpt">{{ projects.field | truncate: 160 }}</p>

<br>

{% endfor %}  
