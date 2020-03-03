---
permalink: /
excerpt: "About me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---
<h1> About </h1>
<p>I am an Assistant of Management at West Virginia University's <a href="https://business.wvu.edu">John Chambers College of Business and Economics</a>. My research focuses on topics pertaining to organizational behvaior, human research management, and organizational research mthods and has been published in outlets like <i>Science</i>, <i>Nature: Human Behavior</i>, <i>Journal of Applied Psychology</i>, <i>Personnel Psychology</i>, and <i>Journal of Business and Psychology</i>. I am interested in how big data can be leveraged to improve organizational research methodology and better our understanding of organizational behavior and human resource management phenomena. In particular, I believe that the unification of large and diverse data sets, existing statistical analysis techniques like meta-analysis and relative importance analysis, and sound theoretical reasoning will help create science that is worthy of guiding practice.</p>

<img src='/images/WVU1.jpg'>

    <div class="visible-sm visible-xs"></div>

    <div class="col-xs-12 col-md-8">

        {{ .Content }}

        <div class="row">

            <div class="col-md-5">
                <h3>Interests</h3>
                <ul>
                    {{ range .Site.Params.interests }}
                    <li>{{ . }}</li>
                    {{ end }}
                </ul>
            </div>

            <div class="col-md-7">
                <h3>Education</h3>
                <ul class="ul-edu fa-ul">
                    {{ range .Site.Params.education }}
                    <li>
                        <i class="fa-li fa fa-graduation-cap"></i>
                        <div class="description">
                            <p class="course">{{ .course }}, {{ .year }}</p>
                            <p class="institution">{{ .institution }}</p>
                        </div>
                    </li>
                    {{ end }}
                </ul>
            </div>

        </div>
