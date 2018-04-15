class RankingController < ApplicationController
  def want
    @ranking_counts = Want.ranking
    @items = Item.find(@ranking_counts.keys)
    # keysでハッシュの中からkeyだけとりだす
  end
end
