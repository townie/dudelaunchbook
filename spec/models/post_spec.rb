require 'spec_helper'

describe Post do
  context '-creatation-' do

    let(:valid_params) {{title: "I AM THE BEST AT BOWLING", body: "DJesus rocks the floor all night long!", user_id: '1'}}
    let(:djesuspost) {Post.new(valid_params)}

    it 'requires a title' do
      djesuspost.title = ""
      expect(djesuspost).to_not be_valid
      expect(djesuspost.errors[:title]).to_not be_blank
    end

    it 'requires a body' do
      djesuspost.body = ""
      expect(djesuspost).to_not be_valid
      expect(djesuspost.errors[:body]).to_not be_blank
    end

    it 'is created when all fields are valid' do
      expect(djesuspost.save).to be_true
      expect(djesuspost.errors[:body]).to be_blank
    end

  end

  context "-assocations-" do

    let(:dude) {{first_name: 'Dude', last_name: 'lebowski', email: "thedude@gmail.com", ee: true }}
    let!(:dudeObject) { User.create(dude) }


    let(:stuff) {{ name: 'Bowling for good', creator: 1, description: "Bowling is fun!", grouptype: "interest"}}
    let!(:bowling) {Group.create(stuff)}


    let(:yeah) {{title: "djesus!!!!!", body: "The dude does not approve", user_id: dudeObject.id, group_id: bowling.id }}
    let!(:djesuspost) {Post.create(yeah)}


    let (:valid_params) {{user_id: dudeObject.id, post_id: djesuspost.id, comment: "DJesus sucks at bowling"}}
    let! (:dudecomment) {Comment.create(valid_params)}

    it 'allows a user to post in a group' do
      expect(dudeObject.posts.count).to eq(1)
    end

    it 'allows a user to comment on a post in a group' do
      expect(dudeObject.comments.count).to eq(1)
    end

    it "allows a user to comment on a post" do
      expect(djesuspost.comments.count).to eq(1)
    end


  end

end
