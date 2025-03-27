#!/usr/bin/env ruby
# 博客迁移脚本

require 'fileutils'
require 'date'

# 源目录和目标目录
SOURCE_DIR = "weimao.me"
TARGET_DIR = "_posts"

# 要处理的目录
DIRS_TO_PROCESS = [
  "macintosh",
  "疯言疯语",
  "讲点正事儿",
  "日本之旅",
  "两人一狗去拉萨",
  "日記",
  "photography"
]

# 确保目标目录存在
DIRS_TO_PROCESS.each do |dir|
  FileUtils.mkdir_p(File.join(TARGET_DIR, dir))
end

# 处理单个文件
def process_file(src_path, category)
  begin
    content = File.read(src_path)
    
    # 提取元数据
    title_match = content.match(/Title: (.+)/)
    date_match = content.match(/Date: (.+)/)
    url_match = content.match(/URL: (.+)/)
    tags_match = content.match(/Tags: (.+)/)
    
    return unless title_match && date_match # 跳过没有标题和日期的文件
    
    title = title_match[1].strip
    date = date_match[1].strip
    permalink = url_match ? url_match[1].strip : nil
    tags = tags_match ? tags_match[1].strip.split(/\s*,\s*/) : []
    
    # 从内容中移除元数据
    content_without_meta = content.sub(/Title:.+\n/, "")
                                 .sub(/Date:.+\n/, "")
                                 .sub(/URL:.+\n/, "") if url_match
    content_without_meta = content_without_meta.sub(/Tags:.+\n/, "") if tags_match
    
    # 提取日期并创建文件名
    date_obj = begin
      DateTime.parse(date)
    rescue
      DateTime.now # 如果日期解析失败，使用当前日期
    end
    
    date_prefix = date_obj.strftime("%Y-%m-%d")
    
    # 从URL或标题创建文件名部分
    if permalink
      filename_part = permalink.gsub(/^\/|\/$/,"") # 移除开头和结尾的斜杠
    else
      filename_part = title.downcase.gsub(/\s+/, "-").gsub(/[^\w\-]/, "")
    end
    
    # 创建目标文件名
    target_filename = "#{date_prefix}-#{filename_part}.md"
    target_path = File.join(TARGET_DIR, category, target_filename)
    
    # 创建Jekyll前置数据
    front_matter = <<~YAML
    ---
    layout: post
    title: "#{title}"
    date: #{date}
    #{permalink ? "permalink: #{permalink}" : ""}
    tags: 
    #{tags.map { |tag| "  - #{tag.strip}" }.join("\n")}
    categories: #{category}
    ---

    #{content_without_meta.strip}
    YAML
    
    # 写入文件
    File.write(target_path, front_matter)
    puts "Processed: #{target_path}"
  rescue => e
    puts "Error processing #{src_path}: #{e.message}"
  end
end

# 主处理逻辑
DIRS_TO_PROCESS.each do |dir|
  source_dir = File.join(SOURCE_DIR, dir)
  next unless Dir.exist?(source_dir)
  
  Dir.glob(File.join(source_dir, "*.md")).each do |file|
    process_file(file, dir)
  end
  
  # 也处理txt文件
  Dir.glob(File.join(source_dir, "*.txt")).each do |file|
    process_file(file, dir)
  end
end

puts "迁移完成！" 