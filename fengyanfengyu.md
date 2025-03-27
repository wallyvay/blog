---
layout: page
title: 疯言疯语
permalink: /疯言疯语/
---

这里是位毛的随想录、日常生活分享和各种有的没的。

<ul class="post-list">
  {% for post in site.posts %}
    {% if post.categories contains '疯言疯语' %}
      <li>
        <span class="post-meta">{{ post.date | date: "%Y-%m-%d" }}</span>
        <h3>
          <a class="post-link" href="{{ post.url | relative_url }}">{{ post.title }}</a>
        </h3>
        {% if post.tags.size > 0 %}
          <div class="post-tags">
            {% for tag in post.tags %}
              <span class="post-tag">{{ tag }}</span>
            {% endfor %}
          </div>
        {% endif %}
      </li>
    {% endif %}
  {% endfor %}
</ul>

<style>
  .post-list {
    list-style: none;
    padding: 0;
  }
  .post-list li {
    margin-bottom: 20px;
    border-bottom: 1px solid #eee;
    padding-bottom: 15px;
  }
  .post-tags {
    margin-top: 5px;
  }
  .post-tag {
    display: inline-block;
    background: #f5f5f5;
    padding: 2px 8px;
    margin-right: 5px;
    border-radius: 3px;
    font-size: 12px;
    color: #777;
  }
</style> 