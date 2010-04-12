
class Group
  NAMES = ['blog', 'dinero', 'doplacie', 'elotromundo', 'encargos', 'enciclopedia', 'enlaces', 'historietas', 'muvirecor', 'tierra']
  BY_NAME = {}
  GROUPS = []

  def initialize(name)
    @name = name
    GROUPS << self
    BY_NAME[name] = self
  end

  def clips
    Clip.find(:all, :conditions => {:group => @name}, :order => 'position')
  end

  def name
    @name
  end

  def to_param
    @name
  end
  
  def self.all
    GROUPS
  end

  def self.find(name)
    Group::BY_NAME[name]
  end

  NAMES.each {|n| Group.new(n)}
end
