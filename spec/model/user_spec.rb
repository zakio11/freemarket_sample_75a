require 'rails_helper'
describe User do
  describe '#create' do
    it "ニックネームが必須" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "メールアドレスは一意" do
      user = create(:user)
      #先に登録したユーザーと同じemailを持つユーザーのインスタンスを作成させる
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "メールアドレスは＠とドメインを含む" do
      user = build(:user, email: "aaabbb")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")

      user = build(:user, email: "aaa@")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end


    it "パスワードが必須" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードは７文字以上" do
      user = build(:user, password: "11111")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "パスワードは確認用を含め２回入力する" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end
end