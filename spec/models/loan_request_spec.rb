require "rails_helper"

RSpec.describe LoanRequest, type: :model do

  let(:loan_request) {
    LoanRequest.new(title: "Farm Tools",
                    description: "help out with the farm tools",
                    amount: "$100.00",
                    requested_by_date: "06/01/2015",
                    repayment_begin_date: "12/01/2015",
                    repayment_rate: "Monthly")
  }

  context "with invalid attributes" do
    it "is invalid without any attributes" do
      loan_request = LoanRequest.new
      expect(loan_request).to_not be_valid
    end

    it "is invalid without a title" do
      loan_request.title = ""
      expect(loan_request).to_not be_valid
    end

    it "is invalid without a description" do
      loan_request.description = ""
      expect(loan_request).to_not be_valid
    end

    it "is invalid without an amount" do
      loan_request.amount = ""
      expect(loan_request).to_not be_valid
    end

    it "is invalid without a requested by date" do
      loan_request.requested_by_date = ""
      expect(loan_request).to_not be_valid
    end

    it "is invalid without a repayment begin date" do
      loan_request.repayment_begin_date = ""
      expect(loan_request).to_not be_valid
    end

    it "is invalid without a repayment rate" do
      loan_request.repayment_rate = ""
      expect(loan_request).to_not be_valid
    end
  end

  context "valid attributes" do
    it "belongs to a category" do
      loan_request.save
      loan_request.categories.create(title: "Agriculture", description: "Farm animals and an eventual meal")
      expect(loan_request.categories.first.title).to eq("Agriculture")
    end
  end

end
