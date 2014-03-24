require 'spec_helper'

describe Comment do
  context '-Creation-' do

    let (:valid_params) {{user_id: 1, post_id:1, comment: "DJesus sucks at bowling"}}
    let (:dudecomment) {Comment.new(valid_params)}

    it 'has a user id' do
      dudecomment.user_id = nil
      expect(dudecomment).to_not be_valid
      expect(dudecomment.errors[:user_id]).to_not be_blank
    end

    it 'has a post id' do
      dudecomment.post_id = nil
      expect(dudecomment).to_not be_valid
      expect(dudecomment.errors[:post_id]).to_not be_empty
    end

    it 'has a comment' do
      dudecomment.comment = nil
      expect(dudecomment).to_not be_valid
      expect(dudecomment.errors[:comment]).to_not be_empty

    end

    it 'Creates a comment' do
      expect(dudecomment).to be_valid
    end
  end

  describe 'associations' do
    let (:acomment) {{user_id: 1, post_id:2, comment: "DJesus sucks at bowling"}}
    let (:dudecomment) {Comment.new(acomment)}

    let (:apost) {{user_id: 1, title: "It's a post!", body: "We need more white Russians"}}
    let (:dudepost) {Post.new(apost)}

    it 'belongs to a user' do
      expect(dudecomment.user_id).to eq 1
    end
    it 'belongs to a post' do
      expect(dudecomment.user_id).to eq dudepost.user_id
    end

  end
end
