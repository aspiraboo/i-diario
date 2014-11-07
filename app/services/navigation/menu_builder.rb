module Navigation
  class MenuBuilder < Builder::Base
    def initialize(item, context, render = MenuRender)
      super(item, context, render)
    end

    def build
      amount_***REMOVED***s
      render
    end

    protected

    def amount_***REMOVED***s
      amount_nodes navigation do |***REMOVED***|
        ***REMOVED***s << ***REMOVED***
      end
    end

    def amount_nodes(nodes, parent_***REMOVED*** = nil)
      nodes.each do |node|
        ***REMOVED***s << node_values(node["***REMOVED***"], parent_***REMOVED***)
      end
    end

    def node_values(node, parent_***REMOVED***)
      {}.tap do |***REMOVED***|
        ***REMOVED***[:type]      = node["type"]
        ***REMOVED***[:icon]      = node["icon"]
        ***REMOVED***[:path]      = node["path"]
        ***REMOVED***[:css_class] = []
        ***REMOVED***[:subnodes]  = []

        if hash[:type] == item
          hash[:css_class] << :current
          parent_***REMOVED***[:css_class] << :open if parent_***REMOVED***
        end

        amount_nodes node["***REMOVED***"]["sub***REMOVED***s"], ***REMOVED*** do |subnode|
          ***REMOVED***[:subnodes] << subnode
        end
      end
    end

    def render
      navigation_render.render(***REMOVED***)
    end
  end
end