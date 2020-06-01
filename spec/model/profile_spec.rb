require 'rails_helper'
describe Profile do
  describe '#create' do

    it "ユーザー本名の苗字が必須" do
      profile = build(:profile, first_name: "")
      profile.valid?
      expect(profile.errors[:first_name]).to include("を入力してください")
    end

    it "ユーザー本名の名前が必須" do
      profile = build(:profile, family_name: "")
      profile.valid?
      expect(profile.errors[:family_name]).to include("を入力してください")
    end

    it "ユーザー本名の苗字（ふりがな）が必須" do
      profile = build(:profile, first_name_kana: "")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("を入力してください")
    end

    it "ユーザー本名の名前（ふりがな）が必須" do
      profile = build(:profile, family_name_kana: "")
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("を入力してください")
    end

    it "生年月日が必須" do
      profile = build(:profile, birthday: "")
      profile.valid?
      expect(profile.errors[:birthday]).to include("を入力してください")
    end

    it "郵便番号が必須" do
      profile = build(:profile, post_number: "")
      profile.valid?
      expect(profile.errors[:post_number]).to include("を入力してください")
    end

    it "都道府県が必須" do
      profile = build(:profile, prefecture: "")
      profile.valid?
      expect(profile.errors[:prefecture]).to include("を入力してください")
    end

    it "市区町村が必須" do
      profile = build(:profile, city: "")
      profile.valid?
      expect(profile.errors[:city]).to include("を入力してください")
    end

    it "番地が必須" do
      profile = build(:profile, house_number: "")
      profile.valid?
      expect(profile.errors[:house_number]).to include("を入力してください")
    end

  end
end