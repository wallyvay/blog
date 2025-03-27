#!/bin/bash

# 创建图片目录
mkdir -p assets/images

# 将 _cover.jpg 复制到 assets/images 目录
cp _cover.jpg assets/images/cover.jpg

# 复制 resume.md
cp resume.md _posts/$(date +%Y-%m-%d)-resume.md

# 遍历所有 md 和 txt 文件
find 疯言疯语 讲点正事儿 日本之旅 两人一狗去拉萨 日記 photography -type f \( -name "*.md" -o -name "*.txt" \) | while read file; do
  # 获取文件名（不包含路径和扩展名）
  filename=$(basename "$file")
  extension="${filename##*.}"
  filename="${filename%.*}"
  
  # 获取目录名作为分类
  category=$(dirname "$file" | sed 's/\///'g)
  
  # 读取文件内容
  content=$(cat "$file")
  
  # 如果文件已经有 YAML front matter，跳过
  if [[ "$content" =~ ^---.*---$ ]]; then
    echo "File $file already has front matter, processing..."
  
    # 提取日期信息
    date=$(echo "$content" | grep -i "Date:" | sed -E 's/Date:\s*//i')
    
    if [ -z "$date" ]; then
      # 如果没有日期，使用文件修改时间
      date=$(date -r "$file" +"%Y-%m-%d %H:%M:%S")
    fi
    
    # 格式化日期为 YYYY-MM-DD
    formatted_date=$(date -j -f "%Y-%m-%d %H:%M:%S" "$date" +"%Y-%m-%d" 2>/dev/null || date -j -f "%Y-%m-%d" "$date" +"%Y-%m-%d" 2>/dev/null || echo "$(date +%Y-%m-%d)")
    
    # 创建新的文件名
    new_filename="_posts/${formatted_date}-${filename}.md"
    
    # 如果是 txt 文件，要转换为 md 格式
    if [ "$extension" = "txt" ]; then
      # 假设没有 front matter，添加一个
      echo "---" > "$new_filename"
      echo "layout: post" >> "$new_filename"
      echo "title: \"$filename\"" >> "$new_filename"
      echo "date: $formatted_date" >> "$new_filename"
      echo "categories: [$category]" >> "$new_filename"
      echo "---" >> "$new_filename"
      echo "" >> "$new_filename"
      cat "$file" >> "$new_filename"
    else
      # 替换旧的 front matter
      cat "$file" | awk -v cat="$category" 'BEGIN {p=0;}
      /^---/ && p==0 {print "---"; print "layout: post"; p=1; next;}
      /^---/ && p==1 {print "categories: [" cat "]"; print "---"; p=2; next;}
      p==1 {if ($0 ~ /^URL:/ || $0 ~ /^Status:/) next; else print;}
      p==2 {print;}' > "$new_filename"
    fi
    
    echo "Migrated $file to $new_filename"
  else
    # 没有 front matter，添加一个
    # 使用文件修改时间作为日期
    date=$(date -r "$file" +"%Y-%m-%d")
    new_filename="_posts/${date}-${filename}.md"
    
    echo "---" > "$new_filename"
    echo "layout: post" >> "$new_filename"
    echo "title: \"$filename\"" >> "$new_filename"
    echo "date: $date" >> "$new_filename"
    echo "categories: [$category]" >> "$new_filename"
    echo "---" >> "$new_filename"
    echo "" >> "$new_filename"
    
    if [ "$extension" = "txt" ]; then
      cat "$file" >> "$new_filename"
    else
      cat "$file" >> "$new_filename"
    fi
    
    echo "Migrated $file to $new_filename"
  fi
done

# 替换文章中的图片链接
find _posts -type f -name "*.md" | xargs sed -i '' -E 's|\!\[\]\((http[s]?://img\.weimao\.me/[^)]+)\)|\![](\1){:loading="lazy" class="img-responsive"}|g'
find _posts -type f -name "*.md" | xargs sed -i '' -E 's|\!\[\]\((http[s]?://weimaofiles\.b0\.upaiyun\.com/[^)]+)\)|\![](\1){:loading="lazy" class="img-responsive"}|g'

echo "迁移完成！" 