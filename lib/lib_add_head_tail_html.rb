# lib_add_head_tail_html.rb
#   add header and tail to body (html)

def add_head_tail_html html_file

sample_md = <<'EOS'
---
title: 'GObject tutorial for beginners'
---

# sample header

Main contents begin here.

~~~{.C .numberLines}
int main(int argc, char **argv) {
}
~~~

|English|Japanese|
|:-----:|:------:|
|potato|jagaimo|
|carrot|ninjin|
|onion|tamanegi|
EOS

  File.write "sample.md", sample_md
  if (! system("pandoc", "-s", "-o", "sample.html", "sample.md"))
    raise ("add_head_tail_html: pandoc retuns error status #{$?}.\n")
  end
  sample_html = File.read("sample.html")
  sample_html.gsub!(/<html xmlns="http:\/\/www.w3.org\/1999\/xhtml" lang="" xml:lang="">/,'<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">')

  head = []
  sample_html.each_line do |l|
    if l =~ /<\/head>/
      break
    elsif l != "\n"
      head << l
    end
  end
  i = head.find_index { |line| line =~ /<\/style>/}
  raise "No </style> tag in sample.html which is generated by pandoc." unless i.instance_of?(Integer)
  head.insert(i, "    body {width: 1080px; margin: 0 auto; font-size: large;}\n")
  head.insert(i, "    h2 {padding: 10px; background-color: #d0f0d0; }\n")
  head.insert(i, "    div.sourceCode { margin: 10px; padding: 16px 10px 8px 10px; border: 2px solid silver; background-color: ghostwhite; overflow-x:scroll}\n")
  head.insert(i, "    pre:not(.sourceCode) { margin: 10px; padding: 16px 10px 8px 10px; border: 2px solid silver; background-color: ghostwhite; overflow-x:scroll}\n")
  head.insert(i, "    table {margin-left: auto; margin-right: auto; border-collapse: collapse; border: 1px solid;}\n")
  head.insert(i, "    th {padding: 2px 6px; border: 1px solid; background-color: ghostwhite;}\n")
  head.insert(i, "    td {padding: 2px 6px; border: 1px solid;}\n")
  head.insert(i, "    img {display: block; margin-left: auto; margin-right: auto;}\n")
  head.insert(i, "    figcaption {text-align: center;}\n")
  head << "</head>\n"
  head << "<body>\n"
  head = head.join

tail=<<'EOS'
</body>
</html>
EOS

  File.delete("sample.md")
  File.delete("sample.html")

  body = File.read(html_file)
  File.write(html_file, head+body+tail)
end

