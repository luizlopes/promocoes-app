require 'rails_helper'

describe ExpirePromotionsJob do
  it 'should notify using delay jobs' do
    travel_to 30.days.ago
    promotion = create(:promotion, days: 10)
    travel_back

    ExpirePromotionsJob.auto_enqueue(promotion.id)

    expect(Delayed::Worker.new.work_off).to eq [1, 0]
  end

  it 'should expire promotion' do
    travel_to 30.days.ago
    promotion = create(:promotion, days: 10, status: :activated, activated_at: Time.zone.today)
    travel_back

    allow(Promotion).to receive(:find).with(promotion.id).and_return(promotion)
    expect(promotion).to receive(:expired!).once
    
    ExpirePromotionsJob.auto_enqueue(promotion.id)
    Delayed::Worker.new.work_off
  end
end
