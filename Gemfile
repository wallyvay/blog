source "https://rubygems.org"

# Ruby 2.6.10兼容性
gem "jekyll", "~> 3.9.0"
gem "kramdown-parser-gfm"

# GitHub Pages环境
gem "github-pages", group: :jekyll_plugins

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem "jekyll-seo-tag", "~> 2.7"
end

# Windows和JRuby不包括zoneinfo文件，所以需要这个
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

# Windows通常需要性能监控工具
gem "webrick", "~> 1.7", :platforms => [:mingw, :x64_mingw, :mswin, :jruby, :ruby]

# 指定兼容版本
gem "public_suffix", "< 6.0" 