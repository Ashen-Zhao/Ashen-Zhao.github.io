require 'stringex'
module Jekyll
    class CategoryListTag < Liquid::Tag
        def render(context)
            category_dir = context.registers[:site].config['category_dir']
            categories = context.registers[:site].categories.keys
            categories.sort.reduce("") do |html, category|
                posts_in_category = context.registers[:site].categories[category].size
                att = Jekyll.get_category_attributes(category)
                html << "<li class='category'><a href='/#{category_dir}/#{att[0]}/'>#{att[1]} (#{posts_in_category})</a></li>\n"
            end
        end
    end
end

Liquid::Template.register_tag('category_list', Jekyll::CategoryListTag)