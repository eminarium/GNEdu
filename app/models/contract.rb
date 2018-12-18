class Contract < ActiveRecord::Base
  belongs_to :season
  belongs_to :group
  belongs_to :student
  belongs_to :discount
  belongs_to :payment_type
  belongs_to :special_group
  belongs_to :book_contest_participant
  has_one :final

  has_many :attendances
  #has_many :attendance_sheets, :through => :attendances

  validates_presence_of :season_id, :message => "'Tapgyry' hökman saýlanmaly ..."
  validates_presence_of :group_id, :message => "'Topary' hökman saýlanmaly ..."
  validates_presence_of :student_id, :message => "'Diňleýji' hökman saýlanmaly ..."
  validates_presence_of :registrationDate, :message => "'Senesi' hökman saýlanmaly ..."
  validates_presence_of :payment_type_id, :message => "'Töleg Görnüşi' hökman saýlanmaly ..."
  validates_presence_of :amountPaid, :message => "'Tölenen Töleg' hökman girizilmeli ..."


  MONTH_NAMES_TM = [ "Ýanwar", "Fewral", "Mart", "Aprel", "Maý", "Iýun", "Iýul", "Awgust", "Sentýabr", "Oktýabr", "Noýabr", "Dekabr" ]
  MONTH_NAMES_RU = [ "Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь" ]

  def int_to_text(amount)
    #MONTH_NAMES = [[0,""], [1,"bir"], [2,"iki"], [3,"üç"], [4,"dört"], [5,"bäş"], [6,"alty"], [7,"ýedi"], [8,"sekiz"], [9,"dokuz"]]
    #[10,"on"], [20,"ýigrimi"], [30,"otuz"], [40,"kyrk"], [50,"elli"], [60,"altmyş"], [70,"ýetmiş"], [80,"segsen"], [90,"togsan"], [100,"ýüz"]]

    #SINGLE_PARTS = ["", "bir", "iki", "üç", "dört", "bäş", "alty", "ýedi", "sekiz", "dokuz"]
    #TENS = [[1,"on"], [2,"ýigrimi"], [3,"otuz"], [4,"kyrk"], [5,"elli"], [6,"altmyş"], [7,"ýetmiş"], [8,"segsen"], [9,"togsan"]]
    @single_parts = [ "", "bir", "iki", "üç", "dört", "bäş", "alty", "ýedi", "sekiz", "dokuz"]
    @ten_parts = [ "", "on", "ýigrimi", "otuz", "kyrk", "elli", "altmyş", "ýetmiş", "segsen", "togsan"]

    @hundreds = (amount/100).to_i
    @result = amount%100
    @tens = (@result/10).to_i
    @result = amount%10
    @singles = @result


    @result = ((amount>99) ? @single_parts[@hundreds].to_s.capitalize+" ýüz " : "")+((amount>9) ? @ten_parts[@tens].to_s : "")+" "+@single_parts[@singles].to_s

    if amount==0
      @result = " 0 "
    end

    return @result

  end

end
