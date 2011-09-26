# encoding: utf-8
require "prawn/measurement_extensions"

module PdfTemplate
  class StoryCard
    attr_accessor :week, :document
    
    CARD_WIDTH = 133
    CARD_HEIGHT = 85
    LIMIT_TODO_ITEMS = 6
    
    def initialize(week)
      @week = week
      
      @document = Prawn::Document.new(
            :page_size => "A4",
            :page_layout => :landscape,
            :left_margin => 20,
            :right_margin => 20,
            :info => {
                :Title => 'Story Cards',
                :Author => "Screen Concept",
                # :Subject => "Story Cards der Woche #{@week.nr}",
                :Creator => "Screen Concept",
                :CreationDate => Time.now
            }
        )
    end
    
    def to_pdf
      positioning = [ [0, 0], [420, 0], [0, 280], [420, 280] ]
      
      @week.todo_lists.each_with_index do |todo_list, index|
        x_coordinate = @document.bounds.left+(positioning[index%4]).first
        y_coordinate = @document.bounds.top-(positioning[index%4]).last
        
        draw_story_card(todo_list, x_coordinate, y_coordinate)
        
        @document.start_new_page if (index+1) % 4 == 0
      end
      @document
    end
    
    
    private
    def draw_story_card(todo_list, x_coordinate, y_coordinate)
      @document.bounding_box [x_coordinate, y_coordinate], :width => CARD_WIDTH.mm, :height => CARD_HEIGHT.mm do
        draw_header(todo_list)
        
        todo_list.todo_items.limit(LIMIT_TODO_ITEMS).each_with_index do |item, item_index|
          @document.bounding_box [10, @document.cursor], :width => CARD_WIDTH.mm  do
            @document.text_box "- ", :size => 8, :at => [@document.cursor, @document.cursor]
            
            @document.indent(20) do
              @document.text_box "#{item.name}", :size => 8, :at => [@document.cursor, @document.cursor], :height => 6.mm, :overflow => :truncate
            end
            @document.move_down(20)
          end
        end
        
        if todo_list.todo_items.size > LIMIT_TODO_ITEMS
          @document.move_down(5)
          @document.text_box "noch weitere #{todo_list.todo_items.size - LIMIT_TODO_ITEMS} Items", :at => [10, @document.cursor], :size => 10
        end
      end
    end
    
    def draw_header(todo_list)
      @document.text_box "#{todo_list.project.name} - #{todo_list.project.p_number} (Woche #{@week.nr})", :size => 10, :at => [10, 245], :align => :right
      @document.text_box "##{todo_list.basecamp_id}: #{todo_list.name} (#{todo_list.estimate}h)", :size => 15, :at => [10, 225]
      @document.move_down(70)
    end
  end
end