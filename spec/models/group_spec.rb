require 'spec_helper'
require "pry-rails"

describe Group do
  context '-creation-' do
    let(:valid_params) {{name: 'Bowling for good', creator: 1, description: "Bowling is fun!", grouptype: "interest"}}
    let(:bowling) {Group.new(valid_params)}

    it 'requires a name' do
      bowling.name = ''
      expect(bowling).to_not be_valid
      expect(bowling.errors[:name]).to_not be_empty
    end

    it 'requires a creator' do
      bowling.creator = ''
      expect(bowling).to_not be_valid
      expect(bowling.errors[:creator]).to_not be_empty

    end
    it 'requires grouptype "interest" or "individual"' do
      bowling.grouptype = 'not a group type'
      expect(bowling).to_not be_valid
      expect(bowling.errors[:grouptype]).to_not be_empty
    end

    it 'creates a group when all fields are valid' do
      expect(bowling).to be_valid
      expect(bowling.errors[:grouptype]).to be_empty
    end

  end


  context '-associations-' do

    let(:dude) {{first_name: 'Dude', last_name: 'lebowski', email: "thedude@gmail.com", ee: true }}
    let!(:dudeObject) { User.create(dude) }

    let(:valid_params) {{ name: 'Bowling for good', creator: 1, description: "Bowling is fun!", grouptype: "interest"}}
    let!(:bowling) {Group.create(valid_params)}

    let(:params) {{ user_id: dudeObject.id, group_id: bowling.id }}
    let!(:yougroup) {UserGroup.create(params) }

    it 'user has many a group' do

      expect(dudeObject.groups.count).to eq(1 )
    end

    it 'group has many a user' do
      expect(bowling.users.count).to eq(1 )
    end

  end

  context 'Instance methods' do
  # write tests for a InterestGroup#number_of_posts method
    let(:dude) {{first_name: 'Dude', last_name: 'lebowski', email: "thedude@gmail.com", ee: true }}
    let!(:dudeObject) { User.create(dude) }

    let(:valid_params) {{ name: 'Bowling for good', creator: 1, description: "Bowling is fun!", grouptype: "interest"}}
    let!(:bowling) {Group.create(valid_params)}

    let(:params) {{ user_id: dudeObject.id, group_id: bowling.id }}
    let!(:yougroup) {UserGroup.create(params) }

    let(:dejuss) {{title: "djesus!!!!!", body: "The dude does not approve", user_id: dudeObject.id, group_id: bowling.id }}
    let!(:djesuspost) {Post.create(dejuss)}

    let (:acomment) {{user_id: dudeObject.id, post_id:djesuspost.id, comment: "DJesus sat boucks wling"}}
    let! (:dudecomment) {Comment.create(acomment)}
    let (:bcomment) {{user_id: dudeObject.id, post_id:djesuspost.id, comment: "DJesus sucks at bowling"}}
    let! (:dudeacomment) {Comment.create(bcomment)}
    let (:ccomment) {{user_id: dudeObject.id, post_id:djesuspost.id, comment: "DJesus suc owbks atling"}}
    let! (:dudebcomment) {Comment.create(ccomment)}



    let(:hardcode) {{title: "hard code", body: "The dude does not approve", user_id: dudeObject.id, group_id: bowling.id }}
    let!(:hcpost) {Post.create(yeah)}
    let (:dcomment) {{user_id: dudeObject.id, post_id:hcpost.id, comment: "DJesus sucks aling"}}
    let! (:hccomment1) {Comment.create(dcomment)}
    let (:ecomment) {{user_id: dudeObject.id, post_id:hcpost.id, comment: "DJesus su bowling"}}
    let! (:eccomment1) {Comment.create(ecomment)}



    let(:yeah) {{title: "yeah" ,body: "The dude does not approve", user_id: dudeObject.id, group_id: bowling.id }}
    let!(:ghetto) {Post.create(yeah)}
    let (:yeaha) {{user_id: dudeObject.id, post_id:ghetto.id, comment: "DJet bowling"}}
    let! (:gccomment1) {Comment.create(yeaha)}


    let(:woot) {{title: "woot", body: "The dude does not approve", user_id: dudeObject.id, group_id: bowling.id }}
    let!(:sup) {Post.create(woot)}

    describe '#number_of_posts' do
      it 'returns the number of posts' do
        expect(bowling.number_of_posts).to eq 4
      end

      it 'returns 0 if there are no posts' do
        expect(Group.create({ name: 'Bowlin good', creator: 2, description: "Bowling is fun!", grouptype: "interest"}).number_of_posts).to eq 0
      end
#The top 3 most popular posts (determined by the number of comments)

      it 'returns the top number of posts based on comments, specific number' do
        expect(bowling.top_posts(3)).to eq [djesuspost, hcpost, ghetto]
        expect(bowling.top_posts(2)).to eq [djesuspost, hcpost]
        expect(bowling.top_posts(1)).to eq [djesuspost]
      end
      # etc.
    end
end

end
