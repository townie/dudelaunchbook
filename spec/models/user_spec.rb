require 'spec_helper'

describe User do

    context "-creation-" do
      let(:dude) {{ first_name: 'Dude', last_name: 'lebowski', email: "thedude@gmail.com", ee: true }}

      let(:dudeObject) { User.new(dude) }

      it "requires a first_name" do
        dudeObject.first_name = nil
        expect(dudeObject).to_not be_valid
        expect(dudeObject.errors[:first_name]).to_not be_empty
      end


      it "requires a last_name" do
        dudeObject.last_name = nil
        expect(dudeObject).to_not be_valid
        expect(dudeObject.errors[:last_name]).to_not be_empty
      end

      it "requires a email" do
        dudeObject.email = nil
        expect(dudeObject).to_not be_valid
        expect(dudeObject.errors[:email]).to_not be_empty
      end

      it "requires a EE status" do
        dudeObject.ee = nil
        expect(dudeObject).to_not be_valid
        expect(dudeObject.errors[:ee]).to_not be_empty
      end

      it "can have a funfact" do
        dudeObject.funfact = "Favorite drink: White Russian"
        expect(dudeObject).to be_valid
        expect(dudeObject.errors[:funfact]).to be_empty
      end

      it "requires successfully creates when all fields are full" do
        expect(dudeObject).to be_valid
      end

    end

    context '-assocations-' do

    let(:dude) {{first_name: 'Dude', last_name: 'lebowski', email: "thedude@gmail.com", ee: true }}
    let!(:dudeObject) { User.create(dude) }


    let(:stuff) {{ name: 'Bowling for good', creator: dudeObject.id, description: "Bowling is fun!", grouptype: "interest"}}
    let!(:bowling) {Group.create(stuff)}

    let(:drank) {{ name: 'Saturday Night Drinks', creator: dudeObject.id, description: "Social Club!", grouptype: "interest"}}
    let!(:drinking) {Group.create(drank)}

    let(:assoc) {{ user_id: dudeObject.id, group_id: drinking.id}}
    let!(:as) {UserGroup.create(assoc)}

    let(:associ) {{ user_id: dudeObject.id, group_id: drinking.id}}
    let!(:ass) {UserGroup.create(associ)}

    let(:yeah) {{title: "djesus!!!!!", body: "The dude does not approve", user_id: dudeObject.id, group_id: bowling.id }}
    let!(:djesuspost) {Post.create(yeah)}


    let (:valid_params) {{user_id: dudeObject.id, post_id: djesuspost.id, comment: "DJesus sucks at bowling"}}
    let! (:dudecomment) {Comment.create(valid_params)}

      it 'has many posts' do
        expect(dudeObject.posts.count).to eq 1
      end

      it 'has many groups' do
        expect(dudeObject.groups.count).to eq 2
      end

      it 'allows user to make posts' do
        expect(dudeObject.posts.count).to eq 1
      end
      it 'allows user to create groups' do
        expect(drinking.creator).to eq(dudeObject.id)
      end

      it 'allows user to make comments' do
        expect(dudeObject.comments.count).to eq 1
      end
  end

  context 'Instance methods' do
    # write tests for a InterestGroup#number_of_posts method
      let(:dude) {{first_name: 'Dude', last_name: 'lebowski', email: "thedude@gmail.com", ee: true }}
      let!(:dudeObject) { User.create(dude) }

      let(:valid_params) {{ name: 'Bowling for good', creator: 1, description: "Bowling is fun!", grouptype: "interest"}}
      let!(:bowling) {Group.create(valid_params)}
      let(:valids) {{ name: 'White Russian Enthuastis', creator: 1, description: "Bowling is fun!", grouptype: "interest"}}
      let!(:whiteR) {Group.create(valids)}

       let(:params) {{ user_id: dudeObject.id, group_id: bowling.id }}
      let!(:yougroup) {UserGroup.create(params) }
      let(:params1) {{ user_id: dudeObject.id, group_id: whiteR.id }}
      let!(:yougroup2) {UserGroup.create(params1) }

      let(:dejuss) {{title: "djesus!!!!!", body: "The dude does not approve", user_id: dudeObject.id, group_id: bowling.id }}
      let!(:djesuspost) {Post.create(dejuss)}

          let (:acomment) {{user_id: dudeObject.id, post_id:djesuspost.id, comment: "DJesus sat boucks wling"}}
          let! (:dudecomment) {Comment.create(acomment)}
           let (:bcomment) {{user_id: dudeObject.id, post_id:djesuspost.id, comment: "DJesus sucks at bowling"}}
          let! (:dudeacomment) {Comment.create(bcomment)}
           let (:ccomment) {{user_id: dudeObject.id, post_id:djesuspost.id, comment: "DJesus suc owbks atling"}}
          let! (:dudebcomment) {Comment.create(ccomment)}



      let(:hardcode) {{title: "hard code", body: "The dude does not approve", user_id: dudeObject.id, group_id: bowling.id }}
      let!(:hcpost) {Post.create(hardcode)}
          let (:dcomment) {{user_id: dudeObject.id, post_id:hcpost.id, comment: "DJesus sucks aling"}}
          let! (:hccomment1) {Comment.create(dcomment)}
           let (:ecomment) {{user_id: dudeObject.id, post_id:hcpost.id, comment: "DJesus su bowling"}}
          let! (:eccomment1) {Comment.create(ecomment)}

            # The names of all the groups they belong to
    # The number of posts they've made
    # The number of comments they've made

      it 'Returns the names of groups the user belongs to' do
          expect(dudeObject.show_groups).to eq(['Bowling for good', 'White Russian Enthuastis'])
      end

      it 'Returns the number of posts the user has made' do
          expect(dudeObject.count_number_of_posts).to eq(2)
      end

      it 'Returns the number of comments the user has made' do
          expect(dudeObject.count_number_of_comments).to eq(5)
      end

    end
end
