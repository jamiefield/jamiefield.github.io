---
layout: archive
title: "Research"
permalink: /research/
author_profile: true
---
More to come soon...

'Banks, G. C., Field, J. G., Oswald, F. L., O’Boyle, E. H., Landis, R. S., Rogelberg, S., G., & Rupp, D., E. (2019). Answers to 18 Questions About Open Science Practices. <i>Journal of Business and Psychology</i>, <i>34</i>, 257-270. doi: [10.1007/s10869-018-9547-8](10.1007/s10869-018-9547-8).'

{% if author.googlescholar %}
  You can also find my articles on <u><a href="{{author.googlescholar}}">my Google Scholar profile</a>.</u>
{% endif %}

{% include base_path %}

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
