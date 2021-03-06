class ScoreRounder

  def initialize(classroom)
    raise ArgumentError unless classroom.exam_rule
    @exam_rule = classroom.exam_rule
    @classroom = classroom
  end

  def round(score)
    return 0.0 if score.nil?

    score_decimal_part = decimal_part(score)

    rounding_table_value =
      custom_rounding_table_value(score_decimal_part)

    rounded_score = score
    if rounding_table_value
      rounded_score =
        case rounding_table_value.action
        when RoundingTableAction::NONE
          score
        when RoundingTableAction::BELOW
          round_to_below(score)
        when RoundingTableAction::ABOVE
          round_to_above(score)
        when RoundingTableAction::SPECIFIC
          round_to_exact_decimal(score, rounding_table_value.exact_decimal_place)
        end
    end

    truncate_score(rounded_score.to_f)
  end

  private

  attr_accessor :exam_rule

  delegate :rounding_table, to: :exam_rule, prefix: true, allow_nil: true

  def custom_rounding_table_value(score_decimal_part)
    if rounding_table_id = custom_rounding_table_id
      CustomRoundingTableValue.
        find_by(custom_rounding_table_id: rounding_table_id, label: score_decimal_part)
    end
  end

  def custom_rounding_table_id
    CustomRoundingTable.by_year(@classroom.year).
      by_unity(@classroom.unity_id).
      by_grade(@classroom.grade_id).first.try(:id)
  end

  def decimal_part(value)
    parts = value.to_s.split(".")
    decimal_part = parts.count > 1 ? parts[1][0].to_s : 0
    decimal_part
  end

  def round_to_exact_decimal(score, exact_decimal_place)
    "#{score.floor}.#{exact_decimal_place}".to_f
  end

  def round_to_above(score)
    score.ceil
  end

  def round_to_below(score)
    score.floor
  end

  def truncate_score(score)
    parts = score.to_s.split(".")
    integer_part = parts[0]
    decimal_part = parts[1][0]
    "#{integer_part}.#{decimal_part}".to_f
  end

end
