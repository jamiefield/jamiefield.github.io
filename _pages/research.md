---
layout: archive
title: "Research"
permalink: /research/
author_profile: true
---
**Published papers**

8: Banks, G. C., Field, J. G., Oswald, F. L., O’Boyle, E. H., Landis, R. S., Rogelberg, S., G., & Rupp, D., E. (2019). Answers to 18 Questions About Open Science Practices. <i>Journal of Business and Psychology</i>, <i>34</i>, 257-270. doi: [10.1007/s10869-018-9547-8](https://doi.org/10.1007/s10869-018-9547-8).

7: Bennett, A. A., Bakker, A. B., & Field, J. G. (2018). Recovery from work-related effort: A meta-analysis. <i>Journal of Organizational Behavior</i>, <i>39</i>, 262-275. doi: [10.1002/job.2217](http://doi.org/10.1002/job.2217).

6: Lakens, D., Adolfi, F. G., Albers, C. J., Anvari, F., Apps, M. A. J., Argamon, S. E., … Zwaan, R. A. (2018). Justify your alpha. <i>Nature Human Behavior</i>, <i>2</i>, 168-171. doi: [10.1038/s41562-018-0311-x](https://doi.org/10.1038/s41562-018-0311-x).
Preprint available at [psyarxiv.com/9s3y6](https://psyarxiv.com/9s3y6)

5: Bosco, F. A., Aguinis, H., Field, J. G., Pierce, C. A., & Dalton, D. R. (2016). HARKing’s threat to organizational research: Evidence from primary and meta-analytic sources. <i>Personnel Psychology</i>, <i>69</i>, 709-750. doi: [10.1111/peps.12111](http://doi.org/10.1111/peps.12111).

4: Bosco, F. A., Steel, P., Oswald, F. O., Uggerslev, K., Field, J. G. (2015). Cloud-based meta-analyses to bridge science and practice: Welcome to metaBUS. <i>Personnel Assessment and Decisions</i>, <i>1</i>, 3-17. doi: [10.25035/pad.2015.002](http://doi.org/10.25035/pad.2015.002).

3: Open Science Collaboration. (2015). Estimating the reproducibility of psychological science. <i>Science</i>, 6251. doi: [10.1126/science.aac4716](http://doi.org/10.1126/science.aac4716).

2: Bosco, F. A., Aguinis, H., Singh, K., Field, J. G., & Pierce, C. A. (2015). Correlational effect size benchmarks. <i>Journal of Applied Psychology</i>, <i>100</i>, 431-449. doi: [10.1037/a0038047](http://doi.org/10.1037/a0038047).

1:Open Science Collaboration. (2012). An open, large-scale, collaborate effort to estimate the reproducibility of psychological science. <i>Perspective on Psychological Science</i>, <i>7</i>, 657-660. doi: [10.1177/1745691612462588](http://doi.org/10.1177/1745691612462588).

**Conference presentations**


{% if author.googlescholar %}
  You can also find my articles on <u><a href="{{author.googlescholar}}">my Google Scholar profile</a>.</u>
{% endif %}

{% include base_path %}

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
